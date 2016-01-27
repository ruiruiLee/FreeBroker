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
    
    [handle postWithMethod:@"/api/news/index" BaseUrl:SERVER_ADDRESS Params:nil Completion:completion];
}

@end
