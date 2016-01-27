//
//  IncomeStatisticsVC.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/31.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "BaseViewController.h"
#import "GradientView.h"
#import "LineChartView.h"
#import "XYPieChart.h"

@interface IncomeStatisticsVC : BaseViewController<XYPieChartDelegate, XYPieChartDataSource>

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *viewHConstraint;
@property (nonatomic, strong) IBOutlet GradientView *topView;
@property (nonatomic, strong) IBOutlet UILabel *lbIncome;
@property (nonatomic, strong) IBOutlet UILabel *lbEarnings;
@property (nonatomic, strong) IBOutlet UILabel *lbEarningsCount;
@property (nonatomic, strong) IBOutlet LineChartView *chatview;
@property (nonatomic, strong) IBOutlet XYPieChart *piechat;
@property (nonatomic, strong) IBOutlet UIButton *btnMore;

@property (nonatomic, strong) IBOutlet UILabel *lbSaleStr;
@property (nonatomic, strong) IBOutlet UILabel *lbSale;
@property (nonatomic, strong) IBOutlet UILabel *lbTeamStr;
@property (nonatomic, strong) IBOutlet UILabel *lbTeam;
@property (nonatomic, strong) IBOutlet UILabel *lbRedStr;
@property (nonatomic, strong) IBOutlet UILabel *lbRed;
@property (nonatomic, strong) IBOutlet UILabel *lbManStr;
@property (nonatomic, strong) IBOutlet UILabel *lbMan;

@property (nonatomic, strong) IBOutlet UILabel *lbManTitle;

@property(nonatomic, strong) NSMutableArray *slices;
@property(nonatomic, strong) NSArray        *sliceColors;

@end
