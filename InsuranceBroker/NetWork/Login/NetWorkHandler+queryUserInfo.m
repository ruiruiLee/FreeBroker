//
//  NetWorkHandler+queryUserInfo.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/6.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+queryUserInfo.h"
#import "define.h"

@implementation NetWorkHandler (queryUserInfo)

+ (void) requestToQueryUserInfo:(NSString *)userId Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:userId key:@"userId"];
    
    [handle postWithMethod:@"/web/user/queryUserInfo.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
