//
//  MenuViewController.h
//  MneuDemo
//
//  Created by iHope on 13-9-17.
//  Copyright (c) 2013年 iHope. All rights reserved.
//

#import <UIKit/UIKit.h>

//声明协议
@protocol MenuDelegate;


@interface MenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIView *backView;
    UIView *parentView;
    UILabel *line;
}
@property (nonatomic, assign)id<MenuDelegate> menuDelegate;//代理
@property (nonatomic, strong) NSArray *titleArray;//标题内容
@property (nonatomic, strong) UITableView *table;//显示的表格
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UILabel *lbTitle;
@property (nonatomic, assign) NSInteger tag;
@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) NSInteger selectIdx;

- (id)initWithTitles:(NSArray *) titles;
//显示
- (void) show:(UIView*)parent;
//隐藏
- (void) hide;
@end

/**协议**/
@protocol MenuDelegate <NSObject>

@required
- (void) menuViewController:(MenuViewController *)menu AtIndex:(NSUInteger)index;
- (void) menuViewControllerDidCancel:(MenuViewController *)menu;


@end