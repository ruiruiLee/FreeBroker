//
//  DictModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/7.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"

@interface DictModel : BaseModel

@property (nonatomic, strong) NSString *dictId;//":1; //字典ID
@property (nonatomic, strong) NSString *dictValue;//":1; //字典值，各表对应存入的是這个值哦
@property (nonatomic, strong) NSString *dictType;//":"visitType"; //字典类型
@property (nonatomic, strong) NSString *dictName;//":"电话"; //字典名称
@property (nonatomic, assign) NSInteger seqNo;//":1; //排序；升序
@property (nonatomic, assign) NSInteger status;//":1; //状态；1正常，0禁用
@property (nonatomic, strong) NSString *dictEn;//":"phone"; //英文描述

@end
