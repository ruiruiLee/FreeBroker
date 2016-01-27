//
//  NetWorkHandler+saveOrUpdateCustomer.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/5.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (saveOrUpdateCustomer)

/*
 4.1
 "userId": 200, //经纪人(创建人)id,
 "isAgentCreate": 0|1, //是否经纪人自建，如果是经纪人自建，则需要建立分发关联数据
 "customerId":33,//新增时该字段无值，修改时为被修改客户的id
 "customerName":"张彬",
 "customerPhone":"13500009454",
 "customerTel":"028-39993333",//客户座机
 "headImg":"xxx.jpg",
 "cardNumber":"51101119801226000", //身份证号
 "cardNumberImg1":"xxx.jpg", //身份证正面图片路径
 "cardNumberImg2":3, //身份证反面图片路径
 "cardProvinceId":33,//身份证所在省份
 "cardCityId":33,//身份证所在城市
 "cardAreaId":33,//身份证区ID
 "cardVerifiy":0|1,//0未验证，1已验证
 "cardAddr":"四川省成都市青羊区京城小区",//身份证所在户籍地址
 "verifiyTime":"2015-12-25 15:33:44",
 "liveProvinceId":33,//居住省id
 "liveCityId":33,//居住城市id
 "liveAreaId":33,//居住区ID
 "liveAddr":"四川省成都市青羊区京城小区" //居住地址
 "customerStatus":-1|1 //删除用户时仅传coustomerId和status=-1
 "drivingCard1":"驾驶证正本",
 "drivingCard2":"可能不需要副本"
 customerLabel
 */
+ (void) requestToSaveOrUpdateCustomerWithUID:(NSString *) userId
                                isAgentCreate:(BOOL) isAgentCreate
                                   customerId:(NSString*)customerId
                                 customerName:(NSString *)customerName
                                customerPhone:(NSString* )customerPhone
                                  customerTel:(NSString *)customerTel
                                      headImg:(NSString *)headImg
                                   cardNumber:(NSString *)cardNumber
                               cardNumberImg1:(NSString *)cardNumberImg1
                               cardNumberImg2:(NSString *)cardNumberImg2
                               cardProvinceId:(NSString *)cardProvinceId
                                   cardCityId:(NSString *) cardCityId
                                   cardAreaId:(NSString *) cardAreaId
                                  cardVerifiy:(BOOL) cardVerifiy
                                     cardAddr:(NSString *)cardAddr
                                  verifiyTime:(NSString *)verifiyTime
                               liveProvinceId:(NSString *) liveProvinceId
                                   liveCityId:(NSString *)liveCityId
                                   liveAreaId:(NSString *)liveAreaId
                                     liveAddr:(NSString *)liveAddr
                               customerStatus:(BOOL) customerStatus
                                 drivingCard1:(NSString *)drivingCard1
                                 drivingCard2:(NSString *)drivingCard2
                                customerLabel:(NSArray *) customerLabel
                              customerLabelId:(NSArray *) customerLabelId
                                   Completion:(Completion) completion;

@end
