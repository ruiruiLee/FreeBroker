//
//  IBUIFactory.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/16.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WebViewController.h"
#import "loginViewController.h"
#import "CustomerDetailVC.h"
#import "UserInfoEditVC.h"
#import "MyLuckyMoneyVC.h"
#import "EditTagVC.h"
#import "TagListViewController.h"
#import "CustomerInfoEditVC.h"
#import "AddFollowUpVC.h"
#import "AutoInsuranceInfoEditVC.h"
#import "QRCodeVC.h"
#import "RealNameAuthenticationVC.h"
#import "IncomeStatisticsVC.h"
#import "OfferDetailsVC.h"
#import "IncomeWithdrawVC.h"
#import "BindBankCardVC.h"
#import "WXLoginVC.h"
#import "BindPhoneNumVC.h"
#import "ModifyPhoneNumVC.h"
#import "SalesStatisticsVC.h"
#import "CustomerCallStatisticsVC.h"
#import "NewCustomerVC.h"
#import "OrderDetailWebVC.h"

@interface IBUIFactory : NSObject

+ (WebViewController *) CreateWebViewController;

+ (loginViewController *) CreateLoginViewController;

+ (CustomerDetailVC *) CreateCustomerDetailViewController;

+ (UserInfoEditVC *) CreateUserInfoEditViewController;

+ (MyLuckyMoneyVC *) CreateMyLuckyMoneyViewController;

+ (EditTagVC *) CreateEditTagViewController;

+ (TagListViewController *) CreateTagListViewController;

+ (CustomerInfoEditVC *) CreateCustomerInfoEditViewController;

+ (AddFollowUpVC *) CreateAddFollowUpViewController;

+ (AutoInsuranceInfoEditVC *) CreateAutoInsuranceInfoEditViewController;

+ (QRCodeVC *) CreateQRCodeViewController;

+ (RealNameAuthenticationVC *) CreateRealNameAuthenticationViewController;

+ (IncomeStatisticsVC *) CreateIncomeStatisticsViewController;

+ (OfferDetailsVC *) CreateOfferDetailsViewController;

+ (IncomeWithdrawVC *) CreateIncomeWithdrawViewController;

+ (BindBankCardVC *) CreateBindBankCardViewController;

+ (WXLoginVC *) CreateWXLoginViewController;

+ (BindPhoneNumVC *) CreateBindPhoneNumViewController;

+ (ModifyPhoneNumVC *) CreateModifyPhoneNumViewController;

+ (SalesStatisticsVC *) CreateSalesStatisticsViewController;

+ (CustomerCallStatisticsVC *) CreateCustomerCallStatisticsViewController;

+ (NewCustomerVC *) CreateNewCustomerViewController;

+ (OrderDetailWebVC *) CreateOrderDetailWebVC;

@end
