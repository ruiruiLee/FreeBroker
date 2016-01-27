//
//  NetWorkHandler+queryRedPackList.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/20.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (queryRedPackList)

+ (void) requestToQueryRedPackList:(NSInteger) offset
                             limit:(NSInteger) limit
                              sidx:(NSString *) sidx
                              sord:(NSString*)sord
                            userId:(NSString *) userId
                           filters:(NSDictionary*) filters
                        Completion:(Completion) completion;

@end
