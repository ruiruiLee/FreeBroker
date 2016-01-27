//
//  NetWorkHandler+saveOrUpdateCustomerVisits.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/7.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (saveOrUpdateCustomerVisits)
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
                                   visitTime:(NSString *)visitTime
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
                                  Completion:(Completion) completion;

@end
