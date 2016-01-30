//
//  WXLoginVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/4.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "WXLoginVC.h"
#import <ShareSDKExtension/SSEThirdPartyLoginHelper.h>
#import "define.h"
#import "NetWorkHandler+login.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudSNS/AVOSCloudSNS.h>

@interface WXLoginVC ()

@end

@implementation WXLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"微信登录";
    [self setLeftBarButtonWithImage:ThemeImage(@"shut")];
    
    UIColor *borderColor = _COLOR(0x27, 0xcf, 0x00);
    self.btnWechat.layer.cornerRadius = 3;
//    self.btnWechat.layer.borderWidth = 0.5;
//    self.btnWechat.layer.borderColor = borderColor.CGColor;
    self.btnWechat.backgroundColor = borderColor;
//    [self.btnWechat setTitleColor:borderColor forState:UIControlStateNormal];
    [self.btnWechat setImage:ThemeImage(@"wechat_logo") forState:UIControlStateNormal];
    [self.btnWechat addTarget:self action:@selector(addAccountClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view bringSubviewToFront:self.btnWechat];
    [self.view bringSubviewToFront:self.lbAgreement];
    
    self.lbAgreement.attributedText = [Util getAttributeString:@"点击“登录”，即表示您同意用户协议" substr:@"用户协议"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) handleLeftBarButtonClicked:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

//微信登录
//授权登录按钮点击处理方法
- (void)addAccountClickHandler:(id)sender
{
    //    __weak loginViewController *theController = self;
    [SSEThirdPartyLoginHelper loginByPlatform:SSDKPlatformSubTypeWechatSession
                                   onUserSync:^(SSDKUser *user, SSEUserAssociateHandler associateHandler) {
                                       
                                       //在此回调中可以将社交平台用户信息与自身用户系统进行绑定，最后使用一个唯一用户标识来关联此用户信息。
                                       //在此示例中没有跟用户系统关联，则使用一个社交用户对应一个系统用户的方式。将社交用户的uid作为关联ID传入associateHandler。
                                       associateHandler (user.uid, user, user);
                                       NSDictionary *rawData = user.rawData;
                                       [self loginWithDictionary:rawData];
                                       
                                       
                                   }
                                onLoginResult:^(SSDKResponseState state, SSEBaseUser *user, NSError *error) {
                                    
                                    if (state == SSDKResponseStateSuccess)
                                    {
                                        //判断是否已经在用户列表中，避免用户使用同一账号进行重复登录
                                    }
                                    
                                }];
}

- (void) loginWithDictionary:(NSDictionary *)dic
{
    [NetWorkHandler loginWithPhone:nil openId:[dic objectForKey:@"openid"] sex:[[dic objectForKey:@"sex"] integerValue] nickname:[dic objectForKey:@"nickname"] privilege:[dic objectForKey:@"privilege"] unionid:[dic objectForKey:@"unionid"] province:[dic objectForKey:@"province"] language:[dic objectForKey:@"language"] headimgurl:[dic objectForKey:@"headimgurl"] city:[dic objectForKey:@"city"] country:[dic objectForKey:@"country"] smCode:nil Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 505){
            BindPhoneNumVC *vc = [IBUIFactory CreateBindPhoneNumViewController];
            [self.navigationController pushViewController:vc animated:YES];
            vc.wxDic = dic;
        }else if (code == 200){
            NSDictionary *data = [content objectForKey:@"data"];
            UserInfoModel *userinfo = [UserInfoModel shareUserInfoModel];
            userinfo.isLogin = YES;
            [userinfo setContentWithDictionary:data];
            [userinfo queryUserInfo];
            [self handleLeftBarButtonClicked:nil];
            
            AVInstallation *currentInstallation = [AVInstallation currentInstallation];
            [currentInstallation addUniqueObject:@"ykbbrokerLoginUser" forKey:@"channels"];
            [currentInstallation addUniqueObject:[UserInfoModel shareUserInfoModel].userId forKey:@"channels"];
            [currentInstallation saveInBackground];
        }
    }];
}

- (IBAction)doBtnAgreementInfo:(id)sender
{
    WebViewController *web = [IBUIFactory CreateWebViewController];
    web.title = @"用户协议";
    [self.navigationController pushViewController:web animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@%@%@", SERVER_ADDRESS, @"/news/view/", User_Agreement];
    [web loadHtmlFromUrl:url];
}

@end
