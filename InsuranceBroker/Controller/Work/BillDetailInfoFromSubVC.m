//
//  BillDetailInfoFromSubVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/3/2.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BillDetailInfoFromSubVC.h"

@implementation BillDetailInfoFromSubVC

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (void) initData
{
    [self setDataFromSub];
    self.lbTotalAmount.text = [NSString stringWithFormat:@"+%@",self.billInfo.billMoney];
}

@end
