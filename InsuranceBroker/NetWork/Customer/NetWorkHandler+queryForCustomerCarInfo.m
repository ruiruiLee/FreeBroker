//
//  NetWorkHandler+queryForCustomerCarInfo.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/6.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+queryForCustomerCarInfo.h"
#import "define.h"

@implementation NetWorkHandler (queryForCustomerCarInfo)

+ (void) requestToQueryForCustomerCarInfo:(NSString *)customerCarId Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:customerCarId key:@"customerCarId"];
    
    [handle postWithMethod:@"/web/customer/queryForCustomerCarInfo.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
