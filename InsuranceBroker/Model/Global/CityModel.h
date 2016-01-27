//
//  CityModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/11.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"

@interface CityModel : BaseModel

@property (nonatomic, strong) NSString *cityHot;//": "0",
@property (nonatomic, strong) NSString *cityId;//": "1",
@property (nonatomic, strong) NSString *cityLetter;//": "A",
@property (nonatomic, strong) NSString *cityName;//": "成都市",
@property (nonatomic, strong) NSString *cityPy;//": "ChengDu",
@property (nonatomic, strong) NSString *cityShortName;//": "成都",
@property (nonatomic, strong) NSString *cityShortPy;//": "cd",
@property (nonatomic, strong) NSString *cityStatus;//": "1",
@property (nonatomic, strong) NSString *latitude;//": "30.6581",//纬度
@property (nonatomic, strong) NSString *longitude;//": "104.066",//经度
@property (nonatomic, strong) NSString *provinceId;//": "1",
@property (nonatomic, strong) NSString *seqNo;//": "1",
@property (nonatomic, strong) NSString *tel;//": "028"

@end
