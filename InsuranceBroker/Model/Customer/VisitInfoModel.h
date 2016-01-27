//
//  VisitInfoModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/7.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface VisitInfoModel : BaseModel

@property (nonatomic, strong) NSString *visitId;//":1,
@property (nonatomic, strong) NSString *visitTypeId;//":2 //访问方式ID
@property (nonatomic, strong) NSString *visitType;//":"电访|面谈", //访问方式描述
@property (nonatomic, strong) NSString *visitProgress ;//":"有购买意向，2015-12-19 保险到期",//访问结果描述
@property (nonatomic, strong) NSDate *visitTime;//":"2015-12-30 20:57:51", //访问时间
@property (nonatomic, strong) NSString *userName;//":"张彬"//访问经纪人姓名，
@property (nonatomic, assign) float visitLon;//":经度//，
@property (nonatomic, assign) float visitLat;//":纬度//，
@property (nonatomic, strong) NSString *visitAddr;//":地址//，
@property (nonatomic, strong) NSString *visitProgressId;//":2//
@property (nonatomic, strong) NSString *visitMemo;//描述"//

+ (NSArray *) modelArrayFromArray:(NSArray *)array;

@end
