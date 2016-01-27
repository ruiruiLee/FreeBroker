//
//  NetWorkHandler+saveOrUpdateUserBackCard.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/20.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+saveOrUpdateUserBackCard.h"
#import "define.h"

@implementation NetWorkHandler (saveOrUpdateUserBackCard)

+ (void) requestToSaveOrUpdateUserBackCard:(NSString *) backCardId
                                    backId:(NSString *) backId
                                    userId:(NSString *) userId
                             defaultStatus:(NSString *) defaultStatus
                                backCardNo:(NSString *) backCardNo
                               moneyStatus:(NSString *) moneyStatus
                                cardholder:(NSString *) cardholder
                              openBackName:(NSString *) openBackName
                                Completion:(Completion) completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:userId key:@"userId"];
    [Util setValueForKeyWithDic:pramas value:backCardId key:@"backCardId"];
    [Util setValueForKeyWithDic:pramas value:backId key:@"backId"];
    [Util setValueForKeyWithDic:pramas value:defaultStatus key:@"defaultStatus"];
    [Util setValueForKeyWithDic:pramas value:backCardNo key:@"backCardNo"];
    [Util setValueForKeyWithDic:pramas value:moneyStatus key:@"moneyStatus"];
    [Util setValueForKeyWithDic:pramas value:cardholder key:@"cardholder"];
    [Util setValueForKeyWithDic:pramas value:openBackName key:@"openBackName"];
    [Util setValueForKeyWithDic:pramas value:@"1" key:@"backCardStatus"];
    [Util setValueForKeyWithDic:pramas value:[backCardNo substringFromIndex:[backCardNo length] - 4] key:@"backCardTailNo"];
    
    
    [handle postWithMethod:@"/web/user/saveOrUpdateUserBackCard.xhtml" BaseUrl:Base_Uri Params:pramas Completion:completion];
}

@end
