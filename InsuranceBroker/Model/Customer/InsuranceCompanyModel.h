//
//  InsuranceCompanyModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/14.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"

@interface InsuranceCompanyModel : BaseModel

@property (nonatomic, strong) NSString *insuranceCompanyId;//":"1"; //保险ID
@property (nonatomic, strong) NSString *insuranceCompanyName;//":"中国人民财产保险股份有限公司"; //全称
@property (nonatomic, strong) NSString *insuranceCompanyShortName;//":"人保车险"; //简称
@property (nonatomic, strong) NSString *insuranceCompanyLogo;//":"XXXXXXX"; //保险公司logo
@property (nonatomic, strong) NSString *insuranceType;//":"1"; //车险

@end
