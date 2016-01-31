//
//  RootViewController.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/14.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "RootViewController.h"
#import "define.h"
#import "NoticeListVC.h"

@implementation RootViewController
@synthesize homevc;
@synthesize customervc;
@synthesize workvc;
@synthesize usercentervc;
@synthesize selectVC;

+ (void)initialize
{
    // 通过appearance统一设置所有UITabBarItem的文字属性
    UITabBarItem *tabBarItem = [UITabBarItem appearance];
    
    /** 设置默认状态 */
    NSMutableDictionary *norDict = @{}.mutableCopy;
    norDict[NSFontAttributeName] = [UIFont systemFontOfSize:11];
    norDict[NSForegroundColorAttributeName] = _COLOR(0x99, 0x99, 0x99);
    [tabBarItem setTitleTextAttributes:norDict forState:UIControlStateNormal];
    
    /** 设置选中状态 */
    NSMutableDictionary *selDict = @{}.mutableCopy;
    selDict[NSFontAttributeName] = norDict[NSFontAttributeName];
    selDict[NSForegroundColorAttributeName] = _COLOR(255, 255, 255);
    [tabBarItem setTitleTextAttributes:selDict forState:UIControlStateSelected];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)tapReceivedNotificationHandler:(NSNotification *)notice
{
    CMNavBarNotificationView *notificationView = (CMNavBarNotificationView *)notice.object;
    if ([notificationView isKindOfClass:[CMNavBarNotificationView class]])
    {
        NSLog( @"Received touch for notification with text: %@", ((CMNavBarNotificationView *)notice.object).textLabel.text );
    }
    [self pushtoController:notificationView.msgInfo];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(tapReceivedNotificationHandler:)
                                                 name:kCMNavBarNotificationViewTapReceivedNotification
                                               object:nil];
    self.delegate = self;
    
    homevc = [[HomeVC alloc] initWithNibName:@"HomeVC" bundle:nil];
    [self setUpChildControllerWith:homevc norImage:ThemeImage(@"home") selImage:ThemeImage(@"home_fill") title:@"首页"];
    homevc.tabBarItem.tag = 1001;
    
    customervc = [[CustomerMainVC alloc] initWithNibName:nil bundle:nil];
    [self setUpChildControllerWith:customervc norImage:ThemeImage(@"people") selImage:ThemeImage(@"people_fill") title:@"客户"];
    customervc.tabBarItem.tag = 1002;
    
    workvc = [[WorkMainVC alloc] initWithNibName:nil bundle:nil];
    [self setUpChildControllerWith:workvc norImage:ThemeImage(@"work") selImage:ThemeImage(@"work_fill") title:@"工作"];
    workvc.tabBarItem.tag = 1003;
    
    usercentervc = [[UserCenterVC alloc] initWithNibName:@"UserCenterVC" bundle:nil];
    [self setUpChildControllerWith:usercentervc norImage:ThemeImage(@"myself") selImage:ThemeImage(@"myself_fill") title:@"我的"];
    usercentervc.tabBarItem.tag = 1004;
    
    
    UIImageView *tabBarBgView = [[UIImageView alloc] initWithFrame:self.tabBar.bounds];
    tabBarBgView.backgroundColor = _COLOR(0x22, 0x22, 0x22);
    [self.tabBar insertSubview:tabBarBgView atIndex:0];
    
    /** 设置tabar工具条 */
//    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbar-light"]];
    selectVC = homevc;
}

//添加item 视图控制器
- (void)setUpChildControllerWith:(UIViewController *)childVc norImage:(UIImage *)norImage selImage:(UIImage *)selImage title:(NSString *)title
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:childVc];
    
    childVc.tabBarItem.title = title;
    
    childVc.tabBarItem.image = norImage;
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childVc.tabBarItem.selectedImage = selImage;
    
    [self addChildViewController:nav];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    NSInteger tag = viewController.tabBarItem.tag;
    if(tag == 1001){
        selectVC = homevc;
        return YES;
    }else{
        BOOL result = [selectVC login];
        if(result){
            if(tag == 1002){
                selectVC = customervc;
            }
            else if (tag == 1003){
                selectVC = workvc;
            }
            else
            {
                selectVC = usercentervc;
            }
        }
        return result;
    }
}

/**
 * 手动跳转页面
 * mt 跳转到的页面ID
 */


-(void) pushActivetoController:(id)dic{
    [CMNavBarNotificationView notifyWithText:[dic objectForKey:@"title"]
                                      detail:[[dic objectForKey:@"aps"] objectForKey:@"alert"]
                                       image:[UIImage imageNamed:@"icon"]
                                 andDuration:5.0
                                  msgparams:dic];
}

-(void) pushtoController:(NSDictionary *)info
{
    NSInteger mt = [[info objectForKey:@"mt"] integerValue];
    if(mt == 1){
        if([homevc login]){
            self.selectedIndex = 0;
            selectVC = homevc;
            [selectVC.navigationController popToRootViewControllerAnimated:NO];
            NoticeListVC *vc = [[NoticeListVC alloc] initWithNibName:nil bundle:nil];
            vc.hidesBottomBarWhenPushed = YES;
            [homevc.navigationController pushViewController:vc animated:YES];
        }
    }
    else if (mt == 3){
        if([customervc login]){
            self.selectedIndex = 1;
            selectVC = customervc;
        }
    }else if (mt == 4){
        WebViewController *web = [IBUIFactory CreateWebViewController];
        web.hidesBottomBarWhenPushed = YES;
        web.title = [info objectForKey:@"title"];
        web.type = enumShareTypeShare;
        web.shareTitle = web.title;
        [selectVC.navigationController pushViewController:web animated:YES];
        
        [web loadHtmlFromUrlWithUserId:[NSString stringWithFormat:@"%@%@%@", SERVER_ADDRESS, @"/news/view/", [info objectForKey:@"p"]]];
    }
}

@end
