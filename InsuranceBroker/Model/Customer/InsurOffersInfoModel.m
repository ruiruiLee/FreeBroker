//
//  InsurOffersInfoModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/13.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "InsurOffersInfoModel.h"

@implementation InsurOffersInfoModel

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    InsurOffersInfoModel *model = [[InsurOffersInfoModel alloc] init];
    
    model.insuranceOrderId = [dictionary objectForKey:@"insuranceOrderId"];
    model.insuranceOrderUuid = [dictionary objectForKey:@"insuranceOrderUuid"];
    model.insuranceOrderNo = [dictionary objectForKey:@"insuranceOrderNo"];
    model.planType = [[dictionary objectForKey:@"planType"] integerValue];
    model.planId = [dictionary objectForKey:@"planId"];
    model.insuranceType = [[dictionary objectForKey:@"insuranceType"] integerValue];
    model.createdAt = [InsurOffersInfoModel dateFromString:[dictionary objectForKey:@"createdAt"]];
    model.orderStatus = [[dictionary objectForKey:@"orderStatus"] integerValue];
    model.orderOfferStatus = [[dictionary objectForKey:@"orderOfferStatus"] integerValue];
    model.orderOfferTime = [InsurOffersInfoModel dateFromString:[dictionary objectForKey:@"orderOfferTime"]];
    model.orderOfferStatusId = [dictionary objectForKey:@"orderOfferStatusId"];
    model.orderOfferStatusMsg = [dictionary objectForKey:@"orderOfferStatusMsg"];
    model.orderOfferStatusDescr = [dictionary objectForKey:@"orderOfferStatusDescr"];
    model.orderOfferPayType = [[dictionary objectForKey:@"orderOfferPayType"] integerValue];
    model.orderOfferNums = [[dictionary objectForKey:@"orderOfferNums"] integerValue];
    model.orderOfferOrigPrice = [[dictionary objectForKey:@"orderOfferOrigPrice"] floatValue];
    model.orderOfferRatio = [[dictionary objectForKey:@"orderOfferRatio"] floatValue];
    model.orderOfferPayPrice = [[dictionary objectForKey:@"orderOfferPayPrice"] floatValue];
    model.customerName = [dictionary objectForKey:@"customerName"];
    model.carNo = [dictionary objectForKey:@"carNo"];
    model.offersVoList = [OffersModel modelArrayFromArray:[dictionary objectForKey:@"offersVoList"]];
    model.planTypeName = [dictionary objectForKey:@"planTypeName"];
    
    return model;
}

@end
