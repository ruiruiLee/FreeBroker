//
//  BrokerInfoModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/13.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BrokerInfoModel.h"

@implementation BrokerInfoModel

+ (NSArray *) modelArrayFromArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        [result addObject:[BrokerInfoModel modelFromDictionary:dic]];
    }
    
    return result;
}

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    BrokerInfoModel *model = [[BrokerInfoModel alloc] init];
    
    model.userId = [dictionary objectForKey:@"userId"];
    model.realName = [dictionary objectForKey:@"realName"];
    model.phone = [dictionary objectForKey:@"phone"];
    model.cardNumber = [dictionary objectForKey:@"cardNumber"];
    model.userType = [[dictionary objectForKey:@"userType"] integerValue];
    model.status = [[dictionary objectForKey:@"status"] integerValue];
    model.headerImg = [dictionary objectForKey:@"headerImg"];
    model.userName = [dictionary objectForKey:@"userName"];
    model.monthOrderEarn = [dictionary objectForKey:@"monthOrderEarn"];
    model.userSex = [[dictionary objectForKey:@"userSex"] integerValue];
    model.orderSuccessNums = [[dictionary objectForKey:@"orderSuccessNums"] integerValue];
    model.nowMonthOrderSuccessNums = [[dictionary objectForKey:@"nowMonthOrderSuccessNums"] integerValue];
    
    return model;
}

@end
