//
//  NetWorkHandler+modifyUserInfo.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/15.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+modifyUserInfo.h"
#import "define.h"

@implementation NetWorkHandler (modifyUserInfo)

+ (void) requestToModifyuserInfo:(NSString *) userId
                        realName:(NSString *) realName
                        userName:(NSString *) userName
                           phone:(NSString *) phone
                      cardNumber:(NSString *) cardNumber
                  cardNumberImg1:(NSString *) cardNumberImg1
                  cardNumberImg2:(NSString *) cardNumberImg2
                  liveProvinceId:(NSString *) liveProvinceId
                      liveCityId:(NSString *) liveCityId
                      liveAreaId:(NSString *) liveAreaId
                        liveAddr:(NSString *) liveAddr
                         userSex:(NSString *) userSex
                       headerImg:(NSString *) headerImg
                      Completion:(Completion) completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:userId key:@"userId"];
    [Util setValueForKeyWithDic:pramas value:realName key:@"realName"];
    [Util setValueForKeyWithDic:pramas value:userName key:@"userName"];
    [Util setValueForKeyWithDic:pramas value:phone key:@"phone"];
    [Util setValueForKeyWithDic:pramas value:cardNumber key:@"cardNumber"];
    [Util setValueForKeyWithDic:pramas value:cardNumberImg1 key:@"cardNumberImg1"];
    [Util setValueForKeyWithDic:pramas value:cardNumberImg2 key:@"cardNumberImg2"];
    [Util setValueForKeyWithDic:pramas value:liveProvinceId key:@"liveProvinceId"];
    [Util setValueForKeyWithDic:pramas value:liveCityId key:@"liveCityId"];
    [Util setValueForKeyWithDic:pramas value:liveAreaId key:@"liveAreaId"];
    [Util setValueForKeyWithDic:pramas value:liveAddr key:@"liveAddr"];
    [Util setValueForKeyWithDic:pramas value:userSex key:@"userSex"];
    [Util setValueForKeyWithDic:pramas value:headerImg key:@"headerImg"];
    
    [handle postWithMethod:@"/api/broker/save" BaseUrl:SERVER_ADDRESS Params:pramas Completion:completion];
}

@end
