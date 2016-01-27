//
//  NetWorkHandler+saveOrUpdateCustomer.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/5.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+saveOrUpdateCustomer.h"
#import "define.h"

@implementation NetWorkHandler (saveOrUpdateCustomer)

+ (void) requestToSaveOrUpdateCustomerWithUID:(NSString *) userId
                                isAgentCreate:(BOOL) isAgentCreate //本人创建为1
                                   customerId:(NSString*)customerId
                                 customerName:(NSString *)customerName
                                customerPhone:(NSString* )customerPhone
                                  customerTel:(NSString *)customerTel
                                      headImg:(NSString *)headImg
                                   cardNumber:(NSString *)cardNumber
                               cardNumberImg1:(NSString *)cardNumberImg1
                               cardNumberImg2:(NSString *)cardNumberImg2
                               cardProvinceId:(NSString *)cardProvinceId
                                   cardCityId:(NSString *) cardCityId
                                   cardAreaId:(NSString *) cardAreaId
                                  cardVerifiy:(BOOL) cardVerifiy
                                     cardAddr:(NSString *)cardAddr
                                  verifiyTime:(NSString *)verifiyTime
                               liveProvinceId:(NSString *) liveProvinceId
                                   liveCityId:(NSString *)liveCityId
                                   liveAreaId:(NSString *)liveAreaId
                                     liveAddr:(NSString *)liveAddr
                               customerStatus:(BOOL) customerStatus
                                 drivingCard1:(NSString *)drivingCard1
                                 drivingCard2:(NSString *)drivingCard2
                                customerLabel:(NSArray *) customerLabel
                              customerLabelId:(NSArray *) customerLabelId
                                   Completion:(Completion) completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:userId key:@"userId"];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithBool:isAgentCreate] key:@"isAgentCreate"];
    [Util setValueForKeyWithDic:pramas value:customerId key:@"customerId"];
    [Util setValueForKeyWithDic:pramas value:customerName key:@"customerName"];
    [Util setValueForKeyWithDic:pramas value:customerPhone key:@"customerPhone"];
    [Util setValueForKeyWithDic:pramas value:customerTel key:@"customerTel"];
    [Util setValueForKeyWithDic:pramas value:headImg key:@"headImg"];
    [Util setValueForKeyWithDic:pramas value:cardNumber key:@"cardNumber"];
    [Util setValueForKeyWithDic:pramas value:cardNumberImg1 key:@"cardNumberImg1"];
    [Util setValueForKeyWithDic:pramas value:cardNumberImg2 key:@"cardNumberImg2"];
    [Util setValueForKeyWithDic:pramas value:cardProvinceId key:@"cardProvinceId"];
    [Util setValueForKeyWithDic:pramas value:cardCityId key:@"cardCityId"];
    [Util setValueForKeyWithDic:pramas value:cardAreaId key:@"cardAreaId"];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithBool:cardVerifiy] key:@"cardVerifiy"];
    [Util setValueForKeyWithDic:pramas value:cardAddr key:@"cardAddr"];
    [Util setValueForKeyWithDic:pramas value:verifiyTime key:@"verifiyTime"];
    [Util setValueForKeyWithDic:pramas value:liveProvinceId key:@"liveProvinceId"];
    [Util setValueForKeyWithDic:pramas value:liveCityId key:@"liveCityId"];
    [Util setValueForKeyWithDic:pramas value:liveAreaId key:@"liveAreaId"];
    [Util setValueForKeyWithDic:pramas value:liveAddr key:@"liveAddr"];
    [Util setValueForKeyWithDic:pramas value:[NSNumber numberWithBool:customerStatus] key:@"customerStatus"];
    [Util setValueForKeyWithDic:pramas value:drivingCard1 key:@"drivingCard1"];
    [Util setValueForKeyWithDic:pramas value:drivingCard2 key:@"drivingCard2"];
    [Util setValueForKeyWithDic:pramas value:[NetWorkHandler objectToJson:customerLabel] key:@"customerLabel"];
    [Util setValueForKeyWithDic:pramas value:[NetWorkHandler objectToJson:customerLabelId] key:@"customerLabelId"];
    
    [handle postWithMethod:@"/web/customer/saveOrUpdateCustomer.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
