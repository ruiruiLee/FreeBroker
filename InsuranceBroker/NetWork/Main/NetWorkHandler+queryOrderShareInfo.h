//
//  NetWorkHandler+queryOrderShareInfo.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (queryOrderShareInfo)

+ (void) requestToQueryOrderShareInfo:(NSString *) uuid completion:(Completion)completion;

@end
