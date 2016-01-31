//
//  AppDelegate.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/14.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "AppDelegate.h"
#import "define.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudSNS/AVOSCloudSNS.h>

#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

#import "ZWIntroductionViewController.h"
#import "RootViewController.h"
#import "AppContext.h"
@interface AppDelegate ()

@property (nonatomic, strong) ZWIntroductionViewController *introductionView;

@end

@implementation AppDelegate
@synthesize root;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //第三方分享ggg
    [ShareSDK registerApp:@"c736476da58c" activePlatforms:@[@(SSDKPlatformTypeSMS), @(SSDKPlatformTypeWechat), @(SSDKPlatformTypeQQ), @(SSDKPlatformSubTypeQZone)] onImport:^(SSDKPlatformType platformType) {
        
        switch (platformType) {
            case SSDKPlatformTypeWechat:
            {
                [ShareSDKConnector connectWeChat:[WXApi class]];
            }
                break;
                case SSDKPlatformTypeQQ:
            {
                [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
            }
                break;
                
            default:
                break;
        }
        
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        
        switch (platformType)
        {
            case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:@"wx4d5be0425a7a8af0" appSecret:@"963a4be41493c18c5917d285a1c55d0b"];
                break;
            case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:@"1105028809"
                                     appKey:@"zLTZRV6XCnnHLGwb"
                                   authType:SSDKAuthTypeBoth];
                break;
            default:
                break;
        }
        
        
    }];
    
    //设置AVOSCloud
    [AVOSCloud setApplicationId:AVOSCloudAppID
                      clientKey:AVOSCloudAppKey];
    //统计应用启动情况
    [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        // 第一次安装时运行打开推送
#if !TARGET_IPHONE_SIMULATOR
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert
                                                    | UIUserNotificationTypeBadge
                                                    | UIUserNotificationTypeSound
                                                                                     categories:nil];
            [application registerUserNotificationSettings:settings];
            [application registerForRemoteNotifications];
        }
        else{
            [application registerForRemoteNotificationTypes: UIRemoteNotificationTypeBadge |
             UIRemoteNotificationTypeAlert |
             UIRemoteNotificationTypeSound];
        }
#endif
        // 引导界面展示
        // [_rootTabController showIntroWithCrossDissolve];
        
    }
    
    //判断程序是不是由推送服务完成的
    if (launchOptions)
    {
        NSDictionary* notificationPayload = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
        if (notificationPayload)
        {
            [self remoteNotificationDistributionCenter:notificationPayload];
            [self performSelector:@selector(pushDetailPage:) withObject:notificationPayload afterDelay:1.0];
            [AVAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
        }
    }
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //create root view controller
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    root = [[RootViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root];
    self.window.rootViewController = nav;
    nav.navigationBarHidden = YES;
    
    [self.window makeKeyAndVisible];
    
    // Added Introduction View Controller
    BOOL firsetLaunch = [AppContext sharedAppContext].firstLaunch;
    if(!firsetLaunch){
        NSArray *coverImageNames = @[@"guide1",@"guide2",@"guide3",@"guide4"];
        // Example 2 自定义登陆按钮
        UIButton *enterButton = [UIButton new];
        [enterButton setBackgroundColor:[UIColor redColor]];
        [enterButton setTitle:NSLocalizedString(@"立刻体验", nil) forState:UIControlStateNormal];
        self.introductionView = [[ZWIntroductionViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:nil button:enterButton];
        
        [self.window addSubview:self.introductionView.view];
        [AppContext sharedAppContext].firstLaunch = YES;
        [[AppContext sharedAppContext] saveData];
        __weak AppDelegate *weakSelf = self;
        self.introductionView.didSelectedEnter = ^() {
            [weakSelf.introductionView.view removeFromSuperview];
            weakSelf.introductionView = nil;
        };
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    //推送功能打开时, 注册当前的设备, 同时记录用户活跃, 方便进行有针对的推送
    self.deviceToken = [[NSString alloc] initWithData:deviceToken encoding:NSUTF8StringEncoding];
    
    [AVUser logOut];  //清除缓存用户对象
    [UserInfoModel shareUserInfoModel].userId = nil;
    AVInstallation *currentInstallation = [AVInstallation currentInstallation];
    [currentInstallation setDeviceTokenFromData:deviceToken];
    [currentInstallation addUniqueObject:@"ykbbrokerAllUser" forKey:@"channels"];
    [currentInstallation saveInBackground];
}

-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{

    //可选 通过统计功能追踪打开提醒失败, 或者用户不授权本应用推送
    [AVAnalytics event:@"开启推送失败" label:[error description]];
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    //可选 通过统计功能追踪通过提醒打开应用的行为
    //这儿你可以加入自己的代码 根据推送的数据进行相应处理
    
    [UIApplication sharedApplication].applicationIconBadgeNumber=0;
     [self remoteNotificationDistributionCenter:userInfo];
    // 程序在运行中接收到推送
    if (application.applicationState == UIApplicationStateActive)
    {
        [root pushActivetoController:userInfo];
    }
    else  //程序在后台中接收到推送
    {
        // The application was just brought from the background to the foreground,
        // so we consider the app as having been "opened by a push notification."
        [AVAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
        [root pushtoController:userInfo];
    }
}

//推送消息提示原点
- (void) remoteNotificationDistributionCenter:(NSDictionary *) userInfo
{
    AppContext *context = [AppContext sharedAppContext];
    int mt = [[userInfo objectForKey:@"mt"] intValue];
    NSInteger ct = [[userInfo objectForKey:@"ct"] integerValue];
    if(mt == 1){
        context.isNewMessage = YES;
        switch (ct) {
            case 10:
            {
                context.isHasNotice = YES;
            }
                break;
            case 11:
            {
                context.isHasNewPolicy = YES;
            }
                break;
            case 12:
            {
                context.isHasTradingMsg = YES;
            }
                break;
            case 13:
            {
                context.isHasIncentivePolicy = YES;
            }
                break;
            default:
                break;
        }
    }
    else if (mt == 3){
        context.pushCustomerNum = [AppContext sharedAppContext].pushCustomerNum;
    }else if (mt == 4){
        
    }
    [context saveData];
    }
//category：10|12, //消息类别 10代表为“通知消息”12代表为”交易消息”，
//title: "消息标题"，如体现通知、收益通知等
//content: "消息内容"，如“您申请体现的￥300，已转入到你的帐号，请查收”
//userId:44，//经纪人userIds，有则传，没有则不传
//ct:消息子类别，
//
//当mt=1时，ct 可为10，11，12，13，系统通知消息类ct=10,交易通知类ct=12
//具体情况为
//ct=10 表示实名认证通过 ,提现申请审核通过  需要userId//通知类消息
//ct=12 表示保单交易成功   ，需要userId
//Ct=11,表示销售政策
//Ct=13,表示激励政策
//objectId:具体业务表主键，如报价完成时需要传入报价单id,提现申请需要传入申请单id,保单交易完成需要传入保单id,

-(void) pushDetailPage: (id)dic
{
     [root pushtoController:dic];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    //[self performSelector:@selector(openlocation) withObject:nil afterDelay:1.0f];
    [[UserInfoModel shareUserInfoModel] queryUserInfo];
      [LcationInstance startUpdateLocation];
}
- (void)openlocation{
    [LcationInstance startUpdateLocation];
}

@end
