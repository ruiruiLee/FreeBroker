//
//  HaedlineModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/12.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"

@interface HeadlineModel : BaseModel

@property (nonatomic, strong) NSString *hid;//": "569370e800b0bca077f50781",
@property (nonatomic, strong) NSString *title;//": "光棍光棍个",
@property (nonatomic, assign) BOOL isRedirect;//": 1
@property (nonatomic, strong) NSString *url;

@end
