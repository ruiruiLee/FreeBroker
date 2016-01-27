//
//  UserInfoModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/28.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "BaseModel.h"

@interface UserInfoModel : BaseModel

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, assign) BOOL isRegister;//如果是第一次登录，则该字段为true
@property (nonatomic, strong) NSString *realName;//通过微信获取,如果没有则返回””
@property (nonatomic, strong) NSString *headerImg;//通过微信获取,如果没有则返回””
@property (nonatomic, strong) NSString *clientKey;//
@property (nonatomic, assign) BOOL mobileFlag;//0|1，手机端登陆，1是，0否
@property (nonatomic, assign) BOOL webFlag;//网页端登陆，1是，0否
@property (nonatomic, strong) NSString *phone;////手机号
@property (nonatomic, strong) NSString *nickname;//用户昵称,
@property (nonatomic, assign) NSInteger sex;//性别 1表示男,2 表示女
@property (nonatomic, strong) NSString *liveProvinceId;////居住省id
@property (nonatomic, strong) NSString *liveCityId;//,//居住城市id
@property (nonatomic, strong) NSString *liveProvince;//
@property (nonatomic, strong) NSString *liveCity;
@property (nonatomic, assign) BOOL leader;//0个人 1 团长
@property (nonatomic, assign) NSInteger cardVerifiy;//实名验证状态，1未认证 ，2认证成功 3，认证失败
@property (nonatomic, assign) NSInteger userType;////经纪人类型，1自由经纪人、2坐席经纪人、3平台管理人

@property (nonatomic, assign) BOOL isLogin;//0:未登录 1:登录

//addinfo

@property (nonatomic, strong) NSString *cardNumber;//":"51101119801226000", //身份证号
@property (nonatomic, strong) NSString *cardNumberImg1;//":"xxx.jpg",  //身份证正面图片路径
@property (nonatomic, strong) NSString *cardNumberImg2;//":"xxx.jpg",//身份证反面图片路径
@property (nonatomic, strong) NSDate *verifiyTime;//":"2015-12-25 15:33:44",  //认证通过时间
@property (nonatomic, assign) NSInteger status;//":2,
@property (nonatomic, strong) NSString *cardProvinceId;// ":4,  //省id
@property (nonatomic, strong) NSString *cardCityId;// ":3,      //城市id
@property (nonatomic, strong) NSString *cardAreaId;//":33,//身份证区ID
@property (nonatomic, assign) NSInteger isSupport;//":0, //是否需要分配客户资源，1需要，0不需要
@property (nonatomic, assign) NSInteger maxCustomer;//":100,  //最大可接收的客户资源
@property (nonatomic, strong) NSDate *createdAt;//":"2015-12-25 15:33:44" //创建时间
@property (nonatomic, assign) NSInteger layerNum;//":10, //所在层级数
@property (nonatomic, assign) NSInteger lowerNum;//":20,  //直接下线数
@property (nonatomic, assign) CGFloat brokerEarnings;//":5000, //可提取保险销售收益（元）
@property (nonatomic, assign) CGFloat redbagEarnings;//":200, // 可提前红包收益(元)
@property (nonatomic, assign) NSInteger orderNums;//":100, //总完成订单数
@property (nonatomic, strong) NSString *liveAreaId;//":33,//居住区ID
@property (nonatomic, strong) NSString *liveAddr;//":"四川省成都市青羊区京城小区" //居住地址

@property (nonatomic, strong) NSString *qrcodeAddr;//":""//二维码地址
@property (nonatomic, assign) NSInteger monthOrderSuccessNums;//":0//上月成功订单
@property (nonatomic, assign) NSInteger orderSuccessNums;//":0//总订单数总订单数
@property (nonatomic, assign) CGFloat monthOrderEarn;//":0//上月成功订单收益
@property (nonatomic, assign) CGFloat orderEarn;//":0//总订单收益
@property (nonatomic, strong) NSString *redBagId;//":0//红包最新ID
@property (nonatomic, assign) NSInteger userInviteNums;//":0//自己邀请人数
@property (nonatomic, assign) NSInteger userTeamInviteNums;//":0//团队总人数

@property (nonatomic, strong) NSString *cardVerifiyMsg;//认证失败信息

+ (UserInfoModel *) shareUserInfoModel;
- (void) setContentWithDictionary:(NSDictionary *) dic;//isLogin单独修改
- (void) queryUserInfo;//获取经纪人信息详情

@end
