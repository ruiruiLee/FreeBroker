//
//  NetWorkHandler+queryForLabelPageList.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/5.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (queryForLabelPageList)

/**
 getCustomerNums:"1",//是否获取标签下用户数量，1需要，0不需要
 offset:0,
 limit:20,
 sidx: "updatedAt ",
 sord: "desc"
 filters :{
 "groupOp":"and",
 "rules":[
 {"field":"labelId","op":"eq","data":"1"},//标签ID，根据ID可以获取详情，需要get(0)
 {"field":"labelName","op":"cn","data":"长得帅"},//标签名称
 {"field":"labelType","eq":"sq","data":"1"}, //类型，不传值，返回1和2状态
 {"field":"labelStatus","op":"eq","data":"1"}   //标签状态，不传值，返回0和1状态
 {"field":"userId","op":"eq","data":"1"}  //经纪人id,获取经纪人自己的标签
 ]}
 */
/**
 offset = 0
 limit max
 */
+ (void) requestToQueryForLabelPageList:(BOOL) getCustomerNums Completion:(Completion)completion;
+ (void) requestToLabelDetailPageList:(BOOL) getCustomerNums labelId:(NSString *) labelId Completion:(Completion)completion;

@end
