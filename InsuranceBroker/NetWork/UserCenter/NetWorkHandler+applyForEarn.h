//
//  NetWorkHandler+applyForEarn.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (applyForEarn)

+ (void) requestToApplyForEarn:(NSString *) backCardId useId:(NSString *) useId money:(NSString *) money Completion:(Completion) completion;

@end
