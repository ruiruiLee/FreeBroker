//
//  IncomeStatisticsVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/31.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "IncomeStatisticsVC.h"
#import "define.h"
#import "DetailAccountVC.h"
#import "NetWorkHandler+queryStatistics.h"
#import "CurveModel.h"
#import "StatisticsModel.h"

@interface IncomeStatisticsVC ()

@property (nonatomic, strong) NSArray *curveArray;
@property (nonatomic, strong) StatisticsModel *statmodel;

@end

@implementation IncomeStatisticsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"收益统计";
    
    UIButton *btnDetail = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 24)];
    [btnDetail setTitle:@"账单明细" forState:UIControlStateNormal];
    btnDetail.layer.cornerRadius = 12;
    btnDetail.layer.borderWidth = 0.5;
    btnDetail.layer.borderColor = _COLOR(0xff, 0x66, 0x19).CGColor;
    [btnDetail setTitleColor:_COLOR(0xff, 0x66, 0x19) forState:UIControlStateNormal];
    btnDetail.titleLabel.font = _FONT(10);
    [self setRightBarButtonWithButton:btnDetail];
    [btnDetail addTarget:self action:@selector(doBtnDetailAccount:) forControlEvents:UIControlEventTouchUpInside];
    
    self.viewHConstraint.constant = ScreenWidth;
    
    self.btnMore.layer.cornerRadius = 12;
    [self.btnMore addTarget:self action:@selector(doBtnMore:) forControlEvents:UIControlEventTouchUpInside];
    
    self.chatview.yMin = 0;
    self.chatview.yMax = 6;
    self.chatview.ySteps = @[@"0",@"200", @"400", @"600", @"800", @"2000000"];
    self.chatview.backgroundColor = [UIColor clearColor];
    
    UserInfoModel *model = [UserInfoModel shareUserInfoModel];
    self.lbIncome.text = [Util getDecimalStyle:model.monthOrderEarn];
    self.lbEarningsCount.text = [NSString stringWithFormat:@"累计收益：%@元", [Util getDecimalStyle:model.orderEarn]];
    
    self.lbMan.layer.cornerRadius = 3;
    self.lbRed.layer.cornerRadius = 3;
    self.lbSale.layer.cornerRadius = 3;
    self.lbTeam.layer.cornerRadius = 3;
    
    [self.piechat setDataSource:self];
    [self.piechat setStartPieAngle:M_PI_2];
    [self.piechat setAnimationSpeed:1.0];
    [self.piechat setLabelFont:[UIFont fontWithName:@"DBLCDTempBlack" size:24]];
    [self.piechat setLabelRadius:180];
    [self.piechat setShowPercentage:YES];
    [self.piechat setPieBackgroundColor:[UIColor colorWithWhite:0.95 alpha:1]];
    [self.piechat setPieCenter:CGPointMake(240, 240)];
    [self.piechat setUserInteractionEnabled:NO];
    
    self.sliceColors =[NSArray arrayWithObjects:
                       _COLOR(0xff, 0x3d, 0x3d),
                       _COLOR(0x81, 0x8c, 0xf3),
                       _COLOR(0xfc, 0xc1, 0x38),
                       _COLOR(0x3d, 0xbe, 0xff),nil];
    
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    for(int i = 0; i < 4; i ++)
//    {
//        [array addObject:[NSNumber numberWithInt:rand()%60+20]];
//    }
//    self.slices = array;
    
    [self.piechat reloadData];
    
    [self loadData];
}

- (void) doBtnMore:(id) sender
{
    WebViewController *web = [IBUIFactory CreateWebViewController];
    web.title = @"收益太低";
    [self.navigationController pushViewController:web animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@%@%@", SERVER_ADDRESS, @"/news/view/", INCOME_LOW];
    [web loadHtmlFromUrl:url];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.topView setGradientColor:_COLOR(0xff, 0x8c, 0x19) end:_COLOR(0xff, 0x66, 0x19)];
}

- (void) loadData
{
    [NetWorkHandler requestToQueryStatistics:[UserInfoModel shareUserInfoModel].userId Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            self.statmodel = (StatisticsModel*)[StatisticsModel modelFromDictionary:[[content objectForKey:@"data"] objectForKey:@"statistics"]];
            self.curveArray = [CurveModel modelArrayFromArray:[[content objectForKey:@"data"] objectForKey:@"curve"]];
            [self initData];
        }
    }];
}

- (void) initData
{
    self.lbEarningsCount.text = [NSString stringWithFormat:@"累计收益：%@元", [Util getDecimalStyle:self.statmodel.totalIn]];
    self.lbIncome.text = [NSString stringWithFormat:@"%@", [Util getDecimalStyle:self.statmodel.monthTotalIn]];
    self.lbEarnings.text = [NSString stringWithFormat:@"你的收益已打败了%d%@的经纪人", (int)self.statmodel.monthTotalRatio, @"%"];
    [self initDataWithArray:self.curveArray];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];

    [array addObject:[NSNumber numberWithFloat:self.statmodel.monthInInsurance]];
    [array addObject:[NSNumber numberWithFloat:self.statmodel.monthInTeam]];
    [array addObject:[NSNumber numberWithFloat:self.statmodel.monthInRedPack]];
    [array addObject:[NSNumber numberWithFloat:self.statmodel.monthInLeader]];
    self.slices = array;

    self.lbSaleStr.text = [Util getDecimalStyle:self.statmodel.monthInInsurance];
    self.lbTeamStr.text = [Util getDecimalStyle:self.statmodel.monthInTeam];
    self.lbRedStr.text = [Util getDecimalStyle:self.statmodel.monthInRedPack];
    self.lbManStr.text = [Util getDecimalStyle:self.statmodel.monthInLeader];
    
    self.piechat.lbAmount.text = [Util getDecimalStyle:self.statmodel.monthTotalIn];
    
    [self.piechat reloadData];
    
}

- (void) doBtnDetailAccount:(UIButton *)sender
{
    DetailAccountVC *vc = [[DetailAccountVC alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initDataWithArray:(NSArray*)array
{
    LineChartData *d1x = [LineChartData new];
    {
        LineChartData *d1 = d1x;
        d1.title = @"34423";
        d1.color = _COLOR(0xff, 0x66, 0x19);
        d1.itemCount = [array count];
        d1.xMax = d1.itemCount + 1;//[Util convertDateFromDateString:model1.dateString].timeIntervalSince1970/1000;
        d1.xMin = 0;//[Util convertDateFromDateString:model2.dateString].timeIntervalSince1970/1000;
        NSMutableArray *arr = [NSMutableArray array];//x
        NSMutableArray *arr2 = [NSMutableArray array];//y
        NSMutableArray *arr3 = [NSMutableArray array];//y
        
        NSMutableArray *arr4 = [NSMutableArray array];//y
        NSMutableArray *arr5 = [NSMutableArray array];//y
        
        int j = 1;
        for(int i = 0; i < [array count]; i++){
            CurveModel *model = [array objectAtIndex:i];
            [arr addObject:@(j)];
            NSString *lp = [NSString stringWithFormat:@"%d", (int)model.totalIn];
            [arr2 addObject:lp];
            [arr3 addObject:[NSString stringWithFormat:@"%@月", model.month]];
            
            NSAttributedString *attstring = [[NSAttributedString alloc] initWithString:@""];
            [arr4 addObject:attstring];
            
            [arr5 addObject:[NSString stringWithFormat:@""]];
            
            j ++;
        }
        
        d1.getData = ^(NSUInteger item) {
            float x = [arr[item] floatValue];
            float y = [arr2[item] floatValue];
            y = y / 200.0 * 5;
            NSString *label1 = arr3[item];
            NSString *label2 = arr4[item];
            NSString *label3 = arr5[item];
            return [LineChartDataItem dataItemWithX:x y:y xLabel:label1 dataLabel:label2 detail:label3];
        };
        
    }
    
    self.chatview.data = @[d1x];
}

#pragma mark - XYPieChart Data Source

- (NSUInteger)numberOfSlicesInPieChart:(XYPieChart *)pieChart
{
    return self.slices.count;
}

- (CGFloat)pieChart:(XYPieChart *)pieChart valueForSliceAtIndex:(NSUInteger)index
{
    return [[self.slices objectAtIndex:index] intValue];
}

- (UIColor *)pieChart:(XYPieChart *)pieChart colorForSliceAtIndex:(NSUInteger)index
{
    return [self.sliceColors objectAtIndex:(index % self.sliceColors.count)];
}

#pragma mark - XYPieChart Delegate
- (void)pieChart:(XYPieChart *)pieChart didSelectSliceAtIndex:(NSUInteger)index
{
    NSLog(@"did select slice at index %d",index);
//    self.selectedSliceLabel.text = [NSString stringWithFormat:@"$%@",[self.slices objectAtIndex:index]];
}

@end
