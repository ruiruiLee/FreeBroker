//
//  CurveModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "CurveModel.h"

@implementation CurveModel

+ (NSArray *) modelArrayFromArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        [result addObject:[CurveModel modelFromDictionary:dic]];
    }
    
    return result;
}

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    CurveModel *model = [[CurveModel alloc] init];
    
    model.month = [dictionary objectForKey:@"month"];
    model.totalIn = [[dictionary objectForKey:@"totalIn"] integerValue];
    
    return model;
}

@end
