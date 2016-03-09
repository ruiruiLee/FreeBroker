//
//  NetWorkHandler+queryUserBillDetail.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/3/2.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+queryUserBillDetail.h"
#import "define.h"

@implementation NetWorkHandler (queryUserBillDetail)

+ (void) requestToQueryUserBillDetail:(NSString *) billId Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:billId key:@"billId"];
    
    [handle postWithMethod:@"/web/userEarn/queryUserBillDetail.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
