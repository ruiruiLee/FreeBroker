//
//  NetWorkHandler+queryCustomerBaseInfo.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/5.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (queryCustomerBaseInfo)

+ (void) requestToQueryCustomerBaseInfo:(NSString *) customerId carInfo:(NSString*)carInfo Completion:(Completion)completion;

@end
