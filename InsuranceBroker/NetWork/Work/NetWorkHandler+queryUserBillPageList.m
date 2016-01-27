//
//  NetWorkHandler+queryUserBillPageList.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+queryUserBillPageList.h"
#import "define.h"

@implementation NetWorkHandler (queryUserBillPageList)

+ (void) requestToQueryUserBillPageList:(NSInteger) offset limit:(NSInteger) limit sidx:(NSString *) sidx sord:(NSString *) sord filters:(NSDictionary *) filters Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:offset] key:@"offset"];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:limit] key:@"limit"];
    [Util setValueForKeyWithDic:pramas value:sidx key:@"sidx"];
    [Util setValueForKeyWithDic:pramas value:sord key:@"sord"];
    [Util setValueForKeyWithDic:pramas value:[NetWorkHandler objectToJson:filters] key:@"filters"];
    
    
    [handle postWithMethod:@"/web/userEarn/queryUserBillPageList.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
