//
//  BaseTableViewController.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/23.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableview;

//约束
@property (nonatomic, strong) NSArray *hConstraints;
@property (nonatomic, strong) NSArray *vConstraints;

@property (nonatomic, strong) UIView *explainBgView;

@property (nonatomic, strong) UIImageView *imgWithNoData;

- (void) initSubViews;

- (void) loadData;

- (void) showNoDatasImage:(UIImage *) image;
- (void) hidNoDatasImage;

@end
