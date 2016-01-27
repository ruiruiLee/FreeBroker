//
//  BasePullTableVC.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/17.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "BaseViewController.h"
#import "PullTableView.h"

@interface BasePullTableVC : BaseViewController<PullTableViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) PullTableView *pulltable;
@property (nonatomic, assign) NSInteger pageNum;//当前第几页
@property (nonatomic, assign) NSInteger total;//数据总条数
@property (nonatomic, strong) NSMutableArray *data;

//约束
@property (nonatomic, strong) NSArray *hConstraints;
@property (nonatomic, strong) NSArray *vConstraints;

@property (nonatomic, strong) UIView *explainBgView;
@property (nonatomic, strong) UIImageView *imgWithNoData;


- (void) initSubViews;

- (void) loadDataInPages:(NSInteger) page;

- (void) refreshTable;
- (void) loadMoreDataToTable;

- (void) showNoDatasImage:(UIImage *) image;
- (void) hidNoDatasImage;

@end
