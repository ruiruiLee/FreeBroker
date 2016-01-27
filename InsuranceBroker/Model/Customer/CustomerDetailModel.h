//
//  CustomerDetailModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/5.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "CarInfoModel.h"
#import "InsurInfoModel.h"

@interface CustomerDetailModel : BaseModel

@property (nonatomic, strong) NSString *userId; //经纪人(创建人)id
@property (nonatomic, strong) NSString *customerId;//新增时该字段无值，修改时为被修改客户的id
@property (nonatomic, strong) NSString *customerName;//"张彬",
@property (nonatomic, strong) NSString *customerPhone;//"13500009454",
@property (nonatomic, strong) NSString *customerTel;//;//客户座机
@property (nonatomic, strong) NSString *headImg;//"xxx.jpg",
@property (nonatomic, strong) NSString *cardNumber;//; //身份证号
@property (nonatomic, strong) NSString *cardNumberImg1;//"xxx.jpg", //身份证正面图片路径
@property (nonatomic, strong) NSString *cardNumberImg2;//3, //身份证反面图片路径
@property (nonatomic, strong) NSString *cardProvinceId;//33,//身份证所在省份
@property (nonatomic, strong) NSString *cardCityId;//身份证所在城市
@property (nonatomic, strong) NSString *cardAreaId;//身份证区ID
@property (nonatomic, assign) NSInteger cardVerifiy;//0未验证，1已验证
@property (nonatomic, strong) NSString *cardAddr;//身份证所在户籍地址
@property (nonatomic, strong) NSDate *verifiyTime;//"2015-12-25 15:33:44",
@property (nonatomic, strong) NSString *liveProvinceId;//居住省id
@property (nonatomic, strong) NSString *liveCityId;//居住城市id
@property (nonatomic, strong) NSString *liveAreaId;//居住区ID
@property (nonatomic, strong) NSString *liveAddr; //居住地址
@property (nonatomic, assign) NSInteger customerStatus;//删除用户时仅传coustomerId和status=-1
@property (nonatomic, strong) NSString *drivingCard1;//"驾驶证正本",
@property (nonatomic, strong) NSString *drivingCard2;//"可能不需要副本",
@property (nonatomic, strong) NSArray *customerLabel;//"用户标签描述:宝马、平安"
@property (nonatomic, strong) NSArray *customerLabelId; //用户标签id
@property (nonatomic, assign) NSInteger isAgentCreate;//1经纪人自己创建，0系统分配
@property (nonatomic, strong) NSDate *createdAt;//"创建时间",
@property (nonatomic, assign) NSInteger customerSex;//"性别",
@property (nonatomic, strong) NSDate *customerBirthday;//"生日",


@property (nonatomic, strong) CarInfoModel *carInfo;//车信息
@property (nonatomic, assign) BOOL isLoadVisit;//是否加载过客户跟踪信息
@property (nonatomic, assign) NSInteger visitTotal;
@property (nonatomic, strong) NSMutableArray *visitAttay;//客户跟踪列表
@property (nonatomic, assign) BOOL isLoadInsur;//是否加载过客户跟踪信息
@property (nonatomic, assign) NSInteger insurTotal;
@property (nonatomic, strong) NSMutableArray *insurArray;//客户保单信息列表

- (NSString *) getCustomerLabelString;

@end
