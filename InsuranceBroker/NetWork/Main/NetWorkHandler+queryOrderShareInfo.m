//
//  NetWorkHandler+queryOrderShareInfo.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+queryOrderShareInfo.h"
#import "define.h"

@implementation NetWorkHandler (queryOrderShareInfo)

+ (void) requestToQueryOrderShareInfo:(NSString *) uuid completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:uuid key:@"id"];
    
    [handle postWithMethod:@"/web/insurance/queryOrderShareInfo.xhtml" BaseUrl:SERVER_ADDRESS Params:pramas Completion:completion];
}

@end
