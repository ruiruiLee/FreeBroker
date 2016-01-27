//
//  NetWorkHandler+queryForInsuranceOffersList.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/13.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+queryForInsuranceOffersList.h"
#import "define.h"

@implementation NetWorkHandler (queryForInsuranceOffersList)

+ (void) requestToQueryForInsuranceOffersList:(NSString *) orderId
                                insuranceType:(NSString *) insuranceType
                                   Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    
    [Util setValueForKeyWithDic:pramas value:orderId key:@"orderId"];
    [Util setValueForKeyWithDic:pramas value:insuranceType key:@"insuranceType"];
    
    [handle postWithMethod:@"/web/insurance/queryForInsuranceOffersList.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
