//
//  NetWorkHandler+strategy.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/13.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+strategy.h"
#import "define.h"

@implementation NetWorkHandler (strategy)

+ (void) requestToStrategy:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:1] key:@"appType"];
    
    [handle postWithMethod:@"/api/news/strategy" BaseUrl:SERVER_ADDRESS Params:pramas Completion:completion];
}

@end
