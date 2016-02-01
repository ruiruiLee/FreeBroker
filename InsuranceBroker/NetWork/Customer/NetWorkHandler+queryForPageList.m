//
//  NetWorkHandler+queryForPageList.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/4.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+queryForPageList.h"
#import "define.h"
#import "SBJson.h"

@implementation NetWorkHandler (queryForPageList)
+ (void) requestQueryForPageList:(NSInteger) offset
                           limit:(NSInteger) limit
                            sord:(NSString *) sord
                         filters:(NSDictionary *) filters
                      Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:offset] key:@"offset"];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:limit] key:@"limit"];
    [Util setValueForKeyWithDic:pramas value:sord key:@"sord"];
    [Util setValueForKeyWithDic:pramas value:@"updatedAt" key:@"sidx"];
    [Util setValueForKeyWithDic:pramas value:@"1" key:@"status"];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *filtersStr = [writer stringWithObject:filters];
    
    [Util setValueForKeyWithDic:pramas value:filtersStr key:@"filters"];
    
    [handle postWithMethod:@"/web/customer/queryForPageList.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

+ (void) requestUserQueryForPageList:(NSInteger) offset
                           limit:(NSInteger) limit
                            sord:(NSString *) sord
                            sidx:(NSString *) sidx
                         filters:(NSDictionary *) filters
                      Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:offset] key:@"offset"];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:limit] key:@"limit"];
    [Util setValueForKeyWithDic:pramas value:sord key:@"sord"];
    [Util setValueForKeyWithDic:pramas value:@"1" key:@"status"];
    [Util setValueForKeyWithDic:pramas value:sidx key:@"sidx"];
    
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *filtersStr = [writer stringWithObject:filters];
    
    [Util setValueForKeyWithDic:pramas value:filtersStr key:@"filters"];
    
    [handle postWithMethod:@"/web/user/queryForPageList.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
