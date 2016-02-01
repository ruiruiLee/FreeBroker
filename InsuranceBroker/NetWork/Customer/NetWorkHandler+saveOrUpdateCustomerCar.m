//
//  NetWorkHandler+saveOrUpdateCustomerCar.m
//  InsuranceBroker
//
//  后台或手机端管理客户车险信息接口
//
//  Created by LiuZach on 16/1/6.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+saveOrUpdateCustomerCar.h"
#import "define.h"

@implementation NetWorkHandler (saveOrUpdateCustomerCar)

+ (void) requestToSaveOrUpdateCustomerCar:(NSString *) customerCarId
                               customerId:(NSString *) customerId
                                    carNo:(NSString *) carNo
                            carProvinceId:(NSString *) carProvinceId
                                carCityId:(NSString *) carCityId
                          driveProvinceId:(NSString *) driveProvinceId
                              driveCityId:(NSString *) driveCityId
                                carTypeNo:(NSString *) carTypeNo
                               carShelfNo:(NSString *) carShelfNo
                              carEngineNo:(NSString *) carEngineNo
                             carOwnerName:(NSString *) carOwnerName
                             carOwnerCard:(NSString *) carOwnerCard
                            carOwnerPhone:(NSString *) carOwnerPhone
                              carOwnerTel:(NSString *) carOwnerTel
                             carOwnerAddr:(NSString *) carOwnerAddr
                              travelCard1:(NSString *) travelCard1
                               carRegTime:(NSString *) carRegTime
                           newCarNoStatus:(NSString *) newCarNoStatus
                           carTradeStatus:(NSString *) carTradeStatus
                             carTradeTime:(NSString *) carTradeTime
                          carInsurStatus1:(NSString *) carInsurStatus1
                          carInsurCompId1:(NSString *) carInsurCompId1
                               Completion:(Completion) completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:customerCarId key:@"customerCarId"];
    [Util setValueForKeyWithDic:pramas value:customerId key:@"customerId"];
    [Util setValueForKeyWithDic:pramas value:[carNo uppercaseString] key:@"carNo"];
    [Util setValueForKeyWithDic:pramas value:carProvinceId key:@"carProvinceId"];
    [Util setValueForKeyWithDic:pramas value:carCityId key:@"carCityId"];
    [Util setValueForKeyWithDic:pramas value:driveProvinceId key:@"driveProvinceId"];
    [Util setValueForKeyWithDic:pramas value:driveCityId key:@"driveCityId"];
    [Util setValueForKeyWithDic:pramas value:[carTypeNo uppercaseString] key:@"carTypeNo"];
    [Util setValueForKeyWithDic:pramas value:[carShelfNo uppercaseString] key:@"carShelfNo"];
    [Util setValueForKeyWithDic:pramas value:[carEngineNo uppercaseString] key:@"carEngineNo"];
    [Util setValueForKeyWithDic:pramas value:carOwnerName key:@"carOwnerName"];
    [Util setValueForKeyWithDic:pramas value:carOwnerCard key:@"carOwnerCard"];
    [Util setValueForKeyWithDic:pramas value:carOwnerPhone key:@"carOwnerPhone"];
    [Util setValueForKeyWithDic:pramas value:carOwnerTel key:@"carOwnerTel"];
    [Util setValueForKeyWithDic:pramas value:carOwnerAddr key:@"carOwnerAddr"];
    [Util setValueForKeyWithDic:pramas value:travelCard1 key:@"travelCard1"];
    [Util setValueForKeyWithDic:pramas value:carRegTime key:@"carRegTime"];
    [Util setValueForKeyWithDic:pramas value:newCarNoStatus key:@"newCarNoStatus"];
    [Util setValueForKeyWithDic:pramas value:carTradeStatus key:@"carTradeStatus"];
    [Util setValueForKeyWithDic:pramas value:carTradeTime key:@"carTradeTime"];
    [Util setValueForKeyWithDic:pramas value:carInsurStatus1 key:@"carInsurStatus1"];
    [Util setValueForKeyWithDic:pramas value:carInsurCompId1 key:@"carInsurCompId1"];
    [Util setValueForKeyWithDic:pramas value:@"1" key:@"status"];
    
    [handle postWithMethod:@"/web/customer/saveOrUpdateCustomerCar.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
