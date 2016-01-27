//
//  NetWorkHandler+saveOrUpdateCustomerLabel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/5.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+saveOrUpdateCustomerLabel.h"
#import "define.h"

@implementation NetWorkHandler (saveOrUpdateCustomerLabel)

+ (void) requestToSaveOrUpdateCustomerLabel:(NSArray *)customerId
                                    labelId:(NSArray *)labelId
                        customerLabelStatus:(NSInteger) customerLabelStatus
                                 Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:[NetWorkHandler getStringWithList:customerId] key:@"customerId"];
    [Util setValueForKeyWithDic:pramas value:[NetWorkHandler getStringWithList:labelId] key:@"labelId"];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:customerLabelStatus] key:@"customerLabelStatus"];
    
    [handle postWithMethod:@"/web/customer/saveOrUpdateCustomerLabel.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
