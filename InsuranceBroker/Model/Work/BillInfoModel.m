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
    [model setContentFromDictionary:dictionary];
    return model;
}

- (id) init
{
    self = [super init];
    if(self){
        self.isLoadDetail = NO;
    }
    
    return self;
}

- (void) setContentFromDictionary:(NSDictionary *)dictionary
{
    if([dictionary objectForKey:@"billId"])
        self.billId = [dictionary objectForKey:@"billId"];
    if([dictionary objectForKey:@"billType"])
        self.billType = [[dictionary objectForKey:@"billType"] integerValue];
    if([dictionary objectForKey:@"billTypeName"])
        self.billTypeName = [dictionary objectForKey:@"billTypeName"];
    if([dictionary objectForKey:@"createdAt"])
        self.createdAt = [BaseModel dateFromString:[dictionary objectForKey:@"createdAt"]];
    if([dictionary objectForKey:@"userId"])
        self.userId = [dictionary objectForKey:@"userId"];
    if([dictionary objectForKey:@"memo"])
        self.memo = [dictionary objectForKey:@"memo"];
    if([dictionary objectForKey:@"advanceId"])
        self.advanceId = [dictionary objectForKey:@"advanceId"];
    if([dictionary objectForKey:@"insuranceOrderEarnId"])
        self.insuranceOrderEarnId = [dictionary objectForKey:@"insuranceOrderEarnId"];
    if([dictionary objectForKey:@"redPackUserId"])
        self.redPackUserId = [dictionary objectForKey:@"redPackUserId"];
    if([dictionary objectForKey:@"billStatus"])
        self.billStatus = [[dictionary objectForKey:@"billStatus"] integerValue];
    if([dictionary objectForKey:@"billDoType"])
        self.billDoType = [[dictionary objectForKey:@"billDoType"] integerValue];
    if([dictionary objectForKey:@"billMoney"])
        self.billMoney = [dictionary objectForKey:@"billMoney"];
    if([dictionary objectForKey:@"auditStatus"])
        self.auditStatus = [dictionary objectForKey:@"auditStatus"];
    if([dictionary objectForKey:@"planUkbRatio"])
        self.planUkbRatio = [[dictionary objectForKey:@"planUkbRatio"] floatValue];
    if([dictionary objectForKey:@"productMaxRatio"])
        self.productMaxRatio = [[dictionary objectForKey:@"productMaxRatio"] floatValue];
    if([dictionary objectForKey:@"insuranceOrderNo"])
        self.insuranceOrderNo = [dictionary objectForKey:@"insuranceOrderNo"];
    if([dictionary objectForKey:@"insuranceOrderUuid"])
        self.insuranceOrderUuid = [dictionary objectForKey:@"insuranceOrderUuid"];
}

@end
