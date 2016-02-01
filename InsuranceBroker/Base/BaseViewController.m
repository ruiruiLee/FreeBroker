//
//  BaseViewController.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/14.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "BaseViewController.h"
#import "define.h"
#import "UINavigationBar+statusBarColor.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import "GMDCircleLoader.h"
#import "NetManager.h"
#import "KGStatusBar.h"
#import <AVOSCloud/AVOSCloud.h>

@implementation BaseViewController


// 处理注册通知 kReachabilityChangedNotification
- (void)reachabilityChanged
{
    NetworkStatus status = [[NetManager defaultReachability] currentReachabilityStatus];
    switch (status)
    {
        case NotReachable:
        {
              [KGStatusBar showErrorWithStatus:@"无法连接网络，请稍后再试！"];
            break;
        }
        case ReachableViaWiFi:
        {
            [KGStatusBar showSuccessWithStatus:@"成功连接wifi，请刷新！"];
            NSLog(@" NetworkStatus : ReachableViaWiFi");
            
               break;
        }
        case ReachableViaWWAN:
        {
            [KGStatusBar showSuccessWithStatus:@"当前网络为流量模式"];
            NSLog(@" NetworkStatus : ReachableViaWWAN");
           break;
        }
        default:
            //[KGStatusBar showWithStatus:@"Loading..."];
            [KGStatusBar dismiss];
            break;
    }
}



// 注册网络连接状态的改变通知
- (void)regitserSystemAsObserver{
    // 注册网络连接状态的改变通知
  
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    [[NetManager defaultReachability] startNotifier];     // 开始监听网络

}
- (void) viewDidLoad
{
    [super viewDidLoad];
    if ([[NetManager defaultReachability] currentReachabilityStatus]==NotReachable) {
        [KGStatusBar showErrorWithStatus:@"无法连接网络，请稍后再试！"];
    }
    [self performSelector:@selector(regitserSystemAsObserver) withObject:nil afterDelay:0.5f];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self.navigationController.navigationBar lt_setBackgroundColor:_COLOR(255, 255, 255)];
    
//    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
    
    self.view.backgroundColor = _COLOR(245, 245, 245);
    
    UIColor * color = _COLOR(0x21, 0x21, 0x21);
     NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];
     self.navigationController.navigationBar.titleTextAttributes = dict;
    
//    [self setBackBarButton];
    [self setLeftBarButtonWithImage:ThemeImage(@"arrow_left")];
}

- (void) setNavTitle:(NSString *) title
{
    self.navigationController.title = title;
}

- (void) setBackBarButton
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleBordered target:self action:@selector(handleLeftBarButtonClicked:)];
    UIImage *image = [ThemeImage(@"arrow_left") imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    backItem.image = image;
    [backItem setTarget:self];
    
//    self.navigationItem.backBarButtonItem=backItem;
    [[self navigationItem] setLeftBarButtonItem:backItem];
}

- (void) setLeftBarButtonWithNil
{
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:nil action:nil];
    
    [[self navigationItem] setLeftBarButtonItem:backItem];
}

- (void) setLeftBarButtonWithImage:(UIImage *) image
{
    UIBarButtonItem *barButtonItemLeft=[[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleBordered target:self action:@selector(handleLeftBarButtonClicked:)];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    barButtonItemLeft.image = image;
    [[self navigationItem] setLeftBarButtonItem:barButtonItemLeft];
}

- (void) setLeftBarButtonWithImage:(UIImage *) image title:(NSString*) title
{
    UIBarButtonItem *barButtonItemLeft=[[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:self action:@selector(handleLeftBarButtonClicked:)];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    barButtonItemLeft.image = image;
    [[self navigationItem] setLeftBarButtonItem:barButtonItemLeft];
}

- (void) setRightBarButtonWithImage:(UIImage *) image
{
    UIBarButtonItem *barButtonItemRight=[[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStyleBordered target:self action:@selector(handleRightBarButtonClicked:)];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    barButtonItemRight.image = image;
    [[self navigationItem] setRightBarButtonItem:barButtonItemRight];
}

- (void) setRightBarButtonWithImage:(UIImage *) image title:(NSString*) title
{
    UIBarButtonItem *barButtonItemRight=[[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:self action:@selector(handleRightBarButtonClicked:)];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    barButtonItemRight.image = image;
    [[self navigationItem] setRightBarButtonItem:barButtonItemRight];
}

- (void) setRightBarButtonWithButton:(UIButton *)button
{
    UIBarButtonItem *barButtonItemRight=[[UIBarButtonItem alloc] initWithCustomView:button];
    [button addTarget:self action:@selector(handleRightBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [[self navigationItem] setRightBarButtonItem:barButtonItemRight];
}

- (void) SetRightBarButtonWithTitle:(NSString *) title color:(UIColor *) color action:(BOOL) action
{
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 58, 25)];
    [button setBackgroundImage:[Util imageWithColor:color size:CGSizeMake(58, 25)] forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 3;
    button.titleLabel.font = _FONT(15);
    button.clipsToBounds = YES;
    button.userInteractionEnabled = action;
//    button.alpha = alpha;
    
    [self setRightBarButtonWithButton:button];
}

#pragma ACTION
- (void) handleLeftBarButtonClicked:(id) sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) handleRightBarButtonClicked:(id) sender
{
    
}

#pragma 登录
- (BOOL) login
{
    UserInfoModel *user = [UserInfoModel shareUserInfoModel];
    if(!user.isLogin){
        if([WXApi isWXAppInstalled]){
            WXLoginVC *vc  = [IBUIFactory CreateWXLoginViewController];
            UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:vc];
            [self.navigationController presentViewController:naVC animated:YES completion:nil];
        }
        else{
            loginViewController *vc = [IBUIFactory CreateLoginViewController];
            UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:vc];
            [self.navigationController presentViewController:naVC animated:NO completion:nil];
        }
        return NO;
    }else{
        return YES;
    }
}

//处理返回数据
- (BOOL) handleResponseWithCode:(NSInteger) code msg:(NSString *)msg
{
    BOOL result = YES;
    if(code != 200){
        if (code == 504){   // 需要重新登陆，服务器端过期失效
            UserInfoModel *user = [UserInfoModel shareUserInfoModel];
            user.isLogin = NO;
            AVInstallation *currentInstallation = [AVInstallation currentInstallation];
            [currentInstallation removeObject:@"ykbbrokerLoginUser" forKey:@"channels"];
            [currentInstallation removeObject:[UserInfoModel shareUserInfoModel].userId forKey:@"channels"];
            [currentInstallation saveInBackground];
            [self login];
        }
        else if(code<0)
         [KGStatusBar showErrorWithStatus:@"无法连接网络，请稍后再试！"];
        else
          [KGStatusBar showErrorWithStatus:msg];
            result = NO;
    }
    return result;
}

//show loading洁面
- (void) startCircleLoader
{
    [GMDCircleLoader setOnView:self.view withTitle:@"Loading..." animated:YES];
}

- (void)stopCircleLoader
{
    [GMDCircleLoader hideFromView:self.view animated:YES];
}

@end
