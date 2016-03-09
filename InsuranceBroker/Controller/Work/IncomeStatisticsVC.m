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

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.title = @"收益统计";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    if([[UserInfoModel shareUserInfoModel].userId isEqualToString:self.userId]){
        UIButton *btnDetail = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 24)];
        [btnDetail setTitle:@"我的账单" forState:UIControlStateNormal];
        btnDetail.layer.cornerRadius = 12;
        btnDetail.layer.borderWidth = 0.5;
        btnDetail.layer.borderColor = _COLOR(0xff, 0x66, 0x19).CGColor;
        [btnDetail setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnDetail.titleLabel.font = _FONT(10);
        btnDetail.backgroundColor = _COLOR(0xff, 0x66, 0x1a);
        [self setRightBarButtonWithButton:btnDetail];
        [btnDetail addTarget:self action:@selector(doBtnDetailAccount:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        self.btnMore.hidden = YES;
    }
    
    self.viewHConstraint.constant = ScreenWidth;
    
    self.btnMore.layer.cornerRadius = 12;
    [self.btnMore addTarget:self action:@selector(doBtnMore:) forControlEvents:UIControlEventTouchUpInside];
    
    self.chatview.yMin = 0;
    self.chatview.yMax = 5;
    self.chatview.ySteps = @[@"0",@"500", @"1000", @"1500", @"2000", @"2500"];
    self.chatview.backgroundColor = [UIColor clearColor];
    
//    UserInfoModel *model = [UserInfoModel shareUserInfoModel];
//    self.lbIncome.text = [Util getDecimalStyle:model.monthOrderEarn];
//    self.lbEarningsCount.text = [NSString stringWithFormat:@"累计收益：%@元", [Util getDecimalStyle:model.orderEarn]];
    
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
    [NetWorkHandler requestToQueryStatistics:self.userId Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            self.statmodel = (StatisticsModel*)[StatisticsModel modelFromDictionary:[[content objectForKey:@"data"] objectForKey:@"statistics"]];
            self.curveArray = [CurveModel modelArrayFromArray:[[content objectForKey:@"data"] objectForKey:@"curve"]];
            [self initData];
        }
    }];
}

- (NSMutableAttributedString *)getAttbuteString:(NSString *)string sub:(NSString *) sub
{
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = [string rangeOfString:sub];
    
    [attstr addAttribute:NSFontAttributeName value:_FONT(18) range:range];
    [attstr addAttribute:NSForegroundColorAttributeName value:_COLOR(0xff, 0xee, 0x00) range:range];
    //    [attstr addAttribute:NSFontAttributeName value:_FONT(13) range:NSMakeRange([string length] - 3, 3)];
    
    return attstr;
}

- (void) initData
{
    self.lbEarningsCount.text = [NSString stringWithFormat:@"累计收益：%@元", [Util getDecimalStyle:self.statmodel.totalIn]];
    self.lbIncome.text = [NSString stringWithFormat:@"%@", [Util getDecimalStyle:self.statmodel.monthTotalIn]];
//    self.lbEarnings.text = [NSString stringWithFormat:@"你的收益已打败了%d%@的经纪人", (int)self.statmodel.monthTotalRatio, @"%"];
    if([[UserInfoModel shareUserInfoModel].userId isEqualToString:self.userId])
        self.lbEarnings.attributedText = [self getAttbuteString:[NSString stringWithFormat:@"你的收益已打败了 %.2f%@ 的经纪人", self.statmodel.monthTotalRatio, @"%"] sub:[NSString stringWithFormat:@"%.2f%@", self.statmodel.monthTotalRatio, @"%"]];
    else
        self.lbEarnings.attributedText = [self getAttbuteString:[NSString stringWithFormat:@"他的收益已打败了 %.2f%@ 的经纪人", self.statmodel.monthTotalRatio, @"%"] sub:[NSString stringWithFormat:@"%.2f%@", self.statmodel.monthTotalRatio, @"%"]];
    
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
    
    self.piechat.lbAmount.text = [Util getDecimalStyle:self.statmodel.monthInInsurance + self.statmodel.monthInTeam + self.statmodel.monthInRedPack + self.statmodel.monthInLeader];
    
    [self.piechat reloadData];
    
}

- (void) doBtnDetailAccount:(UIButton *)sender
{
    DetailAccountVC *vc = [[DetailAccountVC alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)initDataWithArray:(NSArray*)array
{
    CGFloat max = 0;
    for (int i = 0; i < [array count]; i++) {
        CurveModel *model = [array objectAtIndex:i];
        int o = (int)model.totalIn;
        if(o > max)
            max = o;
    }
    
    NSInteger ystep = 0;
    if( ((int)max % 5) == 0 )
        ystep = max / 5;
    else
        ystep = max / 5 + 1;
    if(ystep == 0)
        ystep = 1;
    
    NSMutableArray *sarray = [[NSMutableArray alloc] init];
    int i = 0;
    while ([sarray count] < 6) {
        [sarray addObject:[NSString stringWithFormat:@"%d", i]];
        i += ystep;
    }
    
    self.chatview.ySteps = sarray;

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
            NSString *lp = [NSString stringWithFormat:@"%f", model.totalIn];
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
            y = y / ystep ;
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
