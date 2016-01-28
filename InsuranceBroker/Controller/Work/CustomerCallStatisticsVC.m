//
//  CustomerCallStatisticsVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/17.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "CustomerCallStatisticsVC.h"
#import "define.h"

@interface CustomerCallStatisticsVC ()

@end

@implementation CustomerCallStatisticsVC
@synthesize imgWithNoData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"客户拜访";
    
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
    [self showNoDatasImage:ThemeImage(@"no_data")];
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

@end
