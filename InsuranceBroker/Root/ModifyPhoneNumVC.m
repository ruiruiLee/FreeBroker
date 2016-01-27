//
//  ModifyPhoneNumVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/15.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "ModifyPhoneNumVC.h"
#import "NetWorkHandler+modifyUserInfo.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudSNS/AVOSCloudSNS.h>
#import "define.h"

@implementation ModifyPhoneNumVC

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setBackBarButton];
}

- (void) loginWithDictionary:(NSDictionary *)dic phone:(NSString *) phone smCode:(NSString *)smCode
{
    UserInfoModel *user = [UserInfoModel shareUserInfoModel];
    [AVOSCloud verifySmsCode:smCode mobilePhoneNumber:phone callback:^(BOOL succeeded, NSError *error) {
        if(error == nil){
            [NetWorkHandler requestToModifyuserInfo:user.userId realName:nil userName:nil phone:phone cardNumber:nil cardNumberImg1:nil cardNumberImg2:nil liveProvinceId:nil liveCityId:nil liveAreaId:nil liveAddr:nil userSex:nil headerImg:nil Completion:^(int code, id content) {
                [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
                if(code == 200){
                    user.phone = phone;
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];
        }
        else{
            
            long code = [[error.userInfo objectForKey:@"code"] longValue];
            if(code == 1){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"无效的验证码！" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [alert show];
            }else
                [Util showAlertMessage:@"网络连接异常，请检查网络设置！" ];
        }
    }];
}



- (void) btnGainVerifyCode:(id)sender
{
    [self.tfMobile resignFirstResponder];
    [self.tfCaptcha resignFirstResponder];
    self.btnGetCaptcha.enabled = NO;
    self.btnGetCaptcha.backgroundColor = _COLORa(0xff, 0x66, 0x19, 0.5);
    NSString *phone = self.tfMobile.text;

    [AVOSCloud requestSmsCodeWithPhoneNumber:phone callback:^(BOOL succeeded, NSError *error) {
        if(succeeded){
            [self TimerOutTimer];
            [Util showAlertMessage:@"验证码已发送!" ];
        }else{
            [Util showAlertMessage:error.localizedDescription];
            [self.btnGetCaptcha setTitle:@"重取验证码" forState:UIControlStateNormal];
            self.btnGetCaptcha.backgroundColor = _COLORa(0xff, 0x66, 0x19, 1);
            self.btnGetCaptcha.enabled = YES;
        }
    }];
}

@end
