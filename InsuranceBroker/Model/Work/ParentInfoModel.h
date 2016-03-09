//
//  ParentInfoModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/2/25.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"

@interface ParentInfoModel : BaseModel

@property (nonatomic, strong) NSString *parentRealName;
@property (nonatomic, strong) NSString *parentUserName;
@property (nonatomic, strong) NSString *parentPhone;
@property (nonatomic, strong) NSString *parentHeaderImg;
@property (nonatomic, assign) NSInteger parentUserSex;

@end
