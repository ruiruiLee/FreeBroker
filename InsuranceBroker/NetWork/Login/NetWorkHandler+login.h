//
//  NetWorkHandler+login.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/3.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (login)

+ (void) loginWithPhone:(NSString *)phone
                 openId:(NSString *)openId
                    sex:(NSInteger) sex
               nickname:(NSString *)nickname
              privilege:(NSArray *)privilege
                unionid:(NSString*)unionid
               province:(NSString*)province
               language:(NSString*)language
             headimgurl:(NSString *)headimgurl
                   city:(NSString *)city
                country:(NSString *)country
                 smCode:(NSString *)smCode
             Completion:(Completion)completion;

@end
