//
//  PotentialPlayerModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/20.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "PotentialPlayerModel.h"

@implementation PotentialPlayerModel

+ (NSArray *) modelArrayFromArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        [result addObject:[PotentialPlayerModel modelFromDictionary:dic]];
    }
    
    return result;
}

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    PotentialPlayerModel *model = [[PotentialPlayerModel alloc] init];
    
    model.userWechatId = [dictionary objectForKey:@"userWechatId"];
    model.userId = [dictionary objectForKey:@"userId"];
    model.openId = [dictionary objectForKey:@"openId"];
    model.rawId = [dictionary objectForKey:@"rawId"];
    model.unionId = [dictionary objectForKey:@"unionId"];
    model.createdAt = [dictionary objectForKey:@"createdAt"];
    model.updatedAt = [dictionary objectForKey:@"updatedAt"];
    model.subscribe = [dictionary objectForKey:@"subscribe"];
    model.groupId = [dictionary objectForKey:@"groupId"];
    model.headImg = [dictionary objectForKey:@"headImg"];
    model.subscribeTime = [dictionary objectForKey:@"subscribeTime"];
    
    model.language = [dictionary objectForKey:@"language"];
    model.remark = [dictionary objectForKey:@"remark"];
    model.country = [dictionary objectForKey:@"country"];
    model.province = [dictionary objectForKey:@"province"];
    model.city = [dictionary objectForKey:@"city"];
    model.status = [[dictionary objectForKey:@"status"] integerValue];
    model.nickName = [dictionary objectForKey:@"nickName"];
    model.parentUserId = [dictionary objectForKey:@"parentUserId"];
    model.sex = [[dictionary objectForKey:@"sex"] integerValue];
    
    return model;
}

@end
