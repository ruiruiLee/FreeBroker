//
//  InsuranceCompanyModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/14.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "InsuranceCompanyModel.h"

@implementation InsuranceCompanyModel

+ (NSArray *) modelArrayFromArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        [result addObject:[InsuranceCompanyModel modelFromDictionary:dic]];
    }
    
    return result;
}

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    InsuranceCompanyModel *model = [[InsuranceCompanyModel alloc] init];
    
    model.insuranceCompanyId = [dictionary objectForKey:@"insuranceCompanyId"];
    model.insuranceCompanyName = [dictionary objectForKey:@"insuranceCompanyName"];
    model.insuranceCompanyShortName = [dictionary objectForKey:@"insuranceCompanyShortName"];
    model.insuranceCompanyLogo = [dictionary objectForKey:@"insuranceCompanyLogo"];
    model.insuranceType = [dictionary objectForKey:@"insuranceType"];
    
    return model;
}

@end
