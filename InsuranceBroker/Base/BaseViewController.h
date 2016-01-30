//
//  BaseViewController.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/14.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationBar+Awesome.h"
#import "UserInfoModel.h"
#import "ProgressHUD.h"

@interface BaseViewController : UIViewController

//设置title
- (void) setNavTitle:(NSString *) title;

//设置返回按钮
- (void) setBackBarButton;

//设置左边按钮
- (void) setLeftBarButtonWithImage:(UIImage *) image;
- (void) setLeftBarButtonWithNil;
- (void) setLeftBarButtonWithImage:(UIImage *) image title:(NSString*) title;

//设置右边按钮
- (void) setRightBarButtonWithImage:(UIImage *) image;
- (void) setRightBarButtonWithImage:(UIImage *) image title:(NSString*) title;
- (void) setRightBarButtonWithButton:(UIButton *)button;
- (void) SetRightBarButtonWithTitle:(NSString *) title color:(UIColor *) color action:(BOOL) action;

//响应左按钮事件
- (void) handleLeftBarButtonClicked:(id) sender;

//响应右按钮事件
- (void) handleRightBarButtonClicked:(id) sender;

- (BOOL) login;

- (BOOL) handleResponseWithCode:(NSInteger) code msg:(NSString *)msg;

- (void) startCircleLoader;

- (void)stopCircleLoader;

@end
