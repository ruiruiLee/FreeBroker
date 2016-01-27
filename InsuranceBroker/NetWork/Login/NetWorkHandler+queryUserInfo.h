//
//  NetWorkHandler+queryUserInfo.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/6.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (queryUserInfo)

+ (void) requestToQueryUserInfo:(NSString *)userId Completion:(Completion)completion;

@end
