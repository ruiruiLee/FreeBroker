//
//  NetWorkHandler+strategy.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/13.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (strategy)

+ (void) requestToStrategy:(Completion)completion;

@end
