//
//  NetWorkHandler+queryForInsuranceOffersList.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/13.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (queryForInsuranceOffersList)

+ (void) requestToQueryForInsuranceOffersList:(NSString *) orderId
                                insuranceType:(NSString *) insuranceType
                                   Completion:(Completion)completion;

@end
