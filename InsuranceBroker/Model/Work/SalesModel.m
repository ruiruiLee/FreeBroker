//
//  SalesModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/3/4.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "SalesModel.h"

@implementation SalesModel

+ (NSArray *) modelArrayFromArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        [result addObject:[SalesModel modelFromDictionary:dic]];
    }
    
    return result;
}

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    SalesModel *model = [[SalesModel alloc] init];
    
    model.month = [dictionary objectForKey:@"month"];
//    model.totalIn = [[dictionary objectForKey:@"totalIn"] integerValue];
    model.totalInNums = [[dictionary objectForKey:@"totalInNums"] integerValue];
    
    return model;
}

@end
