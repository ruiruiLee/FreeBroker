//
//  BankCardModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/20.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"

@interface BankCardModel : BaseModel

@property (nonatomic, strong) NSString *backCardId;//:1//绑定ID
@property (nonatomic, strong) NSString *backId;//:1；//银行ID
@property (nonatomic, strong) NSString *userId;//:1；//经纪人ID
@property (nonatomic, assign) NSInteger defaultStatus;//:1；//默认状态；1默认，0不是默认
@property (nonatomic, strong) NSString *backCardTypeId;//:；//银行卡类型；保留字段
@property (nonatomic, strong) NSString *backCardNo;//:XXXXXX;//；//卡号
@property (nonatomic, strong) NSString *backCardTailNo;//:XXXX;//；//尾号
@property (nonatomic, assign) NSInteger moneyNums;//:0；//提现次数
@property (nonatomic, assign) NSInteger moneyTotal;//:0；//提现总额
@property (nonatomic, assign) NSInteger moneyStatus;//:1；//是否允许提现，1允许，0不允许
@property (nonatomic, assign) NSInteger backCardStatus;//:1；//状态，1正常
@property (nonatomic, strong) NSString *cardholder;//:长得帅;//；//持卡人姓名
@property (nonatomic, strong) NSString *openProvinceId;//:1；//开户省
@property (nonatomic, strong) NSString *openCityId;//:1；//开户市
@property (nonatomic, strong) NSString *openAreaId;//:1；//开户区
@property (nonatomic, strong) NSString *openAddr;//:1；//开户银行所在街道地址
@property (nonatomic, strong) NSString *openBackName;//:1；//开户银行全称
@property (nonatomic, strong) NSString *backLogo;

@end
