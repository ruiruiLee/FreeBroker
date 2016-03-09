//
//  BillInfoModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"

@interface BillInfoModel : BaseModel

@property (nonatomic, strong) NSString *billId;//":1; //明细ID
@property (nonatomic, assign) NSInteger billType;//":1; //类型 1自己的保单直接收益，2下线提成，3团队长管理津贴，4红包，5收益提现
@property (nonatomic, strong) NSString *billTypeName;//":”保单体层”//类型名称
@property (nonatomic, strong) NSDate *createdAt;//":"2016-"; //时间
@property (nonatomic, strong) NSString *userId;//":"1"; //经纪人ID
@property (nonatomic, strong) NSString *memo;//":描述：来自订单2016XXXXX; //描述
@property (nonatomic, strong) NSString *advanceId;//":1; //提现ID
@property (nonatomic, strong) NSString *insuranceOrderEarnId;//":1; //保单收益ID
@property (nonatomic, strong) NSString *redPackUserId;//":1; //红包关联ID
@property (nonatomic, assign) NSInteger billStatus;//":"1"; //1正常
@property (nonatomic, assign) NSInteger billDoType;//":"1"; //操作类型；1收入，2提现
@property (nonatomic, strong) NSString *billMoney;

//详情
//用于提现申请 - billType = 2
@property (nonatomic, strong) NSString *auditStatus;//": "等待审核",//提现申请

//用于订单收益 - billType = 1
@property (nonatomic, assign) CGFloat planUkbRatio;//": "10.00",
@property (nonatomic, assign) CGFloat productMaxRatio;//": "24.00",
@property (nonatomic, strong) NSString *insuranceOrderNo;//": "201602011445245910"
@property (nonatomic, strong) NSString *insuranceOrderUuid;

@property (nonatomic, assign) BOOL isLoadDetail;

- (void) setContentFromDictionary:(NSDictionary *)dictionary;

@end
