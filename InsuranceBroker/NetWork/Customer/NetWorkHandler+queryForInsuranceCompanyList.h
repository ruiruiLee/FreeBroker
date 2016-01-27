//
//  NetWorkHandler+queryForInsuranceCompanyList.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/14.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (queryForInsuranceCompanyList)

/*
 insuranceCompanyId:1//保险公司ID
 insuranceType:1//1车险，不传值获取所有
 */

+ (void) requestToQueryForInsuranceCompanyList:(NSString *) insuranceCompanyId
                                 insuranceType:(NSString *) insuranceType
                                    Completion:(Completion)completion;

@end
