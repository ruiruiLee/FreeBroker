//
//  ProviendeModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/11.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"
#import "NetWorkHandler+getProvinces.h"
#import "CityModel.h"


@interface ProviendeModel : BaseModel

@property (nonatomic, strong) NSString *provinceId;//":1; //省ID
@property (nonatomic, strong) NSString *provinceName;//":"四川"; //省名称
@property (nonatomic, strong) NSString *seqNo;//":"1"; //排序，降序
@property (nonatomic, strong) NSString *provinceShortName;//":"川"; //简称

@property (nonatomic, strong) NSArray *citymodel;

+ (NSMutableArray *) shareProviendeModelArray;//:(Completion) completion;

@end
