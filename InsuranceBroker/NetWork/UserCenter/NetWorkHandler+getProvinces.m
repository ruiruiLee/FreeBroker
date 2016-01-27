//
//  NetWorkHandler+getProvinces.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/11.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+getProvinces.h"
#import "define.h"

@implementation NetWorkHandler (getProvinces)

+ (void) requestToGetProvinces:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    [handle postWithMethod:@"/web/common/getProvinces.xhtml" BaseUrl:Base_Uri Params:nil Completion:completion];
}

@end
