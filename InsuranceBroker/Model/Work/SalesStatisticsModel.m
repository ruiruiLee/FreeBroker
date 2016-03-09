//
//  SalesStatisticsModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/3/4.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "SalesStatisticsModel.h"

@implementation SalesStatisticsModel

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    SalesStatisticsModel *model = [[SalesStatisticsModel alloc] init];
    
    model.statisticsId = [dictionary objectForKey:@"statisticsId"];
    model.userId = [dictionary objectForKey:@"userId"];
    model.beginTime = [BaseModel dateFromString:[dictionary objectForKey:@"beginTime"]];
    model.endTime = [BaseModel dateFromString:[dictionary objectForKey:@"endTime"]];
    model.createdAt = [BaseModel dateFromString:[dictionary objectForKey:@"createdAt"]];
//    model.monthTotalIn = [[dictionary objectForKey:@"monthTotalIn"] integerValue];
    model.monthTotalOut = [[dictionary objectForKey:@"monthTotalOut"] integerValue];
    model.monthTotalRatio = [[dictionary objectForKey:@"monthTotalRatio"] integerValue];
    model.monthInInsurance = [[dictionary objectForKey:@"monthInInsurance"] integerValue];
    model.monthInTeam = [[dictionary objectForKey:@"monthInTeam"] integerValue];
    model.monthInRedPack = [[dictionary objectForKey:@"monthInRedPack"] integerValue];
    model.monthInLeader = [[dictionary objectForKey:@"monthInLeader"] integerValue];
//    model.totalIn = [[dictionary objectForKey:@"totalIn"] integerValue];
    model.monthTotalInNums = [[dictionary objectForKey:@"monthTotalInNums"] integerValue];
    model.totalInNums = [[dictionary objectForKey:@"totalInNums"] integerValue];
    
    return model;
}

@end
