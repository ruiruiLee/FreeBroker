//
//  NetWorkHandler+saveOrUpdateInsuranceRatio.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/13.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+saveOrUpdateInsuranceRatio.h"
#import "define.h"

@implementation NetWorkHandler (saveOrUpdateInsuranceRatio)

+ (void) requestToSaveOrUpdateInsuranceRatio:(NSString *) orderId
                               insuranceType:(NSString *) insuranceType
                                 planOfferId:(NSString *) planOfferId
                                       ratio:(NSString *) ratio
                                      userId:(NSString *) userId
                                  Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    
    [Util setValueForKeyWithDic:pramas value:orderId key:@"orderId"];
    [Util setValueForKeyWithDic:pramas value:insuranceType key:@"insuranceType"];
    [Util setValueForKeyWithDic:pramas value:planOfferId key:@"planOfferId"];
    [Util setValueForKeyWithDic:pramas value:ratio key:@"ratio"];
    [Util setValueForKeyWithDic:pramas value:userId key:@"userId"];
    
    [handle postWithMethod:@"/web/insurance/saveOrUpdateInsuranceRatio.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
