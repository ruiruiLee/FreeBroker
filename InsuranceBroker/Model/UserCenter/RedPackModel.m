//
//  RedPackModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/20.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "RedPackModel.h"

@implementation RedPackModel

+ (NSArray *) modelArrayFromArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        [result addObject:[RedPackModel modelFromDictionary:dic]];
    }
    
    return result;
}

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    RedPackModel *model = [[RedPackModel alloc] init];
    
    model.redPackId = [dictionary objectForKey:@"redPackId"];
    model.redPackType = [[dictionary objectForKey:@"redPackType"] integerValue];
    model.redPackTitle = [dictionary objectForKey:@"redPackTitle"];
    model.redPackRuleMemo = [dictionary objectForKey:@"redPackRuleMemo"];
    model.redPackMemo = [dictionary objectForKey:@"redPackMemo"];
    model.createdAt = [BaseModel dateFromString:[dictionary objectForKey:@"createdAt"]];
    model.updatedAt = [BaseModel dateFromString:[dictionary objectForKey:@"updatedAt"]];
    model.redPackValueType = [[dictionary objectForKey:@"redPackValueType"] integerValue];
    model.redPackValue = [[dictionary objectForKey:@"redPackValue"] integerValue];
    model.redPackObjId = [dictionary objectForKey:@"redPackObjId"];
    model.redPackStatus = [[dictionary objectForKey:@"redPackStatus"] integerValue];
    model.userId = [dictionary objectForKey:@"userId"];
    model.redPackUserStatus = [[dictionary objectForKey:@"redPackUserStatus"] integerValue];
    model.seqNo = [[dictionary objectForKey:@"seqNo"] integerValue];
    model.redPackLogo = [dictionary objectForKey:@"redPackLogo"];
    model.redPackBgImg = [dictionary objectForKey:@"redPackBgImg"];
    model.keepTop = [[dictionary objectForKey:@"keepTop"] boolValue];
    
    return model;
}

@end
