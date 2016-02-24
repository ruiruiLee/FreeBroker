//
//  BindPhoneNumVC.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/28.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "BaseViewController.h"
#import "KGStatusBar.h"

@interface BindPhoneNumVC : BaseViewController<UITextFieldDelegate>
{
    NSTimer *_timerOutTimer;
    NSInteger _count;
}

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *viewHConstraint;

@property (nonatomic, strong) IBOutlet UITextField *tfMobile;
@property (nonatomic, strong) IBOutlet UITextField *tfCaptcha;//验证码
@property (nonatomic, strong) IBOutlet UIButton *btnGetCaptcha;
@property (nonatomic, strong) IBOutlet UIButton *btnSubmit;

@property (nonatomic, copy) NSDictionary *wxDic;

- (void) btnGainVerifyCode:(id)sender;
- (void) btnLoginUseVerifyCode:(id)sender;
- (void) loginWithDictionary:(NSDictionary *)dic phone:(NSString *) phone smCode:(NSString *)smCode;
- (void)TimerOutTimer;

@end
