//
//  NetWorkHandler+queryUserBillDetail.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/3/2.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (queryUserBillDetail)

+ (void) requestToQueryUserBillDetail:(NSString *) billId Completion:(Completion)completion;

@end
