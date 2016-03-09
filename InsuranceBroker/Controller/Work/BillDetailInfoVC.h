//
//  BillDetailInfoVC.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/3/1.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseTableViewController.h"
#import "GradientView.h"
#import "BillInfoModel.h"

@interface BillDetailInfoVC : BaseTableViewController

@property (nonatomic, strong) GradientView *headView;
@property (nonatomic, strong) UILabel *lbTotalAmount;//操作金额

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) NSArray *contentArray;
@property (nonatomic, strong) BillInfoModel *billInfo;

- (void) setDataForWithdraw;
- (void) setDataFromSub;
- (void) setDataFromOrder;
- (void) setDataFromLucky;
- (void) initData;

@end
