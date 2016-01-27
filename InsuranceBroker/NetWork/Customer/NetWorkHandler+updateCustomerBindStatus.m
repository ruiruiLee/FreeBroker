//
//  NetWorkHandler+updateCustomerBindStatus.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/14.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+updateCustomerBindStatus.h"
#import "define.h"

@implementation NetWorkHandler (updateCustomerBindStatus)

+ (void) requestToUpdateCustomerBindStatus:(NSString *)customeId
                                    userId:(NSString *)userId
                                Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    
    [Util setValueForKeyWithDic:pramas value:customeId key:@"customeId"];
    [Util setValueForKeyWithDic:pramas value:userId key:@"userId"];
    
    [handle postWithMethod:@"/web/customer/updateCustomerBindStatus.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
