//
//  NetWorkHandler+updateCustomerBindStatus.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/14.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (updateCustomerBindStatus)

+ (void) requestToUpdateCustomerBindStatus:(NSString *)customeId
                                    userId:(NSString *)userId
                                Completion:(Completion)completion;

@end
