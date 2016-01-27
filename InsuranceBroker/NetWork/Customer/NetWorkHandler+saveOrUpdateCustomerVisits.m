//
//  NetWorkHandler+saveOrUpdateCustomerVisits.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/7.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+saveOrUpdateCustomerVisits.h"
#import "define.h"

@implementation NetWorkHandler (saveOrUpdateCustomerVisits)

/*
 customerId:1,
 userId:1,
 visitTime:时间,
 visitAddr:地址,//可以空
 visitType:方式,
 visitTypeId:方式ID,
 visitProgress:进度
 visitProgressId:进度ID
 visitLon:经度//可以空
 visitLat:纬度//可以空
 visitStatus:1//1正常，-1删除
 visitMemo:描述
 */

+ (void) requestToSaveOrUpdateCustomerVisits:(NSString *) customerId
                                      userId:(NSString *) userId
                                   visitTime:(NSString *) visitTime
                                   visitAddr:(NSString *) visitAddr
                                   visitType:(NSString *) visitType
                                 visitTypeId:(NSString *) visitTypeId
                               visitProgress:(NSString *) visitProgress
                             visitProgressId:(NSString *) visitProgressId
                                    visitLon:(NSString *) visitLon
                                    visitLat:(NSString *) visitLat
                                 visitStatus:(NSInteger ) visitStatus
                                   visitMemo:(NSString *) visitMemo
                                     visitId:(NSString *) visitId
                                  Completion:(Completion) completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    
    [Util setValueForKeyWithDic:pramas value:customerId key:@"customerId"];
    [Util setValueForKeyWithDic:pramas value:userId key:@"userId"];
    [Util setValueForKeyWithDic:pramas value:visitTime key:@"visitTime"];
    [Util setValueForKeyWithDic:pramas value:visitAddr key:@"visitAddr"];
    [Util setValueForKeyWithDic:pramas value:visitType key:@"visitType"];
    [Util setValueForKeyWithDic:pramas value:visitTypeId key:@"visitTypeId"];
    [Util setValueForKeyWithDic:pramas value:visitProgress key:@"visitProgress"];
    [Util setValueForKeyWithDic:pramas value:visitProgressId key:@"visitProgressId"];
    [Util setValueForKeyWithDic:pramas value:visitLon key:@"visitLon"];
    [Util setValueForKeyWithDic:pramas value:visitLat key:@"visitLat"];
    [Util setValueForKeyWithDic:pramas value:visitMemo key:@"visitMemo"];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithInt:visitStatus] key:@"visitStatus"];
    [Util setValueForKeyWithDic:pramas value:visitId key:@"visitId"];
    
    [handle postWithMethod:@"/web/customer/saveOrUpdateCustomerVisits.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
