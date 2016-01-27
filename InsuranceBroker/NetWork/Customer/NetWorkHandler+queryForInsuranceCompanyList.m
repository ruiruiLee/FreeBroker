//
//  NetWorkHandler+queryForInsuranceCompanyList.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/14.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+queryForInsuranceCompanyList.h"
#import "define.h"

@implementation NetWorkHandler (queryForInsuranceCompanyList)

+ (void) requestToQueryForInsuranceCompanyList:(NSString *) insuranceCompanyId
                                 insuranceType:(NSString *) insuranceType
                                    Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    
    [Util setValueForKeyWithDic:pramas value:insuranceCompanyId key:@"insuranceCompanyId"];
    [Util setValueForKeyWithDic:pramas value:insuranceType key:@"insuranceType"];
    
    [handle postWithMethod:@"/web/insurance/queryForInsuranceCompanyList.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
