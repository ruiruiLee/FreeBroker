//
//  UserInfoModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/28.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "UserInfoModel.h"
#import "define.h"
#import "NetWorkHandler+queryUserInfo.h"

@implementation UserInfoModel

+ (UserInfoModel *) shareUserInfoModel
{
    static UserInfoModel *userModel = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        userModel = [[UserInfoModel alloc] init];
    });

    return userModel;
}

- (id) init
{
    self = [super init];
    if(self){
        
        [self addObserver:self forKeyPath:@"userId" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
        
        self.isLogin = NO;
        
        self.isRegister = NO;
        self.mobileFlag = YES;
        self.webFlag = NO;
        self.sex = 1;
        self.leader = 0;
        self.cardVerifiy = 1;
        self.userType = 1;
        
        [self loadUserinfoFromStore];
    }
    
    return self;
}
- (void) loadUserinfoFromStore
{
    AppContext *context = [AppContext sharedAppContext];
    [context loadData];
    self.isLogin = context.isLogin;
    [self setContentWithDictionary:context.userInfoDic];
}

- (void) setContentWithDictionary:(NSDictionary *) dic
{
    self.isRegister = [[dic objectForKey:@"isRegister"] integerValue];
    self.realName = [dic objectForKey:@"realName"];
    self.headerImg = [dic objectForKey:@"headerImg"];
    self.clientKey = [dic objectForKey:@"clientKey"];
    self.mobileFlag = [[dic objectForKey:@"mobileFlag"]boolValue];
    self.webFlag = [[dic objectForKey:@"webFlag"] boolValue];
    self.phone = [dic objectForKey:@"phone"];
    self.nickname = [dic objectForKey:@"userName"];
    self.sex = [[dic objectForKey:@"sex"] integerValue];
    self.liveProvinceId = [dic objectForKey:@"liveProvinceId"];
    self.liveCityId = [dic objectForKey:@"liveCityId"];
    self.liveProvince = [dic objectForKey:@"liveProvince"];
    self.liveCity = [dic objectForKey:@"liveCity"];
    self.leader = [[dic objectForKey:@"leader"] integerValue];
    self.cardVerifiy = [[dic objectForKey:@"cardVerifiy"] integerValue];
    self.userType = [[dic objectForKey:@"userType"] integerValue];
    self.userId = [dic objectForKey:@"userId"];
    
//    self.cardNumber = [dic objectForKey:@"cardNumber"];
//    self.cardNumberImg1 = [dic objectForKey:@"cardNumberImg1"];
//    self.cardNumberImg2 = [dic objectForKey:@"cardNumberImg2"];
//    self.verifiyTime = [UserInfoModel dateFromString:[dic objectForKey:@"verifiyTime"]];
//    self.status = [[dic objectForKey:@"status"] integerValue];
//    self.cardProvinceId = [dic objectForKey:@"cardProvinceId"];
//    self.cardCityId = [dic objectForKey:@"cardCityId"];
//    self.cardAreaId = [dic objectForKey:@"cardAreaId"];
//    self.isSupport = [[dic objectForKey:@"isSupport"] integerValue];
//    self.maxCustomer = [[dic objectForKey:@"maxCustomer"] integerValue];
//    self.layerNum = [[dic objectForKey:@"layerNum"] integerValue];
//    self.lowerNum = [[dic objectForKey:@"lowerNum"] integerValue];
//    self.brokerEarnings = [[dic objectForKey:@"brokerEarnings"] integerValue];
//    self.redbagEarnings = [[dic objectForKey:@"redbagEarnings"] integerValue];
//    self.orderNums = [[dic objectForKey:@"orderNums"] integerValue];
//    self.liveAreaId = [dic objectForKey:@"liveAreaId"];
//    self.liveAddr = [dic objectForKey:@"liveAddr"];
//    self.createdAt = [UserInfoModel dateFromString:[dic objectForKey:@"createdAt"]];
    
    NSMutableDictionary *dictionary = [self dictionaryWithObject:self];
    AppContext *context = [AppContext sharedAppContext];
    context.userInfoDic = dictionary;
    context.isLogin = self.isLogin;
    [context saveData];
}

- (NSMutableDictionary *) dictionaryWithObject:(UserInfoModel *)model
{
    NSMutableDictionary *mDic = [[NSMutableDictionary alloc] init];
    
    [Util setValueForKeyWithDic:mDic value:self.userId key:@"userId"];
    [Util setValueForKeyWithDic:mDic value:[NSNumber numberWithInt:self.isRegister] key:@"isRegister"];
    [Util setValueForKeyWithDic:mDic value:self.realName key:@"realName"];
    [Util setValueForKeyWithDic:mDic value:self.headerImg key:@"headerImg"];
    [Util setValueForKeyWithDic:mDic value:self.clientKey key:@"clientKey"];
    [Util setValueForKeyWithDic:mDic value:[NSNumber numberWithBool:self.mobileFlag] key:@"mobileFlag"];
    [Util setValueForKeyWithDic:mDic value:[NSNumber numberWithBool:self.webFlag] key:@"webFlag"];
    [Util setValueForKeyWithDic:mDic value:self.phone key:@"phone"];
    [Util setValueForKeyWithDic:mDic value:self.nickname key:@"userName"];
    [Util setValueForKeyWithDic:mDic value:[NSNumber numberWithInt:self.sex] key:@"sex"];
    [Util setValueForKeyWithDic:mDic value:self.liveProvinceId key:@"liveProvinceId"];
    [Util setValueForKeyWithDic:mDic value:self.liveCityId key:@"liveCityId"];
    [Util setValueForKeyWithDic:mDic value:self.liveProvince key:@"liveProvince"];
    [Util setValueForKeyWithDic:mDic value:self.liveCity key:@"liveCity"];
    [Util setValueForKeyWithDic:mDic value:[NSNumber numberWithInt:self.leader] key:@"leader"];
    [Util setValueForKeyWithDic:mDic value:[NSNumber numberWithInt:self.cardVerifiy] key:@"cardVerifiy"];
    [Util setValueForKeyWithDic:mDic value:[NSNumber numberWithInt:self.userType] key:@"userType"];
    
    return mDic;
}

- (void) setDetailContentWithDictionary:(NSDictionary *) dic
{
//    self.userId = [dic objectForKey:@"userId"];
    self.realName = [dic objectForKey:@"realName"];
    self.headerImg = [dic objectForKey:@"headerImg"];
    self.phone = [dic objectForKey:@"phone"];
    self.nickname = [dic objectForKey:@"userName"];
    self.liveProvinceId = [dic objectForKey:@"liveProvinceId"];
    self.liveProvince = [dic objectForKey:@"liveProvince"];
    self.liveCity = [dic objectForKey:@"liveCity"];
    self.liveCityId = [dic objectForKey:@"liveCityId"];
    self.leader = [[dic objectForKey:@"leader"] integerValue];
    self.cardVerifiy = [[dic objectForKey:@"cardVerifiy"] integerValue];
    self.userType = [[dic objectForKey:@"userType"] integerValue];
    self.sex = [[dic objectForKey:@"userSex"] integerValue];
    
    self.cardNumber = [dic objectForKey:@"cardNumber"];
    self.cardNumberImg1 = [dic objectForKey:@"cardNumberImg1"];
    self.cardNumberImg2 = [dic objectForKey:@"cardNumberImg2"];
    self.verifiyTime = [UserInfoModel dateFromString:[dic objectForKey:@"verifiyTime"]];
    self.status = [[dic objectForKey:@"status"] integerValue];
    self.cardProvinceId = [dic objectForKey:@"cardProvinceId"];
    self.cardCityId = [dic objectForKey:@"cardCityId"];
    self.cardAreaId = [dic objectForKey:@"cardAreaId"];
    self.isSupport = [[dic objectForKey:@"isSupport"] integerValue];
    self.maxCustomer = [[dic objectForKey:@"maxCustomer"] integerValue];
    self.layerNum = [[dic objectForKey:@"layerNum"] integerValue];
    self.lowerNum = [[dic objectForKey:@"lowerNum"] integerValue];
    self.brokerEarnings = [[dic objectForKey:@"brokerEarnings"] floatValue];
    self.redbagEarnings = [[dic objectForKey:@"redbagEarnings"] floatValue];
    self.orderNums = [[dic objectForKey:@"orderNums"] integerValue];
    self.liveAreaId = [dic objectForKey:@"liveAreaId"];
    self.liveAddr = [dic objectForKey:@"liveAddr"];
    self.createdAt = [UserInfoModel dateFromString:[dic objectForKey:@"createdAt"]];
    
    self.qrcodeAddr = [dic objectForKey:@"qrcodeAddr"];
    self.monthOrderSuccessNums = [[dic objectForKey:@"monthOrderSuccessNums"] integerValue];
    self.orderSuccessNums = [[dic objectForKey:@"orderSuccessNums"] integerValue];
    self.monthOrderEarn = [[dic objectForKey:@"monthOrderEarn"] floatValue];
    self.orderEarn = [[dic objectForKey:@"orderEarn"] floatValue];
    self.redBagId = [dic objectForKey:@"redBagId"];
    self.userInviteNums = [[dic objectForKey:@"userInviteNums"] integerValue];
    self.userTeamInviteNums = [[dic objectForKey:@"userTeamInviteNums"] integerValue];
    
    self.cardVerifiyMsg = [dic objectForKey:@"cardVerifiyMsg"];
    
    NSMutableDictionary *dictionary = [self dictionaryWithObject:self];
    AppContext *context = [AppContext sharedAppContext];
    context.userInfoDic = dictionary;
    context.isLogin = self.isLogin;
    if([context.redBagId longLongValue] < [self.redBagId longLongValue])
        context.isRedPack = YES;
    context.redBagId = self.redBagId;
    [context saveData];
}

- (void) queryUserInfo
{
    if(self.userId == nil || [self.userId length] == 0)
        return;
    [NetWorkHandler requestToQueryUserInfo:self.userId Completion:^(int code, id content) {
        if(code == 200){
            [self setDetailContentWithDictionary:[content objectForKey:@"data"]];
        }
    }];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"userId"]){
        [self performSelector:@selector(queryUserInfo) withObject:nil afterDelay:0.1];
    }
}

@end
