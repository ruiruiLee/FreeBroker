//
//  CustomerDetailModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/5.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "CustomerDetailModel.h"

@implementation CustomerDetailModel

- (id) init
{
    self = [super init];
    if(self){
        self.customerSex = 1;
        self.cardVerifiy = 0;
    }
    
    return self;
}

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    CustomerDetailModel *model = [[CustomerDetailModel alloc] init];
    
    model.userId = [dictionary objectForKey:@"userId"];
    model.customerId = [dictionary objectForKey:@"customerId"];
    model.customerName = [dictionary objectForKey:@"customerName"];
    model.customerPhone = [dictionary objectForKey:@"customerPhone"];
    model.customerTel = [dictionary objectForKey:@"customerTel"];
    model.headImg = [dictionary objectForKey:@"headImg"];
    model.cardNumber = [dictionary objectForKey:@"cardNumber"];
    model.cardNumberImg1 = [dictionary objectForKey:@"cardNumberImg1"];
    model.cardNumberImg2 = [dictionary objectForKey:@"cardNumberImg2"];
    model.cardProvinceId = [dictionary objectForKey:@"cardProvinceId"];
    model.cardCityId = [dictionary objectForKey:@"cardCityId"];
    model.cardAreaId = [dictionary objectForKey:@"cardAreaId"];
    model.cardVerifiy = [[dictionary objectForKey:@"cardVerifiy"] integerValue];
    model.cardAddr = [dictionary objectForKey:@"cardAddr"];
    model.verifiyTime = [CustomerDetailModel dateFromString:[dictionary objectForKey:@"verifiyTime"]];
    model.liveProvinceId = [dictionary objectForKey:@"liveProvinceId"];
    model.liveCityId = [dictionary objectForKey:@"liveCityId"];
    model.liveAreaId = [dictionary objectForKey:@"liveAreaId"];
    model.liveAddr = [dictionary objectForKey:@"liveAddr"];
    model.customerStatus = [[dictionary objectForKey:@"customerStatus"] boolValue];
    model.drivingCard1 = [dictionary objectForKey:@"drivingCard1"];
    model.drivingCard2 = [dictionary objectForKey:@"drivingCard2"];
    model.customerLabel = [dictionary objectForKey:@"customerLabel"];
    model.customerLabelId = [dictionary objectForKey:@"customerLabelId"];
    model.isAgentCreate = [[dictionary objectForKey:@"isAgentCreate"] boolValue];
    model.createdAt = [CustomerDetailModel dateFromString:[dictionary objectForKey:@"createdAt"]];
    model.customerSex = [[dictionary objectForKey:@"customerSex"] integerValue];
    model.customerBirthday = [CustomerDetailModel dateFromString:[dictionary objectForKey:@"customerBirthday"]];
    
    NSArray *car = [dictionary objectForKey:@"carInfo"];
    if([car count] > 0)
        model.carInfo = (CarInfoModel*)[CarInfoModel modelFromDictionary:[car objectAtIndex:0]];
    
    model.isLoadVisit = NO;
    model.visitAttay = [[NSMutableArray alloc] init];
    model.visitTotal = 0;
    
    model.isLoadInsur = NO;
    model.insurTotal = 0;
    model.insurArray = [[NSMutableArray alloc] init];
    
    return model;
}

- (NSString *) getCustomerLabelString
{
    NSMutableString *result = [[NSMutableString alloc] init];
    for (int i = 0; i < [self.customerLabel count]; i++) {
        NSString *string = [self.customerLabel objectAtIndex:i];
        [result appendString:string];
        [result appendString:@"   "];
    }
    return result;
}

@end
