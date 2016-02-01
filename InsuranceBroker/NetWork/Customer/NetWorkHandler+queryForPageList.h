//
//  NetWorkHandler+queryForPageList.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/4.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (queryForPageList)

+ (void) requestQueryForPageList:(NSInteger) offset
                           limit:(NSInteger) limit
                            sord:(NSString *) sord
                         filters:(NSDictionary *) filters
                      Completion:(Completion)completion;

+ (void) requestUserQueryForPageList:(NSInteger) offset
                               limit:(NSInteger) limit
                                sord:(NSString *) sord
                                sidx:(NSString *) sidx
                             filters:(NSDictionary *) filters
                          Completion:(Completion)completion;

@end
