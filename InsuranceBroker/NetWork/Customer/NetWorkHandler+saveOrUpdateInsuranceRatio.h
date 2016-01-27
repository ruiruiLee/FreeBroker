//
//  NetWorkHandler+saveOrUpdateInsuranceRatio.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/13.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (saveOrUpdateInsuranceRatio)

+ (void) requestToSaveOrUpdateInsuranceRatio:(NSString *) orderId
                               insuranceType:(NSString *) insuranceType
                                 planOfferId:(NSString *) planOfferId
                                       ratio:(NSString *) ratio
                                      userId:(NSString *) userId
                                  Completion:(Completion)completion;

@end
