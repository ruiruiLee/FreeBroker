//
//  TasksModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/21.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "TasksModel.h"

@implementation TasksModel

+ (NSArray *) modelArrayFromArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        [result addObject:[TasksModel modelFromDictionary:dic]];
    }
    
    return result;
}

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    TasksModel *model = [[TasksModel alloc] init];
    
    model.taskId = [dictionary objectForKey:@"taskId"];
    model.taskName = [dictionary objectForKey:@"taskName"];
    model.taskLimit = [[dictionary objectForKey:@"taskLimit"] integerValue];
    model.taskFinish = [[dictionary objectForKey:@"taskFinish"] integerValue];
    
    return model;
}


@end
