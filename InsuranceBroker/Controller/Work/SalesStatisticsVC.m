//
//  SalesStatisticsVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/17.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "SalesStatisticsVC.h"
#import "NetWorkHandler+queryStatistics.h"
#import "define.h"
#import "SalesStatisticsModel.h"
#import "SalesModel.h"

@interface SalesStatisticsVC ()

@property (nonatomic, strong) NSArray *curveArray;
@property (nonatomic, strong) SalesStatisticsModel *statmodel;

@end

@implementation SalesStatisticsVC
@synthesize imgWithNoData;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.title = @"销售统计";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.viewHConstraint.constant = ScreenWidth;
    
    self.chatview.yMin = 0;
    self.chatview.yMax = 5;
    self.chatview.ySteps = @[@"0",@"1", @"2", @"3", @"4", @"5"];
    self.chatview.backgroundColor = [UIColor clearColor];
    
    [self loadData];
}

- (void) loadData
{
    [NetWorkHandler requestToQueryStatistics:self.userId staticsType:@"1" Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            self.statmodel = (SalesStatisticsModel*)[SalesStatisticsModel modelFromDictionary:[[content objectForKey:@"data"] objectForKey:@"statistics"]];
            self.curveArray = [SalesModel modelArrayFromArray:[[content objectForKey:@"data"] objectForKey:@"curve"]];
            [self initData];
        }
    }];
}

- (void) initData
{
    self.lbEarningsCount.text = [NSString stringWithFormat:@"累计销量：%d单", self.statmodel.totalInNums];
    self.lbIncome.text = [NSString stringWithFormat:@"%d", self.statmodel.monthTotalInNums];
    if([[UserInfoModel shareUserInfoModel].userId isEqualToString:self.userId])
        self.lbEarnings.attributedText = [self getAttbuteString:[NSString stringWithFormat:@"你的销量已打败了 %d%@ 的经纪人", self.statmodel.monthTotalRatio, @"%"] sub:[NSString stringWithFormat:@"%d%@", self.statmodel.monthTotalRatio, @"%"]];
    else
        self.lbEarnings.attributedText = [self getAttbuteString:[NSString stringWithFormat:@"他的销量已打败了 %d%@ 的经纪人", self.statmodel.monthTotalRatio, @"%"] sub:[NSString stringWithFormat:@"%d%@", self.statmodel.monthTotalRatio, @"%"]];
    
    [self initDataWithArray:self.curveArray];
}

- (void)initDataWithArray:(NSArray*)array
{
    CGFloat max = 0;
    for (int i = 0; i < [array count]; i++) {
        SalesModel *model = [array objectAtIndex:i];
        int o = (int)model.totalInNums;
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
            SalesModel *model = [array objectAtIndex:i];
            [arr addObject:@(j)];
            NSString *lp = [NSString stringWithFormat:@"%d", (int)model.totalInNums];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self showNoDatasImage:ThemeImage(@"no_data")];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.topView setGradientColor:_COLOR(0xff, 0x8c, 0x19) end:_COLOR(0xff, 0x66, 0x19)];
}

- (void) showNoDatasImage:(UIImage *) image
{
    if(!self.explainBgView){
        self.explainBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 80)];
        imgWithNoData = [[UIImageView alloc] initWithImage:image];
        [self.explainBgView addSubview:imgWithNoData];
        [self.view addSubview:self.explainBgView];
        self.explainBgView.center = CGPointMake(ScreenWidth/2, self.view.frame.size.height/2);
    }
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

@end
