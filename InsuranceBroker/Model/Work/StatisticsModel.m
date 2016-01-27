//
//  StatisticsModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "StatisticsModel.h"

@implementation StatisticsModel

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    StatisticsModel *model = [[StatisticsModel alloc] init];
    
    model.statisticsId = [dictionary objectForKey:@"statisticsId"];
    model.userId = [dictionary objectForKey:@"userId"];
    model.beginTime = [BaseModel dateFromString:[dictionary objectForKey:@"beginTime"]];
    model.endTime = [BaseModel dateFromString:[dictionary objectForKey:@"endTime"]];
    model.createdAt = [BaseModel dateFromString:[dictionary objectForKey:@"createdAt"]];
    model.monthTotalIn = [[dictionary objectForKey:@"monthTotalIn"] floatValue];
    model.monthTotalOut = [[dictionary objectForKey:@"monthTotalOut"] floatValue];
    model.monthTotalRatio = [[dictionary objectForKey:@"monthTotalRatio"] floatValue];
    model.monthInInsurance = [[dictionary objectForKey:@"monthInInsurance"] floatValue];
    model.monthInTeam = [[dictionary objectForKey:@"monthInTeam"] floatValue];
    model.monthInRedPack = [[dictionary objectForKey:@"monthInRedPack"] floatValue];
    model.monthInLeader = [[dictionary objectForKey:@"monthInLeader"] floatValue];
    model.totalIn = [[dictionary objectForKey:@"totalIn"] floatValue];
    
    return model;
}

@end
