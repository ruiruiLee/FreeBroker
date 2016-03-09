//
//  NetWorkHandler+deleteInsuranceOrder.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/3/2.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (deleteInsuranceOrder)

+ (void) requestToDeleteInsuranceOrder:(NSString *) orderId userId:(NSString *) userId Completion:(Completion)completion;

@end
