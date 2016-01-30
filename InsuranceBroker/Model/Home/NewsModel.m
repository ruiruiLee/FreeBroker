//
//  NewsModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/12.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NewsModel.h"

@implementation NewsModel

+ (NSArray *) modelArrayFromArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        [result addObject:[NewsModel modelFromDictionary:dic]];
    }
    
    return result;
}

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    NewsModel *model = [[NewsModel alloc] init];
    model.nid = [dictionary objectForKey:@"id"];
    model.title = [dictionary objectForKey:@"title"];
    model.content = [dictionary objectForKey:@"content"];
    model.imgUrl = [dictionary objectForKey:@"imgUrl"];
    model.isRedirect = [[dictionary objectForKey:@"isRedirect"] boolValue];
    model.createdAt = [NewsModel dateFromInteger:[[dictionary objectForKey:@"createdAt"] longLongValue]];
    model.keyId = [dictionary objectForKey:@"keyId"];
    model.keyType = [[dictionary objectForKey:@"keyType"] integerValue];
    
    return model;
}

@end
