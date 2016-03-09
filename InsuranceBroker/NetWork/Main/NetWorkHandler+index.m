//
//  NetWorkHandler+index.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/12.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+index.h"
#import "define.h"

@implementation NetWorkHandler (index)

+ (void) requestToIndex:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:1] key:@"appType"];
    
    [handle postWithMethod:@"/api/news/index" BaseUrl:SERVER_ADDRESS Params:pramas Completion:completion];
}

@end
