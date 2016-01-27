//
//  BankInfoModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/20.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BankInfoModel.h"

@implementation BankInfoModel

+ (NSArray *) modelArrayFromArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        [result addObject:[BankInfoModel modelFromDictionary:dic]];
    }
    
    return result;
}

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    BankInfoModel *model = [[BankInfoModel alloc] init];
    model.backId = [dictionary objectForKey:@"backId"];
    model.backStatus = [dictionary objectForKey:@"backStatus"];
    model.backLogo = [dictionary objectForKey:@"backLogo"];
    model.backName = [dictionary objectForKey:@"backName"];
    model.backShortName = [dictionary objectForKey:@"backShortName"];
    model.createdAt = [dictionary objectForKey:@"createdAt"];
    model.updatedAt = [dictionary objectForKey:@"updatedAt"];
    model.dayMaxMoney = [dictionary objectForKey:@"dayMaxMoney"];
    model.dayMaxNums = [dictionary objectForKey:@"dayMaxNums"];
    model.numsMaxMoney = [dictionary objectForKey:@"numsMaxMoney"];
    model.seqNo = [dictionary objectForKey:@"seqNo"];
    
    
    return model;
}

@end
