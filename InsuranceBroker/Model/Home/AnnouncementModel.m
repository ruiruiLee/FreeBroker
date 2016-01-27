//
//  AnnouncementModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/12.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "AnnouncementModel.h"

@implementation AnnouncementModel

+ (NSArray *) modelArrayFromArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        [result addObject:[AnnouncementModel modelFromDictionary:dic]];
    }
    
    return result;
}

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    AnnouncementModel *model = [[AnnouncementModel alloc] init];
    model.category = [dictionary objectForKey:@"category"];
    model.title = [dictionary objectForKey:@"title"];
    model.lastNewsContent = [dictionary objectForKey:@"lastNewsContent"];
    model.lastNewsTitle = [dictionary objectForKey:@"lastNewsTitle"];
    model.lastNewsDt = [AnnouncementModel dateFromInteger:[[dictionary objectForKey:@"lastNewsDt"] longLongValue]];
    if([dictionary objectForKey:@"lastNewsDt"] == nil)
        model.lastNewsDt = nil;
    model.imgUrl = [dictionary objectForKey:@"imgUrl"];
    model.url = [dictionary objectForKey:@"url"];
    model.isRedirect = [[dictionary objectForKey:@"isRedirect"] boolValue];
    
    return model;
}

@end
