//
//  NetWorkHandler+saveOrUpdateUser.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/9.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (saveOrUpdateUser)

/*
 userId:223  //sql库中用户主键
 realName:”中文名”
 userType:1|2 //经纪人类型，1自由经纪人、2坐席经纪人、3平台管理人员
 isSupport:0|1, //是否为该经纪人自动分配客户，1是，0否
 maxCustomer：100,//最大分配的客户数量
 cardProvinceId:33,//省id
 cardCityId:22,//城市id
 "cardAreaId":33,//身份证区ID
 phone:18200184033//电话号码
 levers://0个人 1 团长
 cardNumber:”身份证号”
 cardNumberImg1:”身份证附件正面url”
 cardNumberImg2:”身份证附件反面url”
 status: 1|0|-1,//客户状态，1正常，0禁用，-1删除，
 cardVerifiy:1|2|3,//实名验证状态，1未认证 ，2认证成功 3，认证失败
 "liveProvinceId":33,//居住省id
 "liveCityId":33,//居住城市id
 "liveAreaId":33,//居住区ID
 "liveAddr":"四川省成都市青羊区京城小区" //居住地址
 */

+ (void) requestToSaveOrUpdateUser:(NSString *) userId
                          realName:(NSString *) realName
                          userType:(NSString *) userType
                         isSupport:(NSString *) isSupport
                       maxCustomer:(NSString *) maxCustomer
                    cardProvinceId:(NSString *) cardProvinceId
                        cardCityId:(NSString *) cardCityId
                        cardAreaId:(NSString *) cardAreaId
                             phone:(NSString *) phone
                            levers:(NSString *) levers
                        cardNumber:(NSString *) cardNumber
                    cardNumberImg1:(NSString *) cardNumberImg1
                    cardNumberImg2:(NSString *) cardNumberImg2
                            status:(NSString *) status
                       cardVerifiy:(NSString *) cardVerifiy
                    liveProvinceId:(NSString *) liveProvinceId
                        liveCityId:(NSString *) liveCityId
                        liveAreaId:(NSString *) liveAreaId
                          liveAddr:(NSString *) liveAddr
                        Completion:(Completion)completion;

@end
