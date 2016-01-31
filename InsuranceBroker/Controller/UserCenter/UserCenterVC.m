//
//  UserCenterVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/18.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "UserCenterVC.h"
#import "define.h"
#import "UserSettingVC.h"
#import "UserInfoModel.h"
#import "UIImageView+WebCache.h"
#import "MyTeamsVC.h"
#import "DetailAccountVC.h"

@implementation UserCenterVC

- (void) dealloc
{
    UserInfoModel *model = [UserInfoModel shareUserInfoModel];
    [model removeObserver:self forKeyPath:@"headerImg"];
    [model removeObserver:self forKeyPath:@"cardVerifiy"];
    [model removeObserver:self forKeyPath:@"sex"];
    [model removeObserver:self forKeyPath:@"nickname"];
    AppContext *context = [AppContext sharedAppContext];
    [context removeObserver:self forKeyPath:@"isRedPack"];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.photoImgV.layer.cornerRadius = 45;
    self.logoImgv.layer.cornerRadius = 9;
    self.photoImgV.backgroundColor = [UIColor whiteColor];
    
    self.photoImgV.clipsToBounds = YES;
    self.photoImgV.layer.cornerRadius = 45;
    self.lbRedLogo.clipsToBounds = YES;
    self.lbRedLogo.layer.cornerRadius = 4;
    self.redFlagConstraint.constant = -((ScreenWidth - 320)/2 + 50);
    
    
    self.headHConstraint.constant = ScreenWidth;
    
    UserInfoModel *model = [UserInfoModel shareUserInfoModel];
    AppContext *context = [AppContext sharedAppContext];
    [model addObserver:self forKeyPath:@"headerImg" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    [model addObserver:self forKeyPath:@"cardVerifiy" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    [model addObserver:self forKeyPath:@"sex" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    [model addObserver:self forKeyPath:@"nickname" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    [context addObserver:self forKeyPath:@"isRedPack" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
    [self updateUserInfo];
}

- (void) updateUserInfo
{
    UserInfoModel *model = [UserInfoModel shareUserInfoModel];
    
    self.lbMonthOrderSuccessNums.text = [NSString stringWithFormat:@"%d", model.monthOrderSuccessNums];
    self.lbTotalOrderSuccessNums.text = [NSString stringWithFormat:@"累计订单：%d单", model.orderSuccessNums];
    self.lbMonthOrderEarn.text = [NSString stringWithFormat:@"%.2f", model.monthOrderEarn];
    self.lbOrderEarn.text = [NSString stringWithFormat:@"累计收益：%.2f元", model.orderEarn];
    self.lbUserInvite.text = [NSString stringWithFormat:@"%d人", model.userInviteNums];
    self.lbTeamTotal.text = [NSString stringWithFormat:@"%d人", model.userTeamInviteNums];
    
    [self.btNameEdit setTitle:model.nickname forState:UIControlStateNormal];
    UIImage *placeholderImage = ThemeImage(@"head_male");
    if(model.sex == 2)
        placeholderImage = ThemeImage(@"head_famale");
    [self.photoImgV sd_setImageWithURL:[NSURL URLWithString:model.headerImg] placeholderImage:placeholderImage];
    
    if(model.leader == 1){
        self.lbRole.text = @"团长";
        self.logoImgv.image = ThemeImage(@"leader");
    }else
    {
        self.logoImgv.image = ThemeImage(@"member");
        self.lbRole.text = @"个人";
    }
    
    self.lbCertificate.textColor = _COLOR(0xf4, 0x43, 0x36);
    if(model.cardVerifiy == 1){
        self.lbCertificate.text = @"认证中";
        self.lbCertificate.textColor = _COLOR(53, 202, 100);
    }
    else if (model.cardVerifiy == 2){
        self.lbCertificate.text = @"认证失败";
    }
    else if (model.cardVerifiy == 3){
        self.lbCertificate.text = @"已认证";
        self.lbCertificate.textColor = _COLOR(53, 202, 100);
    }else{
        self.lbCertificate.text = @"未认证";
    }
    
    if([AppContext sharedAppContext].isRedPack){
        self.lbRedLogo.hidden = NO;
    }else{
        self.lbRedLogo.hidden = YES;
    }
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self updateUserInfo];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    UserInfoModel *model = [UserInfoModel shareUserInfoModel];
    if(model.cardVerifiy == 1)
    {
        [model queryUserInfo];
    }
    
}
- (void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.gradientView setGradientColor:_COLOR(0xff, 0x8c, 0x19) end:_COLOR(0xff, 0x66, 0x19)];
}

//修改用户资料
- (IBAction)EditUserInfo:(id)sender
{
    QRCodeVC *vc = [IBUIFactory CreateQRCodeViewController];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)btnUserSetting:(id)sender
{
    [self doBtnUserSetting:sender];
}

- (IBAction)doBtnUserSetting:(id)sender
{
    UserSettingVC *vc = [[UserSettingVC alloc] initWithNibName:nil bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//我的红包
- (IBAction)redPachet:(id)sender
{
    MyLuckyMoneyVC *vc = [IBUIFactory CreateMyLuckyMoneyViewController];
    vc.hidesBottomBarWhenPushed = YES;
    vc.title = @"我的红包";
    [self.navigationController pushViewController:vc animated:YES];
}

//收益提现
- (IBAction)withdraw:(id)sender
{
    UserInfoModel *model = [UserInfoModel shareUserInfoModel];
    if(model.cardVerifiy == 3){
        IncomeWithdrawVC *vc = [IBUIFactory CreateIncomeWithdrawViewController];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        [Util showAlertMessage:@"为保护您的资金安全，只有实名认证后才能收益提取"];
    }
}

//我的邀请
- (IBAction)invite:(id)sender
{
    MyTeamsVC *vc = [[MyTeamsVC alloc] initWithNibName:nil bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

//整体规模
- (IBAction)scale:(id)sender
{
    DetailAccountVC *vc = [[DetailAccountVC alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

//上月已经完成
- (IBAction)finish:(id)sender
{
//    SalesStatisticsVC *vc = [IBUIFactory CreateSalesStatisticsViewController];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}

//上月收益
- (IBAction)incomePrevMounth:(id)sender
{
//    CustomerCallStatisticsVC *vc = [IBUIFactory CreateCustomerCallStatisticsViewController];
//    vc.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:vc animated:YES];
}

//认证
- (IBAction)authentication:(id)sender
{
    RealNameAuthenticationVC *vc = [IBUIFactory CreateRealNameAuthenticationViewController];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
