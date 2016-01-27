//
//  NetWorkHandler+queryRedPackList.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/20.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+queryRedPackList.h"
#import "define.h"

@implementation NetWorkHandler (queryRedPackList)

+ (void) requestToQueryRedPackList:(NSInteger) offset
                             limit:(NSInteger) limit
                              sidx:(NSString *) sidx
                              sord:(NSString*)sord
                            userId:(NSString *) userId
                           filters:(NSDictionary*) filters
                        Completion:(Completion) completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:offset] key:@"offset"];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:limit] key:@"limit"];
    [Util setValueForKeyWithDic:pramas value:sidx key:@"sidx"];
    [Util setValueForKeyWithDic:pramas value:sord key:@"sord"];
    [Util setValueForKeyWithDic:pramas value:userId key:@"userId"];
    [Util setValueForKeyWithDic:pramas value:[NetWorkHandler objectToJson:filters] key:@"filters"];
    
    
    [handle postWithMethod:@"/web/redPack/queryRedPackList.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
