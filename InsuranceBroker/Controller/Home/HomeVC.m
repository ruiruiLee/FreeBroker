//
//  HomeVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/18.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "HomeVC.h"
#import "define.h"
#import "NoticeListVC.h"
#import "InviteFriendsVC.h"
#import "AgentStrategyViewController.h"
#import "NetWorkHandler+index.h"
#import "PosterModel.h"
#import "HaedlineModel.h"
#import "UIButton+WebCache.h"
#import "WebViewController.h"
#import "SelectCustomerVC.h"
#import "AppDelegate.h"

@interface HomeVC ()
{
    AppDelegate *appdelegate;
}

@property (nonatomic, strong)  NSString *customerService;

@end

@implementation HomeVC

- (void) dealloc
{
    AppContext *context = [AppContext sharedAppContext];
    [context removeObserver:self forKeyPath:@"isNewMessage"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    appdelegate = [UIApplication sharedApplication].delegate;
    AppContext *context = [AppContext sharedAppContext];
    [context addObserver:self forKeyPath:@"isNewMessage" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
    UIImageView *logoView = [[UIImageView alloc] initWithImage:ThemeImage(@"logo")];
    self.navigationItem.titleView = logoView;
    [self setLeftBarButtonWithImage:nil];
    
    self.adView.PageControlShowStyle = UIPageControlShowStyleRight;
    self.adView.parentController = self;
    
    self.headline.delegate = self;
    self.headline.imgTitle.image = ThemeImage(@"Hot");
    
    self.btnAutoInsu.layer.borderColor = _COLOR(0xe6, 0xe6, 0xe6).CGColor;
    self.btnAutoInsu.layer.borderWidth = 0.5;
    self.btnInvit.layer.borderColor = _COLOR(0xe6, 0xe6, 0xe6).CGColor;
    self.btnInvit.layer.borderWidth = 0.5;
    
//    [self.btnAutoInsu setImage:ThemeImage(@"car") forState:UIControlStateNormal];
    [self.btnAutoInsu setTitle:@"车险算价" forState:UIControlStateNormal];
    self.btnAutoInsu.titleLabel.font = _FONT_B(18);
    self.btnAutoInsu.lbExplain.text = @"快速下单，掌握便捷比价";
//    [self.btnInvit setImage:ThemeImage(@"share") forState:UIControlStateNormal];
    [self.btnInvit setTitle:@"邀请好友" forState:UIControlStateNormal];
    self.btnInvit.titleLabel.font = _FONT_B(18);
    self.btnInvit.lbExplain.text = @"车险直销坐享多重收益";
    
    self.lbsepline1.backgroundColor = _COLOR(233, 233, 233);
    self.lbsepline2.backgroundColor = _COLOR(233, 233, 233);
    
    [self.btnNewUser setBackgroundImage:ThemeImage(@"banner") forState:UIControlStateNormal];
    //设置屏幕宽度
    self.scHConstraint.constant = ScreenWidth;
    
    self.headVConstraint.constant = 40;//[Util getHeightByWidth:375 height:40 nwidth:ScreenWidth];
    self.adVConstraint.constant = [Util getHeightByWidth:750 height:330 nwidth:ScreenWidth];
    //车险和邀请好友
    self.autoBgVConstraint.constant = ScreenWidth/2;
    //销售攻略背景视图
    //iphone6下为60
//    self.additionBgHConstraint.constant = ScreenWidth;
    self.additionBgVConstraint.constant = [Util getHeightByWidth:375 height:60 nwidth:ScreenWidth];
    //新用户福利
    //iphone6下为72
//    self.userNewHConstraint.constant = ScreenWidth;
    self.userNewVConstraint.constant = [Util getHeightByWidth:375 height:90 nwidth:ScreenWidth];
    
    self.scVConstraint.constant = self.headVConstraint.constant + self.adVConstraint.constant + 30 + ScreenWidth/2 + self.additionBgVConstraint.constant + self.userNewVConstraint.constant;
    
    self._btnMessage.imageView.clipsToBounds = NO;
    
    [self loadDatas];

}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    AppContext *con= [AppContext sharedAppContext];
    if(con.isNewMessage)
    {
        self._btnMessage.imageView.badgeView.badgeValue = 1;
    }else{
        self._btnMessage.imageView.badgeView.badgeValue = 0;
    }
}

- (void) loadDatas
{
    [NetWorkHandler requestToIndex:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            NSDictionary *d = [content objectForKey:@"data"];
            _adArray = [PosterModel modelArrayFromArray:[d objectForKey:@"poster"]];
            _headlineArray = [HeadlineModel modelArrayFromArray:[d objectForKey:@"headlines"]];
            _newUserModel = (NewUserModel*)[NewUserModel modelFromDictionary:[d objectForKey:@"newUser"]];
            appdelegate.customerBanner = (NewUserModel*)[NewUserModel modelFromDictionary:[d objectForKey:@"customerBanner"]];
            appdelegate.workBanner = (NewUserModel*)[NewUserModel modelFromDictionary:[d objectForKey:@"workBanner"]];
            appdelegate.inviteBanner = (NewUserModel*)[NewUserModel modelFromDictionary:[d objectForKey:@"friendBanner"]];
            self.customerService = [d objectForKey:@"customerService"];
            [self initData];
        }
    }];
}

- (void) initData
{
    self.adView.NewsmodelArray = _adArray;
    [self.headline reloadData];
    [self.btnNewUser sd_setBackgroundImageWithURL:[NSURL URLWithString:_newUserModel.imgUrl] forState:UIControlStateNormal placeholderImage:Normal_Image];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    CGRect frame1 = self.lbsepline1.frame;
    self.lbsepline1.frame = CGRectMake(frame1.origin.x, frame1.origin.y, 0.5, frame1.size.height);
    CGRect frame2 = self.lbsepline2.frame;
    self.lbsepline2.frame = CGRectMake(frame2.origin.x, frame2.origin.y, 0.5, frame2.size.height);
    CGRect frame3 = self.btnInvit.frame;

    self.scrollview.contentSize = CGSizeMake(ScreenWidth, self.scVConstraint.constant + 15);
    
    self.btnInvit.frame = CGRectMake(self.btnAutoInsu.frame.size.width - 0.5, frame3.origin.y, frame3.size.width, frame3.size.height);
}

#pragma HeadlineViewDelegate
- (void) headline:(HeadlineCell *)headline cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(headline != nil){
        HeadlineModel *model = [_headlineArray objectAtIndex:indexPath.row];
        
        headline.lbDetail.text = model.title;//[dic objectForKey:@"value"];
    }
}

- (void) headline:(HeadlineView *)headline SelectAtIndexPath:(NSIndexPath *)indexpath
{
    if([_headlineArray count] > 0){
        HeadlineModel *model = [_headlineArray objectAtIndex:indexpath.row];
        if(model && model.isRedirect){
            WebViewController *web = [IBUIFactory CreateWebViewController];
            web.hidesBottomBarWhenPushed = YES;
            web.title = model.title;
            web.type = enumShareTypeShare;
            web.shareTitle = model.title;
            [self.navigationController pushViewController:web animated:YES];
            
            if(model.url == nil){
                [web loadHtmlFromUrlWithUserId:[NSString stringWithFormat:@"%@%@%@", SERVER_ADDRESS, @"/news/view/", model.hid]];
            }else{
                [web loadHtmlFromUrlWithUserId:model.url];
            }
        }
    }
}

#pragma HeadlineViewDelegate
- (NSInteger) numberOfRows:(HeadlineView *)headline
{
    return [_headlineArray count];
}

- (IBAction) doBtnNoticeList:(id) sender
{
//    BOOL result = [self login];
    if(1){
        self._btnMessage.imageView.badgeView.badgeValue = 0;
        AppContext *context = [AppContext sharedAppContext];
        context.isNewMessage = NO;
        [context saveData];
        NoticeListVC *vc = [[NoticeListVC alloc] initWithNibName:nil bundle:nil];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction)doBtnInvite:(id)sender
{
    if([self login]){
        InviteFriendsVC *vc = [[InviteFriendsVC alloc] initWithNibName:nil bundle:nil];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (IBAction) doBtnAgentStrategy:(id)sender
{
//    BOOL result = [self login];
//    if(result){
    AgentStrategyViewController *vc = [[AgentStrategyViewController alloc] initWithNibName:nil bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
//    }
}

- (IBAction) doBtnMyService:(id)sender
{
    WebViewController *web = [IBUIFactory CreateWebViewController];
    web.hidesBottomBarWhenPushed = YES;
    web.title = @"我的客服";
    web.type = enumShareTypeNo;
    [self.navigationController pushViewController:web animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@%@%@", SERVER_ADDRESS, @"/news/customer/service/", self.customerService];
    [web loadHtmlFromUrl:url];
}

- (IBAction) doBtnNewUser:(id)sender
{
    if(_newUserModel && _newUserModel.isRedirect){
        WebViewController *web = [IBUIFactory CreateWebViewController];
        web.hidesBottomBarWhenPushed = YES;
        web.title = _newUserModel.title;
        web.type = enumShareTypeShare;
        if(_newUserModel.imgUrl != nil)
            web.shareImgArray = [NSArray arrayWithObject:_newUserModel.imgUrl];
        web.shareTitle = _newUserModel.title;
        [self.navigationController pushViewController:web animated:YES];
        
        if(_newUserModel.url == nil){
            [web loadHtmlFromUrlWithUserId:[NSString stringWithFormat:@"%@%@%@", SERVER_ADDRESS, @"/news/view/", _newUserModel.nid]];
        }else{
            [web loadHtmlFromUrlWithUserId:_newUserModel.url];
        }
    }
}

- (IBAction)doBtnSelectForInsur:(id)sender
{
    if([self login]){
        SelectCustomerVC *vc = [[SelectCustomerVC alloc] initWithNibName:nil bundle:nil];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
