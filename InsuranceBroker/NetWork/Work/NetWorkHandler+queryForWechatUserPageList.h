//
//  NetWorkHandler+queryForWechatUserPageList.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/20.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (queryForWechatUserPageList)

+ (void) requestToQueryForWechatUserPageList:(NSString *)userId offset:(NSInteger) offset limit:(NSInteger)limit Completion:(Completion)completion;

@end
