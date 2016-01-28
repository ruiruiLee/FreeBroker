//
//  define.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/14.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#ifndef define_h
#define define_h

#import "UIView+MGBadgeView.h"
#import "UINavigationBar+Awesome.h"
#import "ViewFactory.h"
#import "IBUIFactory.h"
#import "Util.h"
#import "NetWorkHandler.h"
#import "UserInfoModel.h"
#import "AppDelegate.h"
#import "AppContext.h"
#import "LocationManagerObserver.h"

/*
 服务器地址信息
 */
#define AVOSCloudAppID  @"0PyuKjNlBECHhEf3HxDB7NYX-gzGzoHsz"
#define AVOSCloudAppKey @"mOmncwQfyeroy2jcDj0ch1Q1"
//#define SERVER_ADDRESS @"http://dev.ibroker.avosapps.com"
#define SERVER_ADDRESS @"http://dev.ibroker.leanapp.cn"
#define Base_Uri @"http://118.123.249.87:8783/UKB.AgentNew"
//#define Base_Uri @"http://shuaidehen.imwork.net/UKB.AgentNew/"

//location
#define LcationInstance [LocationManagerObserver sharedInstance]

//image
#define ThemeImage(imageName)  [UIImage imageNamed:imageName]

//rgb Color
#define _COLOR(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1]
#define _COLORa(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//Font
#define _FONT(s) [UIFont fontWithName:@"Helvetica Neue" size:(s)]
#define _FONT_B(s) [UIFont boldSystemFontOfSize:(s)]

//Screen Width
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//limit
#define LIMIT 20

#define imgLicenseSize CGSizeMake(400, 240)

#define Normal_Image ThemeImage(@"normal")
#define Normal_Logo ThemeImage(@"normal_logo")
#define Image_NoData ThemeImage(@"normal_logo")
#define FormatImage_1(imageUrl,imageWidth,imageHeight) [NSString stringWithFormat:@"%@?imageView/1/w/%d/h/%d", imageUrl,imageWidth,imageHeight]

//ids
#define ABOUT_US @"569da3c8df0eea00545d6044"//关于我们
#define User_Agreement @"569da3dad342d30053b4d0f0"//用户协议
#define ABOUT_TEAM @"569da3f78ac2470054d81d22"//关于团队
#define INCOME_LOW @"569da4068ac2470054d81d99"//收益太低
#define Withdrawal_Instructions @"569da42979bc440059c9e839"//提现说明

#define Notify_Reload_CustomerDetail @"Notify_Reload_CustomerDetail"
#define Notify_Add_NewCustomer  @"Notify_Add_NewCustomer"
#define Notify_Add_BankCard @"Notify_Add_BankCard"
#define Notify_Insert_Customer @"Notify_Insert_Customer"

#endif /* define_h */
