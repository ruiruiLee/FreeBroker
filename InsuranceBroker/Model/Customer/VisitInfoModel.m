//
//  VisitInfoModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/7.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "VisitInfoModel.h"

@implementation VisitInfoModel

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    VisitInfoModel *model = [[VisitInfoModel alloc] init];
    
    model.visitId = [dictionary objectForKey:@"visitId"];
    model.visitTypeId = [dictionary objectForKey:@"visitTypeId"];
    model.visitType = [dictionary objectForKey:@"visitType"];
    model.visitProgress = [dictionary objectForKey:@"visitProgress"];
    model.userName = [dictionary objectForKey:@"userName"];
    model.visitAddr = [dictionary objectForKey:@"visitAddr"];
    model.visitProgressId = [dictionary objectForKey:@"visitProgressId"];
    model.visitMemo = [dictionary objectForKey:@"visitMemo"];
    model.visitTime = [BaseModel dateFromString:[dictionary objectForKey:@"visitTime"]];
    if([BaseModel dateIsNil:model.visitTime])
        model.visitTime = nil;
    model.visitLon = [[dictionary objectForKey:@"visitLon"] floatValue];
    model.visitLat = [[dictionary objectForKey:@"visitLat"] floatValue];
    
    return model;
}

+ (NSArray *) modelArrayFromArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        [result addObject:[VisitInfoModel modelFromDictionary:dic]];
    }
    
    return result;
}

@end
