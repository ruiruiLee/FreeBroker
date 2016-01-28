//
//  OffersModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/18.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "OffersModel.h"

@implementation OffersModel

- (id) init
{
    self = [super init];
    if(self){
        self.isRatioSubmit = YES;
    }
    
    return self;
}

+ (NSArray *) modelArrayFromArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        [result addObject:[OffersModel modelFromDictionary:dic]];
    }
    
    return result;
}

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    OffersModel *model = [[OffersModel alloc] init];
    
    model.planOfferFailedMsg = [dictionary objectForKey:@"planOfferFailedMsg"];
    model.planOfferId = [dictionary objectForKey:@"planOfferId"];
    model.planOfferPayType = [[dictionary objectForKey:@"planOfferPayType"] integerValue];
    model.planOfferStatus = [[dictionary objectForKey:@"planOfferStatus"] integerValue];
    model.planOfferStatusMsg = [dictionary objectForKey:@"planOfferStatusMsg"];
    model.productLogo = [dictionary objectForKey:@"productLogo"];
    model.productName = [dictionary objectForKey:@"productName"];
    model.respAddr = [dictionary objectForKey:@"respAddr"];
    model.planInsuranceCompanyPrice = [[dictionary objectForKey:@"planInsuranceCompanyPrice"] floatValue];
    model.planUkbPrice = [[dictionary objectForKey:@"planUkbPrice"] floatValue];
    model.planUkbRatio = [[dictionary objectForKey:@"planUkbRatio"] floatValue];
    model.planUkbSavePrice = [[dictionary objectForKey:@"planUkbSavePrice"] floatValue];
    model.productMaxRatio = [[dictionary objectForKey:@"productMaxRatio"] floatValue];
    model.productMinRatio = [[dictionary objectForKey:@"productMinRatio"] floatValue];
    
    model.businessPrice = [[dictionary objectForKey:@"businessPrice"] floatValue];
    model.fjxPrice = [[dictionary objectForKey:@"fjxPrice"] floatValue];
    model.jbxPrice = [[dictionary objectForKey:@"jbxPrice"] floatValue];
    model.jqxCcsPrice = [[dictionary objectForKey:@"jqxCcsPrice"] floatValue];
    model.planAbonusPrice = [[dictionary objectForKey:@"planAbonusPrice"] floatValue];
    model.levelRatio = [[dictionary objectForKey:@"levelRatio"] floatValue];
    model.allotBonusRatio = [[dictionary objectForKey:@"allotBonusRatio"] floatValue];
    model.planUserAllot = [[dictionary objectForKey:@"planUserAllot"] floatValue];
    
    return model;
}

@end
