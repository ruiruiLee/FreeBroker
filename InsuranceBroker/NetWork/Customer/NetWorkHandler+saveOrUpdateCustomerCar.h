//
//  NetWorkHandler+saveOrUpdateCustomerCar.h
//  InsuranceBroker
//
//  后台或手机端管理客户车险信息接口
//
//  Created by LiuZach on 16/1/6.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

/*
 "customerCarId":34,
 "customerId":33,
 "carNo":"车牌号",
 "carProvinceId":"车辆所在省ID",
 "carCityId":"车辆所在城市ID",
 "driveProvinceId":"车辆驾驶证所在的省id",
 "driveCityId":"车辆驾驶证所在城市ID",
 "carTypeNo":"车牌号",
 "carShelfNo":"车架号",
 "carEngineNo":"发动机号",
 "carOwnerName":"车主姓名",
 "carOwnerCard":"车主身份证",
 "carOwnerPhone":"车主电话",
 "carOwnerTel":"车主住宅电话",
 "carOwnerAddr":"车主地址",
 "status":1
 “travelCard1”:”行驶证”
 “carRegTime”:”车辆注册日期”
 
 newCarNoStatus”:”1”//新车未上牌状态；0是新车未上牌，1不是
 “carTradeStatus”:”1”//车辆过户状态；0未知，1未过户，2过户
 “carTradeTime”:”1”//如果过户，必须过户时间
 “carInsurStatus1”:”1”//上年投保状态；0未投保，1投保，不知道就不传值
 “carInsurCompId1”:”1”//上年投保的话，需要传投保保险公司ID
 */

@interface NetWorkHandler (saveOrUpdateCustomerCar)

+ (void) requestToSaveOrUpdateCustomerCar:(NSString *) customerCarId
                               customerId:(NSString *) customerId
                                    carNo:(NSString *)carNo
                            carProvinceId:(NSString *) carProvinceId
                                carCityId:(NSString *) carCityId
                          driveProvinceId:(NSString *) driveProvinceId
                              driveCityId:(NSString *) driveCityId
                                carTypeNo:(NSString *) carTypeNo
                               carShelfNo:(NSString *) carShelfNo
                              carEngineNo:(NSString *) carEngineNo
                             carOwnerName:(NSString *) carOwnerName
                             carOwnerCard:(NSString *) carOwnerCard
                            carOwnerPhone:(NSString *) carOwnerPhone
                              carOwnerTel:(NSString *) carOwnerTel
                             carOwnerAddr:(NSString *) carOwnerAddr
                              travelCard1:(NSString *) travelCard1
                               carRegTime:(NSString *) carRegTime
                           newCarNoStatus:(NSString *) newCarNoStatus
                           carTradeStatus:(NSString *) carTradeStatus
                             carTradeTime:(NSString *) carTradeTime
                          carInsurStatus1:(NSString *) carInsurStatus1
                          carInsurCompId1:(NSString *) carInsurCompId1
                               Completion:(Completion)completion;

@end
