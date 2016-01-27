//
//  NetWorkHandler+applyForEarn.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+applyForEarn.h"
#import "define.h"

@implementation NetWorkHandler (applyForEarn)

+ (void) requestToApplyForEarn:(NSString *) backCardId useId:(NSString *) useId money:(NSString *) money Completion:(Completion) completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:backCardId key:@"backCardId"];
    [Util setValueForKeyWithDic:pramas value:useId key:@"userId"];
    [Util setValueForKeyWithDic:pramas value:money key:@"money"];
    
    [handle postWithMethod:@"/web/userEarn/applyForAdvanceMoney.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
