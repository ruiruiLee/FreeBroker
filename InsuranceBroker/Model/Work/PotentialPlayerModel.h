//
//  PotentialPlayerModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/20.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"

@interface PotentialPlayerModel : BaseModel

@property (nonatomic, strong) NSString *userWechatId;//": 1,
@property (nonatomic, strong) NSString *userId;//":null,未激活列表，该值为null
@property (nonatomic, strong) NSString *openId;//":"XXXXX",//微信openid
@property (nonatomic, strong) NSString *rawId;//":"XXXXX", //保留字段
@property (nonatomic, strong) NSString *unionId;//":"XXXX",  //保留字段
@property (nonatomic, strong) NSString *createdAt;//":"2016-",//
@property (nonatomic, strong) NSString *updatedAt;//":2016, //
@property (nonatomic, strong) NSString *subscribe;//":1,  //是否关注公众号，1是，0不是
@property (nonatomic, assign) NSInteger sex;//":1,//0未知，1男，2女
@property (nonatomic, strong) NSString *groupId;//":XXXXX,//保留字段
@property (nonatomic, strong) NSString *headImg;//":XXXXXXX,  //头像
@property (nonatomic, strong) NSString *subscribeTime;//":XXXXX,      //如果关注，有关注时间
@property (nonatomic, strong) NSString *language;//":zh_CN,//使用语言
@property (nonatomic, strong) NSString *remark;//":长得帅, //设置的昵称
@property (nonatomic, strong) NSString *country;//"://国家
@property (nonatomic, strong) NSString *province;//":SiChuan //省
@property (nonatomic, strong) NSString *city;//":ChengDu,//市
@property (nonatomic, assign) NSInteger status;//":1,//状态；1正常，现在只返回1
@property (nonatomic, strong) NSString *nickName;//":长得帅,//微信名
@property (nonatomic, strong) NSString *parentUserId;//":1 //推广人ID

@end
