//
//  ProductInfoModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/2/19.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"

@interface ProductInfoModel : BaseModel

@property (nonatomic, assign) CGFloat productRatio;//": "30.00",//产品设置折扣率
@property (nonatomic, strong) NSString *productLogo;///": "http://img.car517.com/pic/agent/rb-logo.png",//产品LOGO
@property (nonatomic, assign) CGFloat productMinRatio;////": "30.00",//限制折扣率
@property (nonatomic, assign) CGFloat productMaxRatio;//": "30.00",//限制折扣率
@property (nonatomic, strong) NSString *productRatioStr;//": "30.00",//产品设置折扣率
@property (nonatomic, strong) NSString *productMinRatioStr;////": "30.00",//限制折扣率
@property (nonatomic, strong) NSString *productMaxRatioStr;//": "30.00",//限制折扣率
@property (nonatomic, strong) NSString *productName;//": "人保车险",//产品名称
@property (nonatomic, strong) NSString *productId;///": "5"//产品ID

@end
