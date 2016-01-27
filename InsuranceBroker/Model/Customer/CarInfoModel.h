//
//  CarInfoModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/6.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface CarInfoModel : BaseModel

@property (nonatomic, strong) NSString *carNo;//:"车牌号",
@property (nonatomic, strong) NSString *carProvince;//":"车辆所在省名",
@property (nonatomic, strong) NSString *carCity;//":"车辆所在城市名",
@property (nonatomic, strong) NSString *carProvinceId;//":"车辆所在省ID",
@property (nonatomic, strong) NSString *carCityId;//":"车辆所在城市ID",
@property (nonatomic, strong) NSString *driveProvinceId;//":"车辆驾驶证所在的省id",
@property (nonatomic, strong) NSString *driveCityId;//":"车辆驾驶证所在城市ID",
@property (nonatomic, strong) NSString *carTypeNo;//":"品牌号",
@property (nonatomic, strong) NSString *carShelfNo;//":"车架号",
@property (nonatomic, strong) NSString *carEngineNo;//":"发动机号",
@property (nonatomic, strong) NSString *carOwnerName;//":"车主姓名",
@property (nonatomic, strong) NSString *carOwnerCard;//":"车主身份证",
@property (nonatomic, strong) NSString *carOwnerPhone;//":"车主电话",
@property (nonatomic, strong) NSString *carOwnerTel;//":"车主住宅电话",
@property (nonatomic, strong) NSString *carOwnerAddr;//":"车主地址",
@property (nonatomic, assign) NSInteger status;//":1
@property (strong, nonatomic) NSDate *carRegTime;//注册日期
@property (strong, nonatomic) NSString *customerCarId;
@property (strong, nonatomic) NSString *customerId;

//
@property (nonatomic, strong) NSString *travelCard1;//行驶证
@property (nonatomic, strong) NSString *carInsurCompId1;//上年投保的话，需要传投保保险公司ID
@property (nonatomic, assign) NSInteger newCarNoStatus;//新车未上牌状态；0是新车未上牌，1不是
@property (nonatomic, assign) NSInteger carTradeStatus; //车辆过户状态；0未知，1未过户，2过户
@property (nonatomic, strong) NSDate *carTradeTime;//如果过户，必须过户时间
@property (nonatomic, assign) NSInteger carInsurStatus1;////上年投保状态；0未投保，1投保，不知道就不传值


@end
