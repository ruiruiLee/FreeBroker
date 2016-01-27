//
//  NetWorkHandler+queryForCustomerVisitsPageList.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/7.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (queryForCustomerVisitsPageList)

/**
 offset:0,
 limit:20,
 sidx: "createdAt",
 sord: "desc"
 filters :{
 "groupOp":"and",
 "rules":[
 {"field":"customerId","op":"eq","data":"searchKey"},//客户id
 {"field":"userId","op":"eq","data":22}  //经纪人id, 经纪人只能查看自己创建的访问记录，如果该字段不存在，则表示为是平台管理员在访问客户的所有访问记录
 {"field":"visitId","op":"eq","data":"1"},//标签ID，根据ID可以获取详情，需要get(0)
 ]}
 **/

+ (void) requestToQueryForCustomerVisitsPageList:(NSInteger) offset
                                           limit:(NSInteger) limit
                                            sord:(NSString *)sord
                                        filters :(NSDictionary *)filters
                                      Completion:(Completion)completion;

@end
