//
//  BillDetailInfoFromLuckyVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/3/2.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BillDetailInfoFromLuckyVC.h"

@implementation BillDetailInfoFromLuckyVC

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (void) initData
{
    [self setDataFromLucky];
    self.lbTotalAmount.text = [NSString stringWithFormat:@"+%@",self.billInfo.billMoney];
}

@end
