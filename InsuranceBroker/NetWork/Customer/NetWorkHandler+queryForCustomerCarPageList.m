//
//  NetWorkHandler+queryForCustomerCarPageList.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/7.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+queryForCustomerCarPageList.h"
#import "define.h"

@implementation NetWorkHandler (queryForCustomerCarPageList)

+ (void) requestToQueryForCustomerCarPageList:(NSInteger) offset
                                        limit:(NSInteger) limit
                                         sord:(NSString *)sord
                                     filters :(NSDictionary *)filters
                                   Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:offset] key:@"offset"];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:limit] key:@"limit"];
    [Util setValueForKeyWithDic:pramas value:sord key:@"sord"];
    
    [Util setValueForKeyWithDic:pramas value:[NetWorkHandler objectToJson:filters] key:@"filters"];
    
    [handle postWithMethod:@"/web/customer/queryForCustomerCarPageList.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}



@end
