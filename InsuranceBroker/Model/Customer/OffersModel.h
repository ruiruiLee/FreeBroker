//
//  OffersModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/18.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"

@interface OffersModel : BaseModel

@property (nonatomic, strong) NSString *planOfferFailedMsg;
@property (nonatomic, strong) NSString *planOfferId;
@property (nonatomic, strong) NSString *planOfferStatusMsg;
@property (nonatomic, strong) NSString *productLogo;
@property (nonatomic, strong) NSString *productName;
@property (nonatomic, strong) NSString *respAddr;
@property (nonatomic, assign) NSInteger planOfferPayType;
@property (nonatomic, assign) NSInteger planOfferStatus;

@property (nonatomic, assign) CGFloat planInsuranceCompanyPrice;//保单价
@property (nonatomic, assign) CGFloat planUkbPrice;//基准折扣价
@property (nonatomic, assign) CGFloat planUkbRatio;//基准折扣
@property (nonatomic, assign) CGFloat planUkbSavePrice;//基准折扣价下净赚
@property (nonatomic, assign) CGFloat productMaxRatio;//最大折扣
@property (nonatomic, assign) CGFloat productMinRatio;//最小折扣
@property (nonatomic, assign) CGFloat businessPrice;//商业险
@property (nonatomic, assign) CGFloat fjxPrice;//附加险
@property (nonatomic, assign) CGFloat jbxPrice;//基本险
@property (nonatomic, assign) CGFloat jqxCcsPrice;//交强险＋车船税
@property (nonatomic, assign) CGFloat planAbonusPrice;//
@property (nonatomic, assign) CGFloat allotBonusRatio;
@property (nonatomic, assign) CGFloat levelRatio;
@property (nonatomic, assign) CGFloat planUserAllot;

@property (nonatomic, assign) BOOL isRatioSubmit;

@end
