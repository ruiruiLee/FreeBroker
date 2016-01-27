//
//  NetWorkHandler+saveOrUpdateCustomerLabel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/5.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (saveOrUpdateLabel)

/**
 "labelId":"1",//没有labelId新增；有labelId进行修改
 "labelName":"长得帅",//标签名称
 "labelType":"2",//1、系统定义标签，2客户定义自定义标签
 "createdAt":"2015-",//创建时间
 "updatedAt":"2015-",//修改时间
 "labelStatus":"1",//数据状态，1有效，0无效，-1删除
 "userId":"1",//如果为自定义，有经纪人ID；系统标签没有值
 */
+ (void) requestToSaveOrUpdateLabel:(NSString *)userId
                                    labelId:(NSString *)labelId
                                labelStatus:(NSInteger) labelStatus
                                  labelName:(NSString *) labelName
                                  labelType:(NSString *) labelType
                                 Completion:(Completion)completion;

@end
