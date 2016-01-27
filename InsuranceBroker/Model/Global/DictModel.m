//
//  DictModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/7.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "DictModel.h"

@implementation DictModel

+ (NSArray *) modelArrayFromArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        [result addObject:[DictModel modelFromDictionary:dic]];
    }
    
    return result;
}

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    DictModel *model = [[DictModel alloc] init];
    
    model.dictId = [dictionary objectForKey:@"dictId"];
    model.dictValue = [dictionary objectForKey:@"dictValue"];
    model.dictType = [dictionary objectForKey:@"dictType"];
    model.dictName = [dictionary objectForKey:@"dictName"];
    model.dictEn = [dictionary objectForKey:@"dictEn"];
    model.status = [[dictionary objectForKey:@"status"] boolValue];
    model.seqNo = [[dictionary objectForKey:@"seqNo"] integerValue];
    
    return model;
}

@end
