//
//  NetWorkHandler+queryUserNowAdvanceMoney.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+queryUserNowAdvanceMoney.h"
#import "define.h"

@implementation NetWorkHandler (queryUserNowAdvanceMoney)

+ (void) requestToQueryUserNowAdvanceMoney:(NSString *) userId Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:userId key:@"userId"];
    
    
    [handle postWithMethod:@"/web/userEarn/queryUserNowAdvanceMoney.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
