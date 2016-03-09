//
//  OrderDetailWebVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "OrderDetailWebVC.h"
#import "NetWorkHandler+initOrderShare.h"
#import "SBJson.h"
#import "MyJSInterface.h"
#import "define.h"
#import "KGStatusBar.h"
@interface OrderDetailWebVC ()<MyJSInterfaceDelegate, UIWebViewDelegate>

@end

@implementation OrderDetailWebVC

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        _urlPath = nil;
//        platType = SSDKPlatformTypeUnknown;
        tagNum = -1;
    }
    
    return self;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    MyJSInterface* interface = [MyJSInterface new];
    interface.delegate = self;
    [self.webview addJavascriptInterfaces:interface WithName:@"appClient"];
}

- (void) NotifyShareWindow
{
    [self handleRightBarButtonClicked:nil];
}

- (void) initShareUrl:(NSString *) orderId insuranceType:(NSString *) insuranceType planOfferId:(NSString *) planOfferId
{
    _orderId = orderId;
    _insuranceType = insuranceType;
    _planOfferId = planOfferId;
}

- (void) loadUrl
{
    [NetWorkHandler requestToInitOrderShare:_orderId insuranceType:_insuranceType planOfferId:_planOfferId Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            _urlPath = [[content objectForKey:@"data"] objectForKey:@"url"];
            self.shareContent = [[content objectForKey:@"data"] objectForKey:@"content"];
            self.shareTitle = [[content objectForKey:@"data"] objectForKey:@"title"];
            self.phone = [[content objectForKey:@"data"] objectForKey:@"phone"];
            if([[content objectForKey:@"data"] objectForKey:@"imgUrl"])
                self.shareImgArray = [NSArray arrayWithObject:[[content objectForKey:@"data"] objectForKey:@"imgUrl"]];
            if(tagNum >= 0)
                [self HandleItemSelect:nil withTag:tagNum];
        }
    }];
}

#pragma delegate
- (void) HandleItemSelect:(PopView *) view withTag:(NSInteger) tag
{
    tagNum = tag;
    if(_urlPath != nil){
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
    }else{
        [self loadUrl];
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
        
        if(type == SSDKPlatformTypeSMS){
            NSString *jsonstr = [self getShareContent];
            SBJsonParser *_parser = [[SBJsonParser alloc] init];
            NSDictionary *dic = [_parser objectWithString:jsonstr];
            NSArray *array = nil;
            if(self.phone)
                array = [NSArray arrayWithObject:self.phone];
            NSString *content = [dic objectForKey:@"sms"];
            if(content == nil)
                content = @"";
            [shareParams SSDKSetupSMSParamsByText:content title:nil images:nil attachments:nil recipients:array type:SSDKContentTypeAuto];
        }
        else{
            [shareParams SSDKSetupShareParamsByText:self.shareContent
                                             images:self.shareImgArray
                                                url:[NSURL URLWithString:_urlPath]
                                              title:self.shareTitle
                                               type:SSDKContentTypeAuto];
        }
        
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

- (NSString *) getShareContent
{
    NSString *str = [self.webview stringByEvaluatingJavaScriptFromString:@"loadSmsContent();"];
    return str;
}

@end
