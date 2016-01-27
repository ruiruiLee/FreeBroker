//
//  PosterModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/12.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "PosterModel.h"

@implementation PosterModel

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    PosterModel *model = [[PosterModel alloc] init];
    
    model.pid = [dictionary objectForKey:@"id"];
    model.title = [dictionary objectForKey:@"title"];
    model.url = [dictionary objectForKey:@"url"];
    model.imgUrl = [dictionary objectForKey:@"imgUrl"];
    model.isRedirect = [[dictionary objectForKey:@"isRedirect"] boolValue];
    
    return model;
}

+ (NSArray *) modelArrayFromArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        [result addObject:[PosterModel modelFromDictionary:dic]];
    }
    
    return result;
}

@end
