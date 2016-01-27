//
//  NetWorkHandler+saveOrUpdateLabelCustomer.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/8.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+saveOrUpdateLabelCustomer.h"
#import "define.h"

@implementation NetWorkHandler (saveOrUpdateLabelCustomer)

+ (void) requestToSaveOrUpdateLabelCustomer:(NSArray *) addCustomerId
                           deleteCustomerId:(NSArray *) deleteCustomerId
                                    labelId:(NSString *) labelId
                                  labelName:(NSString *) labelName
                                     userId:(NSString *) userId
                                 Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    
    [Util setValueForKeyWithDic:pramas value:labelId key:@"labelId"];
    [Util setValueForKeyWithDic:pramas value:labelName key:@"labelName"];
    [Util setValueForKeyWithDic:pramas value:[NetWorkHandler objectToJson:addCustomerId] key:@"addCustomerId"];
    [Util setValueForKeyWithDic:pramas value:[NetWorkHandler objectToJson:deleteCustomerId] key:@"deleteCustomerId"];
    [Util setValueForKeyWithDic:pramas value:userId key:@"userId"];
    
    [handle postWithMethod:@"/web/customer/saveOrUpdateLabelCustomer.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];

}

@end
