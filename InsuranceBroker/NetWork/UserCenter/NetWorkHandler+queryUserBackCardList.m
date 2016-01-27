//
//  NetWorkHandler+queryUserBackCardList.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/20.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+queryUserBackCardList.h"
#import "define.h"

@implementation NetWorkHandler (queryUserBackCardList)

+ (void) requesToQueryUserBackCardList:(NSString *) userId backCardStatus:(NSString *) backCardStatus Completion:(Completion) completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:userId key:@"userId"];
    [Util setValueForKeyWithDic:pramas value:backCardStatus key:@"backCardStatus"];

    
    [handle postWithMethod:@"/web/user/queryUserBackCardList.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
