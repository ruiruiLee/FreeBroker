//
//  NewUserModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/12.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"

@interface NewUserModel : BaseModel

@property (nonatomic, strong) NSString *nid;//": "569370e800b0bca077f50781",
@property (nonatomic, strong) NSString *title;//": "光棍光棍个",
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) BOOL isRedirect;//": 1

@end
