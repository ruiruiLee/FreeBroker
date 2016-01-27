//
//  NetWorkHandler+saveOrUpdateLabelCustomer.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/8.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (saveOrUpdateLabelCustomer)
/*
 "addCustomerId":"数组",//新增用户ID
 "deleteCustomerId":"数组",//删除用户ID
 "labelId":"1",//标签ID
 "labelName":"我要修改",//有name需要修改，为空不进行修改
 "customerLabelStatus":"1",//状态；1正常（进行增删操作），-1删除（直接删除标签，并解绑相关用户）
 */

+ (void) requestToSaveOrUpdateLabelCustomer:(NSArray *) addCustomerId
                           deleteCustomerId:(NSArray *) deleteCustomerId
                                    labelId:(NSString *) labelId
                                  labelName:(NSString *) labelName
                                     userId:(NSString *) userId
                                 Completion:(Completion)completion;

@end
