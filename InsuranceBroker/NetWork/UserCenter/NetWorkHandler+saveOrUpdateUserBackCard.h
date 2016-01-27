//
//  NetWorkHandler+saveOrUpdateUserBackCard.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/20.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"

@interface NetWorkHandler (saveOrUpdateUserBackCard)

/*
 backCardId:1//绑定ID
 backId:1；//银行ID
 userId:1；//经纪人ID
 defaultStatus:1；//默认状态；1默认，0不是默认
 backCardNo:XXXXXX；//卡号
 moneyStatus:1；//是否允许提现，1允许，0不允许
 cardholder:长得帅；//持卡人姓名
 openBackName:1；//开户银行全称
 */

+ (void) requestToSaveOrUpdateUserBackCard:(NSString *) backCardId
                                    backId:(NSString *) backId
                                    userId:(NSString *) userId
                             defaultStatus:(NSString *) defaultStatus
                                backCardNo:(NSString *) backCardNo
                               moneyStatus:(NSString *) moneyStatus
                                cardholder:(NSString *) cardholder
                              openBackName:(NSString *) openBackName
                                Completion:(Completion) completion;

@end
