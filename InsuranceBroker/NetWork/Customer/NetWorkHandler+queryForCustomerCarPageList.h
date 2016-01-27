//
//  NetWorkHandler+queryForCustomerCarPageList.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/7.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (queryForCustomerCarPageList)

/**
 /web/customer/queryForCustomerCarPageList.xhtml
 {
 offset:0,
 limit:20,
 sidx: "createdAt",
 sord: "desc"
 filters :{
 "groupOp":"and",
 "rules":[
 {"field":"carNo","op":"cn","data":"searchKey"},//中文名like
 {"field":"carShelfNo","op":"cn","data":"searchKey"}, //车架号like
 {"field":"carEngineNo","op":"cn","data":"searchKey"}   //发动机号like
 注：以上三个字段是or关系的like 查询
 {"field":"customerId","op":"eq","data":22}  //客户id
 ]}
 }
 **/

+ (void) requestToQueryForCustomerCarPageList:(NSInteger) offset
                                        limit:(NSInteger) limit
                                         sord:(NSString *)sord
                                     filters :(NSDictionary *)filters
                                   Completion:(Completion)completion;


@end
