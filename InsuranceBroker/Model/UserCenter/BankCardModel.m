//
//  BankCardModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/20.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BankCardModel.h"

@implementation BankCardModel

+ (NSArray *) modelArrayFromArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        [result addObject:[BankCardModel modelFromDictionary:dic]];
    }
    
    return result;
}

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    BankCardModel *model = [[BankCardModel alloc] init];
    
    model.backCardId = [dictionary objectForKey:@"backCardId"];
    model.backId = [dictionary objectForKey:@"backId"];
    model.userId = [dictionary objectForKey:@"userId"];
    model.defaultStatus = [[dictionary objectForKey:@"defaultStatus"] integerValue];
    model.backCardTypeId = [dictionary objectForKey:@"backCardTypeId"];
    model.backCardTailNo = [dictionary objectForKey:@"backCardTailNo"];
    model.moneyNums = [[dictionary objectForKey:@"moneyNums"] integerValue];
    model.moneyTotal = [[dictionary objectForKey:@"moneyTotal"] integerValue];
    model.moneyStatus = [[dictionary objectForKey:@"moneyStatus"] integerValue];
    model.backCardStatus = [[dictionary objectForKey:@"backCardStatus"] integerValue];
    model.cardholder = [dictionary objectForKey:@"cardholder"];
    model.openProvinceId = [dictionary objectForKey:@"openProvinceId"];
    model.openCityId = [dictionary objectForKey:@"openCityId"];
    model.openAreaId = [dictionary objectForKey:@"openAreaId"];
    model.openAddr = [dictionary objectForKey:@"openAddr"];
    model.openBackName = [dictionary objectForKey:@"openBackName"];
    model.backCardNo = [dictionary objectForKey:@"backCardNo"];
    model.backLogo = [dictionary objectForKey:@"backLogo"];
    
    return model;
}


@end
