//
//  BrokerInfoModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/13.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"

@interface BrokerInfoModel : BaseModel

@property (nonatomic, strong) NSString *realName;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *cardNumber;
@property (nonatomic, assign) NSInteger userType;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString *headerImg;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSString *monthOrderEarn;
@property (nonatomic, assign) NSInteger userSex;

@end
