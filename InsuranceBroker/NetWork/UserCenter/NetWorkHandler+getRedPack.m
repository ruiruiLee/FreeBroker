//
//  NetWorkHandler+getRedPack.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/21.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+getRedPack.h"
#import "define.h"

@implementation NetWorkHandler (getRedPack)

+ (void) requestToGetRedPack:(NSString *)redPackId userId:(NSString *) userId Completion:(Completion) completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:userId key:@"userId"];
    [Util setValueForKeyWithDic:pramas value:redPackId key:@"redPackId"];
    
    
    [handle postWithMethod:@"/web/redPack/getRedPack.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
