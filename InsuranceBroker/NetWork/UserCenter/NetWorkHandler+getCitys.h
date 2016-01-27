//
//  NetWorkHandler+getCitys.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/11.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (getCitys)

+ (void) requestToGetCitys:(NSString *) provinceId Completion:(Completion)completion;

@end
