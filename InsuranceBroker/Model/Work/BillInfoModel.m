//
//  BillInfoModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BillInfoModel.h"

@implementation BillInfoModel

+ (NSArray *) modelArrayFromArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        [result addObject:[BillInfoModel modelFromDictionary:dic]];
    }
    
    return result;
}

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    BillInfoModel *model = [[BillInfoModel alloc] init];
    
    model.billId = [dictionary objectForKey:@"billId"];
    model.billType = [[dictionary objectForKey:@"billType"] integerValue];
    model.billTypeName = [dictionary objectForKey:@"billTypeName"];
    model.createdAt = [BaseModel dateFromString:[dictionary objectForKey:@"createdAt"]];
    model.userId = [dictionary objectForKey:@"userId"];
    model.memo = [dictionary objectForKey:@"memo"];
    model.advanceId = [dictionary objectForKey:@"advanceId"];
    model.insuranceOrderEarnId = [dictionary objectForKey:@"insuranceOrderEarnId"];
    model.redPackUserId = [dictionary objectForKey:@"redPackUserId"];
    model.billStatus = [[dictionary objectForKey:@"billStatus"] integerValue];
    model.billDoType = [[dictionary objectForKey:@"billDoType"] integerValue];
    model.billMoney = [dictionary objectForKey:@"billMoney"];
    
    return model;
}

@end
