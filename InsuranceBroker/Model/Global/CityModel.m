//
//  CityModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/11.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "CityModel.h"

@implementation CityModel

+ (NSArray *) modelArrayFromArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        [result addObject:[CityModel modelFromDictionary:dic]];
    }
    
    return result;
}

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    CityModel *model = [[CityModel alloc] init];
    
    model.cityHot = [dictionary objectForKey:@"cityHot"];
    model.cityId = [dictionary objectForKey:@"cityId"];
    model.cityLetter = [dictionary objectForKey:@"cityLetter"];
    model.cityName = [dictionary objectForKey:@"cityName"];
    model.cityPy = [dictionary objectForKey:@"cityPy"];
    model.cityShortName = [dictionary objectForKey:@"cityShortName"];
    model.cityShortPy = [dictionary objectForKey:@"cityShortPy"];
    model.cityStatus = [dictionary objectForKey:@"cityStatus"];
    model.latitude = [dictionary objectForKey:@"latitude"];
    model.longitude = [dictionary objectForKey:@"longitude"];
    model.provinceId = [dictionary objectForKey:@"provinceId"];
    model.seqNo = [dictionary objectForKey:@"seqNo"];
    model.tel = [dictionary objectForKey:@"tel"];
    
    return model;
}

@end
