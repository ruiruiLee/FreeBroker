//
//  NetWorkHandler+saveOrUpdateCustomerLabel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/5.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (saveOrUpdateCustomerLabel)

/**
 "customerId":"1",//用户ID
 "labelId":"1",//标签ID
 "customerLabelStatus":"1",//状态；1正常，-1删除(删除传status和id就可以了)
 "customerLabelId":"1",//绑定关系ID
 */

+ (void) requestToSaveOrUpdateCustomerLabel:(NSArray *)customerId
                                    labelId:(NSArray *)labelId
                        customerLabelStatus:(NSInteger) customerLabelStatus
                                 Completion:(Completion)completion;

@end
