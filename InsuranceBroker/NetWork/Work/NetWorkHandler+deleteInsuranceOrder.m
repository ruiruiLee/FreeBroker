//
//  NetWorkHandler+deleteInsuranceOrder.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/3/2.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+deleteInsuranceOrder.h"
#import "define.h"

@implementation NetWorkHandler (deleteInsuranceOrder)

+ (void) requestToDeleteInsuranceOrder:(NSString *) orderId userId:(NSString *) userId Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:orderId key:@"orderId"];
    [Util setValueForKeyWithDic:pramas value:userId key:@"userId"];
    
    [handle postWithMethod:@"/web/insurance/deleteInsuranceOrder.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
