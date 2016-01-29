//
//  HaedlineModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/12.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "HaedlineModel.h"

@implementation HeadlineModel

+ (NSArray *) modelArrayFromArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        [result addObject:[HeadlineModel modelFromDictionary:dic]];
    }
    
    return result;
}

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    HeadlineModel *model = [[HeadlineModel alloc] init];
    
    model.hid = [dictionary objectForKey:@"id"];
    model.title = [dictionary objectForKey:@"title"];
    model.isRedirect = [[dictionary objectForKey:@"isRedirect"] boolValue];
    model.url = [dictionary objectForKey:@"url"];
    
    return model;
}

@end
