//
//  NetWorkHandler+getBacks.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/20.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+getBacks.h"
#import "define.h"

@implementation NetWorkHandler (getBacks)

+ (void) requestTogetBanks:(Completion) complation
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    [handle postWithMethod:@"/web/common/getBacks.xhtml" BaseUrl:Base_Uri Params:nil Completion:complation];
}

@end
