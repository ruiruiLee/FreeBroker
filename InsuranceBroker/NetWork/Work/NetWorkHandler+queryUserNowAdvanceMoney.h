//
//  NetWorkHandler+queryUserNowAdvanceMoney.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (queryUserNowAdvanceMoney)

+ (void) requestToQueryUserNowAdvanceMoney:(NSString *) userId Completion:(Completion)completion;

@end
