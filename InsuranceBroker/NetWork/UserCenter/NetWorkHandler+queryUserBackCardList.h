//
//  NetWorkHandler+queryUserBackCardList.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/20.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (queryUserBackCardList)

+ (void) requesToQueryUserBackCardList:(NSString *) userId backCardStatus:(NSString *) backCardStatus Completion:(Completion) completion;

@end
