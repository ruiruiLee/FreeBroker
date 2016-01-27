//
//  NetWorkHandler+queryForWechatUserPageList.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/20.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+queryForWechatUserPageList.h"
#import "define.h"

@implementation NetWorkHandler (queryForWechatUserPageList)

+ (void) requestToQueryForWechatUserPageList:(NSString *)userId offset:(NSInteger) offset limit:(NSInteger)limit Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:userId key:@"userId"];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:offset] key:@"offset"];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:limit] key:@"limit"];
    
    [handle postWithMethod:@"/web/user/queryForWechatUserPageList.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
