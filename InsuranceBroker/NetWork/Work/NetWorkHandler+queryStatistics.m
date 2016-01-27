//
//  NetWorkHandler+queryStatistics.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+queryStatistics.h"
#import "define.h"

@implementation NetWorkHandler (queryStatistics)

+ (void) requestToQueryStatistics:(NSString *)userId Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:userId key:@"userId"];
    
    [handle postWithMethod:@"/web/statistics/queryStatistics.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
