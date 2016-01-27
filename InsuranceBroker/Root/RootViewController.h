//
//  RootViewController.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/14.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "define.h"
#import "HomeVC.h"
#import "CustomerMainVC.h"
#import "WorkMainVC.h"
#import "UserCenterVC.h"

@interface RootViewController : UITabBarController<UITabBarControllerDelegate>
{
//    BaseViewController *selectVC;
}

@property (nonatomic, copy) HomeVC *homevc;
@property (nonatomic, copy) CustomerMainVC *customervc;
@property (nonatomic, copy) WorkMainVC *workvc;
@property (nonatomic, copy) UserCenterVC *usercentervc;
@property (nonatomic, strong) BaseViewController *selectVC;

-(void) pushtoController:(NSInteger)mt;

@end
