//
//  WebViewController.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/16.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "WebViewController.h"
#import "define.h"
//#import "UIWebView+AFNetworking.h"
#import "NetWorkHandler+initOrderShare.h"
#import "EGOCache.h"
#import "KGStatusBar.h"
@interface WebViewController ()

@end

@implementation WebViewController
@synthesize popview;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.type = enumShareTypeNo;
        self.shareType = enumNeedInitShareInfoNo;
        self.shareImgArray = @[Share_Icon];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
//    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlpath]]];
    for (UIScrollView* view in self.webview.subviews)
    {
        if ([view isKindOfClass:[UIScrollView class]])
        {
            view.bounces = NO;
        }
    }
    self.webview.backgroundColor = [UIColor clearColor];
    [self.webview setOpaque:NO];
    
    if(self.type == enumShareTypeShare || self.type == enumShareTypeToCustomer){
        [self setRightBarButtonWithImage:ThemeImage(@"btn_share")];
    }
    _progressProxy = [[NJKWebViewProgress alloc] init];
    _webview.delegate = _progressProxy;
    _progressProxy.webViewProxyDelegate = self;
    _progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigaitonBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigaitonBarBounds.size.height - progressBarHeight, navigaitonBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.translatesAutoresizingMaskIntoConstraints = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_progressView removeFromSuperview];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(_urlpath != nil){
        
        id cacheDatas =[[EGOCache globalCache] objectForKey:[Util md5Hash:self.urlpath]];
        if (cacheDatas !=nil) {
            NSString *datastr = [[NSString alloc] initWithData:cacheDatas encoding:NSUTF8StringEncoding];
            [ _webview loadHTMLString:datastr baseURL:[NSURL URLWithString:self.urlpath]];
        }
       else{
           NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:self.urlpath]];
             [self addWebCache:request]; // 加缓存
            [_webview loadRequest:request];
        }
    }
}

- (void)addWebCache:(NSURLRequest *)request{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
        if (response != nil){
            // 加缓存
            [[EGOCache globalCache] setObject:response forKey: [Util md5Hash:self.urlpath]];
        }
    } );

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:_progressView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_progressView]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressView)]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_progressView(2)]->=0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_progressView)]];
}


#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];
}

- (void) loadHtmlFromUrlWithUserId:(NSString *) url
{
    if([UserInfoModel shareUserInfoModel].userId == nil){
        self.urlpath = url;
        self.shareUrl =  url;
    }
    else{
        self.urlpath = [NSString stringWithFormat:@"%@?userId=%@", url, [UserInfoModel shareUserInfoModel].userId];
        self.shareUrl = [NSString stringWithFormat:@"%@?userId=%@&appShare=1", url, [UserInfoModel shareUserInfoModel].userId];
    }
    
    if(self.webview)
        [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlpath]]];
}

- (void) loadHtmlFromUrl:(NSString *) url
{
    self.urlpath = url;
    self.shareUrl = url;
    if(self.webview)
        [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlpath]]];
}

- (void) loadCacheHtmlFromUrl:(NSString *)url
{
    self.urlpath = url;
    if(self.webview)
        [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
//        [self.webview]
}

- (void) handleRightBarButtonClicked:(id)sender
{
    if(self.type == enumShareTypeShare)
        [self showPopView];
    else if(self.type == enumShareTypeToCustomer)
        [self showPopView1];
}

- (void) showPopView
{
    if(!popview){
        popview = [[PopView alloc] initWithImageArray:@[@"wechat", @"moments", @"qq", @"qzone"] nameArray:@[@"微信好友", @"朋友圈", @"QQ好友", @"QQ空间"]];
        [self.view.window addSubview:popview];
        popview.delegate = self;
    }
    
    [popview show];
}

- (void) showPopView1
{
    if(!popview){
        popview = [[PopView alloc] initWithImageArray:@[@"wechat", @"share_message"] nameArray:@[@"微信好友", @"手机短信"]];
        [self.view.window addSubview:popview];
        popview.delegate = self;
    }
    
    [popview show];
}


#pragma delegate
- (void) HandleItemSelect:(PopView *) view withTag:(NSInteger) tag
{
    if(self.type == enumShareTypeToCustomer){
        if(tag == 0)
            [self simplyShare:SSDKPlatformSubTypeWechatSession];
        else{
            [self simplyShare:SSDKPlatformTypeSMS];
        }
    }else if (self.type == enumShareTypeShare){
        switch (tag) {
            case 0:
            {
                [self simplyShare:SSDKPlatformSubTypeWechatSession];
            }
                break;
            case 1:
            {
                [self simplyShare:SSDKPlatformSubTypeWechatTimeline];
            }
                break;
            case 2:
            {
                [self simplyShare:SSDKPlatformSubTypeQQFriend];
            }
                break;
            case 3:
            {
                [self simplyShare:SSDKPlatformSubTypeQZone];
            }
                break;
            default:
                break;
        }
    }
}

/**
 *  简单分享
 */
- (void)simplyShare:(SSDKPlatformType) type
{
    /**
     * 在简单分享中，只要设置共有分享参数即可分享到任意的社交平台
     **/
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    if(self.shareImgArray == nil || [self.shareImgArray count] == 0)
        self.shareImgArray = @[Share_Icon];
        
    
    if (self.shareImgArray) {
        
//        UserInfoModel *model = [UserInfoModel shareUserInfoModel];
//        NSString *title = [NSString stringWithFormat:@"我是%@，邀请你也加入优快保自由经纪人", model.nickname];
        
        [shareParams SSDKSetupShareParamsByText:self.shareContent
                                         images:self.shareImgArray
                                            url:[NSURL URLWithString:self.shareUrl]
                                          title:self.shareTitle
                                           type:SSDKContentTypeAuto];
        
        //进行分享
        [ShareSDK share:type
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             
             switch (state) {
                 case SSDKResponseStateSuccess:
                 {
                     [KGStatusBar showSuccessWithStatus:@"分享成功"];
                     break;
                 }
                 case SSDKResponseStateFail:
                 {
                     [KGStatusBar showSuccessWithStatus:@"分享失败"];
                     break;
                 }
                 case SSDKResponseStateCancel:
                 {
                     
                     [KGStatusBar showSuccessWithStatus:@"分享已取消"];
                     break;
                 }
                 default:
                     break;
             }
         }];
    }
}

//- (void) initShareUrl:(NSString *) orderId insuranceType:(NSString *) insuranceType planOfferId:(NSString *) planOfferId
//{
//    [NetWorkHandler requestToInitOrderShare:orderId insuranceType:insuranceType planOfferId:planOfferId Completion:^(int code, id content) {
//        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
//        if(code == 200){
//            self.shareUrl = [content objectForKey:@"data"];
//        }
//    }];
//}

@end
