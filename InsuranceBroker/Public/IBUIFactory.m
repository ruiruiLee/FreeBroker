//
//  IBUIFactory.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/16.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "IBUIFactory.h"

@implementation IBUIFactory

//网页
+ (WebViewController *) CreateWebViewController
{
    WebViewController *web = [[WebViewController alloc] initWithNibName:@"WebViewController" bundle:nil];
    return web;
}

//登录
+ (loginViewController *) CreateLoginViewController
{
    loginViewController *login = [[loginViewController alloc] initWithNibName:@"loginViewController" bundle:nil];
    return login;
}

//客户详情
+ (CustomerDetailVC *) CreateCustomerDetailViewController
{
    CustomerDetailVC *detail = [[CustomerDetailVC alloc] initWithNibName:@"CustomerDetailVC" bundle:nil];
    return detail;
}

//个人设置
+ (UserInfoEditVC *) CreateUserInfoEditViewController
{
    UserInfoEditVC *edit = [[UserInfoEditVC alloc] initWithNibName:@"UserInfoEditVC" bundle:nil];
    return edit;
}

//红包
+ (MyLuckyMoneyVC *) CreateMyLuckyMoneyViewController
{
    MyLuckyMoneyVC *luck = [[MyLuckyMoneyVC alloc] initWithNibName:@"MyLuckyMoneyVC" bundle:nil];
    return luck;
}

//编辑标签
+ (EditTagVC *) CreateEditTagViewController
{
    EditTagVC *edit = [[EditTagVC alloc] initWithNibName:@"EditTagVC" bundle:nil];
    return edit;
}

//标签列表
+ (TagListViewController *) CreateTagListViewController
{
    TagListViewController *taglist = [[TagListViewController alloc] initWithNibName:@"TagListViewController" bundle:nil];
    return taglist;
}

+ (CustomerInfoEditVC *) CreateCustomerInfoEditViewController
{
    CustomerInfoEditVC *edit = [[CustomerInfoEditVC alloc] initWithNibName:@"CustomerInfoEditVC" bundle:nil];
    return edit;
}

//新增记录
+ (AddFollowUpVC *) CreateAddFollowUpViewController
{
    AddFollowUpVC *add = [[AddFollowUpVC alloc] initWithNibName:@"AddFollowUpVC" bundle:nil];
    return add;
}

//编辑车险
+ (AutoInsuranceInfoEditVC *) CreateAutoInsuranceInfoEditViewController
{
    AutoInsuranceInfoEditVC *edit = [[AutoInsuranceInfoEditVC alloc] initWithNibName:@"AutoInsuranceInfoEditVC" bundle:nil];
    return edit;
}

//二维码名片
+ (QRCodeVC *) CreateQRCodeViewController
{
    QRCodeVC *qr = [[QRCodeVC alloc] initWithNibName:@"QRCodeVC" bundle:nil];
    return qr;
}

//身份认证
+ (RealNameAuthenticationVC *) CreateRealNameAuthenticationViewController
{
    RealNameAuthenticationVC *authentication = [[RealNameAuthenticationVC alloc] initWithNibName:@"RealNameAuthenticationVC" bundle:nil];
    return authentication;
}

//收益统计
+ (IncomeStatisticsVC *) CreateIncomeStatisticsViewController
{
    IncomeStatisticsVC *income = [[IncomeStatisticsVC alloc] initWithNibName:@"IncomeStatisticsVC" bundle:nil];
    return income;
}

//报价详情
+ (OfferDetailsVC *) CreateOfferDetailsViewController
{
    OfferDetailsVC *offer = [[OfferDetailsVC alloc] initWithNibName:@"OfferDetailsVC" bundle:nil];
    return offer;
}

//收益提现
+ (IncomeWithdrawVC *) CreateIncomeWithdrawViewController
{
    IncomeWithdrawVC *income = [[IncomeWithdrawVC alloc] initWithNibName:@"IncomeWithdrawVC" bundle:nil];
    return income;
}

//绑定银行卡
+ (BindBankCardVC *) CreateBindBankCardViewController
{
    BindBankCardVC *card = [[BindBankCardVC alloc] initWithNibName:nil bundle:nil];
    return card;
}

//微信登录
+ (WXLoginVC *) CreateWXLoginViewController
{
    WXLoginVC *wx = [[WXLoginVC alloc] initWithNibName:@"WXLoginVC" bundle:nil];
    return wx;
}

//绑定电话
+ (BindPhoneNumVC *) CreateBindPhoneNumViewController
{
    BindPhoneNumVC *phone = [[BindPhoneNumVC alloc] initWithNibName:@"BindPhoneNumVC" bundle:nil];
    return phone;
}

//修改电话
+ (ModifyPhoneNumVC *) CreateModifyPhoneNumViewController
{
    ModifyPhoneNumVC *phone = [[ModifyPhoneNumVC alloc] initWithNibName:@"ModifyPhoneNumVC" bundle:nil];
    return phone;
}

//销售统计i
+ (SalesStatisticsVC *) CreateSalesStatisticsViewController
{
    SalesStatisticsVC *sales = [[SalesStatisticsVC alloc] initWithNibName:@"SalesStatisticsVC" bundle:nil];
    return sales;
}

//客户拜访统计
+ (CustomerCallStatisticsVC *) CreateCustomerCallStatisticsViewController
{
    CustomerCallStatisticsVC *customer = [[CustomerCallStatisticsVC alloc] initWithNibName:@"CustomerCallStatisticsVC" bundle:nil];
    return customer;
}

//新建客户
+ (NewCustomerVC *) CreateNewCustomerViewController
{
    NewCustomerVC *customer = [[NewCustomerVC alloc] initWithNibName:@"NewCustomerVC" bundle:nil];
    return customer;
}

//订单
+ (OrderDetailWebVC *) CreateOrderDetailWebVC
{
    OrderDetailWebVC *customer = [[OrderDetailWebVC alloc] initWithNibName:nil bundle:nil];
    return customer;
}

@end
