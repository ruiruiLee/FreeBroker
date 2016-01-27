//
//  NetWorkHandler+news.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/12.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (news)

/*
 category: 信息类别,
 userId:44 //经纪人id
 offset: 0//偏移量，默认为0
 limit:20,//分页大小
 */

+ (void) requestToNews:(NSString *) category
                userId:(NSString *) userId
                offset:(NSInteger) offset
                 limit:(NSInteger) limit
            completion:(Completion)completion;

@end
