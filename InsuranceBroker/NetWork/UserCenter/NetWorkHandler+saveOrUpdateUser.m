//
//  NetWorkHandler+saveOrUpdateUser.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/9.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+saveOrUpdateUser.h"
#import "define.h"

@implementation NetWorkHandler (saveOrUpdateUser)

+ (void) requestToSaveOrUpdateUser:(NSString *) userId
                          realName:(NSString *) realName
                          userType:(NSString *) userType
                         isSupport:(NSString *) isSupport
                       maxCustomer:(NSString *) maxCustomer
                    cardProvinceId:(NSString *) cardProvinceId
                        cardCityId:(NSString *) cardCityId
                        cardAreaId:(NSString *) cardAreaId
                             phone:(NSString *) phone
                            levers:(NSString *) levers
                        cardNumber:(NSString *) cardNumber
                    cardNumberImg1:(NSString *) cardNumberImg1
                    cardNumberImg2:(NSString *) cardNumberImg2
                            status:(NSString *) status
                       cardVerifiy:(NSString *) cardVerifiy
                    liveProvinceId:(NSString *) liveProvinceId
                        liveCityId:(NSString *) liveCityId
                        liveAreaId:(NSString *) liveAreaId
                          liveAddr:(NSString *) liveAddr
                        Completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:userId key:@"userId"];
    [Util setValueForKeyWithDic:pramas value:realName key:@"realName"];
    [Util setValueForKeyWithDic:pramas value:userType key:@"userType"];
    [Util setValueForKeyWithDic:pramas value:isSupport key:@"isSupport"];
    [Util setValueForKeyWithDic:pramas value:maxCustomer key:@"maxCustomer"];
    [Util setValueForKeyWithDic:pramas value:cardProvinceId key:@"cardProvinceId"];
    [Util setValueForKeyWithDic:pramas value:cardCityId key:@"cardCityId"];
    [Util setValueForKeyWithDic:pramas value:cardAreaId key:@"cardAreaId"];
    [Util setValueForKeyWithDic:pramas value:phone key:@"phone"];
    [Util setValueForKeyWithDic:pramas value:levers key:@"levers"];
    [Util setValueForKeyWithDic:pramas value:cardNumber key:@"cardNumber"];
    [Util setValueForKeyWithDic:pramas value:cardNumberImg1 key:@"cardNumberImg1"];
    [Util setValueForKeyWithDic:pramas value:cardNumberImg2 key:@"cardNumberImg2"];
    [Util setValueForKeyWithDic:pramas value:status key:@"status"];
    [Util setValueForKeyWithDic:pramas value:cardVerifiy key:@"cardVerifiy"];
    [Util setValueForKeyWithDic:pramas value:liveProvinceId key:@"liveProvinceId"];
    [Util setValueForKeyWithDic:pramas value:liveAreaId key:@"liveAreaId"];
    [Util setValueForKeyWithDic:pramas value:liveAddr key:@"liveAddr"];
    [Util setValueForKeyWithDic:pramas value:liveCityId key:@"liveCityId"];
    
    [handle postWithMethod:@"/web/user/saveOrUpdateUser.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
