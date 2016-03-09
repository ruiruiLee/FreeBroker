//
//  NewUserModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/12.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NewUserModel.h"

@implementation NewUserModel

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    NewUserModel *model = [[NewUserModel alloc] init];
    model.nid = [dictionary objectForKey:@"id"];
    model.title = [dictionary objectForKey:@"title"];
    model.isRedirect = [[dictionary objectForKey:@"isRedirect"] boolValue];
    model.imgUrl = [dictionary objectForKey:@"imgUrl"];
    model.url = [dictionary objectForKey:@"url"];
    model.content = [dictionary objectForKey:@"content"];
    
    return model;
}

@end
