//
//  NetWorkHandler+modifyUserInfo.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/15.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (modifyUserInfo)

/*
 userId:223  //sql库中用户主键
 realName:”中文名”
 phone:18200184033//电话号码
 cardNumber:”身份证号”
 cardNumberImg1:”身份证附件正面url”
 cardNumberImg2:”身份证附件反面url”
 cardVerifiy:1|2|3,//实名验证状态，1未认证 ，2认证成功 3，认证失败
 "liveProvinceId":33,//居住省id
 "liveCityId":33,//居住城市id
 "liveAreaId":33,//居住区ID
 "liveAddr":"四川省成都市青羊区京城小区" //居住地址
 */

+ (void) requestToModifyuserInfo:(NSString *) userId
                        realName:(NSString *) realName
                        userName:(NSString *) userName
                           phone:(NSString *) phone
                      cardNumber:(NSString *) cardNumber
                  cardNumberImg1:(NSString *) cardNumberImg1
                  cardNumberImg2:(NSString *) cardNumberImg2
                  liveProvinceId:(NSString *) liveProvinceId
                      liveCityId:(NSString *) liveCityId
                      liveAreaId:(NSString *) liveAreaId
                        liveAddr:(NSString *) liveAddr
                         userSex:(NSString *) userSex
                       headerImg:(NSString *) headerImg
                      Completion:(Completion) completion;

@end
