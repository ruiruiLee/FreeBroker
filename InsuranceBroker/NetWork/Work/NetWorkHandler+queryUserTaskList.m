//
//  NetWorkHandler+queryUserTaskList.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/21.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+queryUserTaskList.h"
#import "define.h"

@implementation NetWorkHandler (queryUserTaskList)

+ (void) requestToQueryUserTaskList:(NSString *) userId Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:userId key:@"userId"];
    
    [handle postWithMethod:@"/web/userTask/queryUserTaskList.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
