//
//  BankInfoModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/20.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"

@interface BankInfoModel : BaseModel

@property (nonatomic, strong) NSString *backId;//":1; //银行ID
@property (nonatomic, strong) NSString *backStatus;//":"1"; //状态；1正常，0禁用，-1删除
@property (nonatomic, strong) NSString *backLogo;//":"XXXXX"; //银行logo
@property (nonatomic, strong) NSString *backName;//":"中国工商银行股份XXXX"; //银行全称
@property (nonatomic, strong) NSString *backShortName;//":"工商银行"; //简称
@property (nonatomic, strong) NSString *createdAt;//":"XXXX"; //创建时间
@property (nonatomic, strong) NSString *updatedAt;//":"XXX"; //修改时间
@property (nonatomic, strong) NSString *dayMaxMoney;//":""; //天最大金额；保留字段
@property (nonatomic, strong) NSString *dayMaxNums;//":""; //天最大次数；保留字段
@property (nonatomic, strong) NSString *numsMaxMoney;//":""; //次数最大金额；保留字段
@property (nonatomic, strong) NSString *seqNo;//":""; 1//升序

@end
