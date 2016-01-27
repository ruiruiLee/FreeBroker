//
//  NetWorkHandler+getCitys.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/11.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+getCitys.h"
#import "define.h"

@implementation NetWorkHandler (getCitys)

+ (void) requestToGetCitys:(NSString *) provinceId Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:provinceId key:@"provinceId"];
    
    [handle postWithMethod:@"/web/common/getCitys.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
