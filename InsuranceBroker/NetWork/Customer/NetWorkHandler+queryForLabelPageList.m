//
//  NetWorkHandler+queryForLabelPageList.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/5.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+queryForLabelPageList.h"
#import "define.h"

@implementation NetWorkHandler (queryForLabelPageList)

+ (void) requestToQueryForLabelPageList:(BOOL) getCustomerNums Completion:(Completion)completion
{
    NSString *userid = [UserInfoModel shareUserInfoModel].userId;
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithBool:getCustomerNums] key:@"getCustomerNums"];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:0] key:@"offset"];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:1000] key:@"limit"];
    [Util setValueForKeyWithDic:pramas value:@"desc" key:@"sord"];
    NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:filters value:@"and" key:@"groupOp"];
    NSMutableArray *rules = [[NSMutableArray alloc] initWithObjects:[NetWorkHandler getRulesByField:@"userId" op:@"eq" data:userid], nil];
    [Util setValueForKeyWithDic:filters value:rules key:@"rules"];
    
    NSString *filtersStr = [NetWorkHandler objectToJson:filters];//[writer stringWithObject:filters];
    
    [Util setValueForKeyWithDic:pramas value:filtersStr key:@"filters"];
    
    [handle postWithMethod:@"/web/customer/queryForLabelPageList.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
    
}

+ (void) requestToLabelDetailPageList:(BOOL) getCustomerNums labelId:(NSString *) labelId Completion:(Completion)completion
{
    NSString *userid = [UserInfoModel shareUserInfoModel].userId;
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithBool:getCustomerNums] key:@"getCustomerNums"];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:0] key:@"offset"];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:1000] key:@"limit"];
    [Util setValueForKeyWithDic:pramas value:@"desc" key:@"sord"];
    NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:filters value:@"and" key:@"groupOp"];
    NSMutableArray *rules = [[NSMutableArray alloc] initWithObjects:[NetWorkHandler getRulesByField:@"userId" op:@"eq" data:userid],
                             [NetWorkHandler getRulesByField:@"labelId" op:@"eq" data:labelId],
                             nil];
    [Util setValueForKeyWithDic:filters value:rules key:@"rules"];
    
//    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    NSString *filtersStr = [NetWorkHandler objectToJson:filters];//[writer stringWithObject:filters];
    
    [Util setValueForKeyWithDic:pramas value:filtersStr key:@"filters"];
    
    [handle postWithMethod:@"/web/customer/queryForLabelPageList.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
