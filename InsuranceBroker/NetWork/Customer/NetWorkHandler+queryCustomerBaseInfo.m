//
//  NetWorkHandler+queryCustomerBaseInfo.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/5.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+queryCustomerBaseInfo.h"
#import "define.h"

@implementation NetWorkHandler (queryCustomerBaseInfo)

+ (void) requestToQueryCustomerBaseInfo:(NSString *)customerId carInfo:(NSString*)carInfo Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:customerId key:@"customerId"];
    [Util setValueForKeyWithDic:pramas value:carInfo key:@"carInfo"];
    
    [handle postWithMethod:@"/web/customer/queryCustomerBaseInfo.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
    
}

@end
