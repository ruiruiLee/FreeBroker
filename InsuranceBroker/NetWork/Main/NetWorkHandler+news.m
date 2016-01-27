//
//  NetWorkHandler+news.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/12.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+news.h"
#import "define.h"

@implementation NetWorkHandler (news)

+ (void) requestToNews:(NSString *) category
                userId:(NSString *) userId
                offset:(NSInteger) offset
                 limit:(NSInteger) limit
            completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:userId key:@"userId"];
    [Util setValueForKeyWithDic:pramas value:category key:@"category"];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:offset] key:@"offset"];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:limit] key:@"limit"];
    
    [handle postWithMethod:@"/api/news/category/news" BaseUrl:SERVER_ADDRESS Params:pramas Completion:completion];
}

@end
