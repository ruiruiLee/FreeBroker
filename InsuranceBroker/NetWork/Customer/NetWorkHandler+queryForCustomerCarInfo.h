//
//  NetWorkHandler+queryForCustomerCarInfo.h
//  InsuranceBroker
//
//  客户车险详细信息接口
//
//  Created by LiuZach on 16/1/6.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (queryForCustomerCarInfo)

+ (void) requestToQueryForCustomerCarInfo:(NSString *)customerCarId Completion:(Completion)completion;

@end
