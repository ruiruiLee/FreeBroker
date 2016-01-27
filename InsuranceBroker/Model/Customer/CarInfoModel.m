//
//  CarInfoModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/6.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "CarInfoModel.h"

@implementation CarInfoModel

- (id) init
{
    self = [super init];
    if(self){
        self.newCarNoStatus = 1;
    }
    
    return self;
}

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    if(dictionary == nil || [dictionary allKeys] == 0)
        return nil;
    
    CarInfoModel *model = [[CarInfoModel alloc] init];
    
    model.carNo = [dictionary objectForKey:@"carNo"];
    model.carProvince = [dictionary objectForKey:@"carProvince"];
    model.carCity = [dictionary objectForKey:@"carCity"];
    model.carProvinceId = [dictionary objectForKey:@"carProvinceId"];
    model.carCityId = [dictionary objectForKey:@"carCityId"];
    model.driveProvinceId = [dictionary objectForKey:@"driveProvinceId"];
    model.driveCityId = [dictionary objectForKey:@"driveCityId"];
    model.carTypeNo = [dictionary objectForKey:@"carTypeNo"];
    model.carShelfNo = [dictionary objectForKey:@"carShelfNo"];
    model.carEngineNo = [dictionary objectForKey:@"carEngineNo"];
    model.carOwnerName = [dictionary objectForKey:@"carOwnerName"];
    model.carOwnerCard = [dictionary objectForKey:@"carOwnerCard"];
    model.carOwnerPhone = [dictionary objectForKey:@"carOwnerPhone"];
    model.carOwnerTel = [dictionary objectForKey:@"carOwnerTel"];
    model.carOwnerAddr = [dictionary objectForKey:@"carOwnerAddr"];
    model.status = [[dictionary objectForKey:@"status"] integerValue];
    model.carRegTime = [BaseModel dateFromString:[dictionary objectForKey:@"carRegTime"]];//[dictionary objectForKey:@"carRegTime"];//[BaseModel dateFromString:[dictionary objectForKey:@"carRegTime"]];
    if([BaseModel dateIsNil:model.carRegTime])
        model.carRegTime = nil;
    model.customerCarId = [dictionary objectForKey:@"customerCarId"];
    model.customerId = [dictionary objectForKey:@"customerId"];
    
    model.travelCard1 = [dictionary objectForKey:@"travelCard1"];
    model.carInsurCompId1 = [dictionary objectForKey:@"carInsurCompId1"];
    model.newCarNoStatus = [[dictionary objectForKey:@"newCarNoStatus"] integerValue];
    if([dictionary objectForKey:@"newCarNoStatus"] == nil)
        model.newCarNoStatus = 1;
    model.carTradeStatus = [[dictionary objectForKey:@"carTradeStatus"] integerValue];
    model.carTradeTime = [BaseModel dateFromString:[dictionary objectForKey:@"carTradeTime"]] ;
    model.carInsurStatus1 = [[dictionary objectForKey:@"carInsurStatus1"] integerValue];
    
    return model;
}

+ (NSArray *) modelArrayFromArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        [result addObject:[CarInfoModel modelFromDictionary:dic]];
    }
    
    return result;
}

@end
