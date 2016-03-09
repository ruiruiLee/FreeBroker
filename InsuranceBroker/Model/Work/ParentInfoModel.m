//
//  ParentInfoModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/2/25.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "ParentInfoModel.h"

@implementation ParentInfoModel

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    ParentInfoModel *model = [[ParentInfoModel alloc] init];
    
    model.parentRealName = [dictionary objectForKey:@"parentRealName"];
    model.parentUserName = [dictionary objectForKey:@"parentUserName"];
    model.parentHeaderImg = [dictionary objectForKey:@"parentHeaderImg"];
    model.parentPhone = [dictionary objectForKey:@"parentPhone"];
    model.parentUserSex = [[dictionary objectForKey:@"parentUserSex"] integerValue];
    
    return model;
}

@end
