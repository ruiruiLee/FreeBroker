//
//  NetWorkHandler+queryUserBillPageList.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (queryUserBillPageList)

+ (void) requestToQueryUserBillPageList:(NSInteger) offset limit:(NSInteger) limit sidx:(NSString *) sidx sord:(NSString *) sord filters:(NSDictionary *) filters Completion:(Completion)completion;

@end
