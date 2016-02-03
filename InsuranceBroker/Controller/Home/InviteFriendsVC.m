//
//  InviteFriendsVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/31.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "InviteFriendsVC.h"
#import "UIButton+WebCache.h"
#import "KGStatusBar.h"
#import "define.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKExtension/SSEShareHelper.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import <ShareSDKUI/SSUIShareActionSheetStyle.h>
#import <ShareSDKUI/SSUIShareActionSheetCustomItem.h>
#import <ShareSDK/ShareSDK+Base.h>

#import <ShareSDKExtension/ShareSDK+Extension.h>
//#import "NetWorkHandler+queryOrderShareInfo.h"

@interface InviteFriendsVC ()

@end

@implementation InviteFriendsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"邀请好友";
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 15 + [Util getHeightByWidth:375 height:90 nwidth:ScreenWidth])];
    header.clipsToBounds = YES;
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [Util getHeightByWidth:375 height:90 nwidth:ScreenWidth])];
    [header addSubview:btn];
    [btn setImage:Normal_Image forState:UIControlStateNormal];
    UIImageView *imagev = [[UIImageView alloc] initWithFrame:CGRectMake(0, [Util getHeightByWidth:375 height:90 nwidth:ScreenWidth], ScreenWidth, 15)];
    [header addSubview:imagev];
//    imagev.image = ThemeImage(@"shadow");
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    NewUserModel *model = appdelegate.inviteBanner;
    if(model == nil || model.imgUrl == nil){
        header.frame = CGRectMake(0, 0, ScreenWidth, 15);
        btn.frame = CGRectMake(0, 0, 0, 0);
        imagev.frame = CGRectMake(0, 0, ScreenWidth, 15);
    }
    else{
        [btn sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] forState:UIControlStateNormal placeholderImage:Normal_Image];
        [btn addTarget:self action:@selector(doBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        if(!model.isRedirect){
            btn.userInteractionEnabled = NO;
        }
    }
    
    self.tableview.tableHeaderView = header;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableview setSeparatorInset:insets];
    }
    if ([self.tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableview setLayoutMargins:insets];
    }
}

- (void) doBtnClicked:(UIButton *)sender
{
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    NewUserModel *model = appdelegate.inviteBanner;
    if(model.isRedirect){
        WebViewController *web = [IBUIFactory CreateWebViewController];
        web.title = model.title;
        [self.navigationController pushViewController:web animated:YES];
        if(model.url){
            [web loadHtmlFromUrl:model.url];
        }else{
            NSString *url = [NSString stringWithFormat:@"%@%@%@", SERVER_ADDRESS, @"/news/view/", model.nid];
            [web loadHtmlFromUrl:url];
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
        cell.textLabel.font = _FONT(15);
        cell.textLabel.textColor = _COLOR(0x21, 0x21, 0x21);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    switch (indexPath.row) {
        case 0:
        {
            [self setContentWithCell:cell image:ThemeImage(@"invite_wechat") title:@"微信好友邀请"];
        }
            break;
        case 1:
        {
            [self setContentWithCell:cell image:ThemeImage(@"invite_moments") title:@"朋友圈邀请"];
        }
            break;
        case 2:
        {
            [self setContentWithCell:cell image:ThemeImage(@"invite_message") title:@"通信录短信邀请"];
        }
            break;
        case 3:
        {
            [self setContentWithCell:cell image:ThemeImage(@"invite_QR_code") title:@"面对面扫码邀请"];
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    switch (indexPath.row) {
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
            [self simplyShare:SSDKPlatformTypeSMS];
        }
            break;
        case 3:
        {
            QRCodeVC *vc = [IBUIFactory CreateQRCodeViewController];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:insets];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:insets];
    }
}

- (void) setContentWithCell:(UITableViewCell *)cell image:(UIImage *)image title :(NSString *) title
{
    cell.imageView.image = image;
    cell.textLabel.text = title;
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
    
    NSArray* imageArray = @[[UIImage imageNamed:@"icon.png"]];
    
    if (imageArray) {
        
        UserInfoModel *model = [UserInfoModel shareUserInfoModel];
        NSString *url = [NSString stringWithFormat:@"%@", model.qrcodeAddr];
        NSString *title = [NSString stringWithFormat:@"我是%@，邀请你加入优快保自由经纪人", model.nickname];
        if(type == SSDKPlatformTypeSMS){
            title = [NSString stringWithFormat:@"我在优快保做自由经纪人。现在邀请你也加入，共同赚取丰厚佣金，体验一下吧！http://wap.youkuaibao.com"];
            [shareParams SSDKSetupShareParamsByText:title
                                             images:nil
                                                url:nil
                                              title:nil
                                               type:SSDKContentTypeAuto];
        }
        else
            [shareParams SSDKSetupShareParamsByText:@"赶快下载自由经纪人app，零门槛，自由兼职也能月入10000+"
                                             images:imageArray
                                                url:[NSURL URLWithString:url]
                                              title:title
                                               type:SSDKContentTypeAuto];
        
        //进行分享
        [ShareSDK share:type
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             
//             [theController showLoadingView:NO];
//             [theController.tableView reloadData];
             
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


@end
