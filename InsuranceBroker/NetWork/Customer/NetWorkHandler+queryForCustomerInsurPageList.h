//
//  NetWorkHandler+queryForCustomerInsurPageList.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/11.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (queryForCustomerInsurPageList)

/*
{
insuranceType:"1",//1车险，。。。
offset:0,
limit:20,
sidx: "createdAt",
sord: "desc"
    filters :{
        "groupOp":"and",
        "rules":[
        {"field":"insuranceType","op":"eq","data":"1"},//1车险，。。。
        {"field":"customerId","op":"eq","data":"1"},//客户ID
        {"field":"userId","eq":"sq","data":"1"}, //经纪人ID
        {"field":"customerCarId","op":"eq","data":"1"}   //车辆ID
                 ]}
}
*/

+ (void) requestToQueryForCustomerInsurPageList:(NSString *) insuranceType
                                         offset:(NSInteger) offset
                                          limit:(NSInteger) limit
                                           sord:(NSString *) sord
                                        filters:(NSDictionary *) filters
                                     Completion:(Completion)completion;

@end
