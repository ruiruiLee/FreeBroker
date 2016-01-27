//
//  RedPackModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/20.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"

@interface RedPackModel : BaseModel

@property (nonatomic, strong) NSString *redPackId;//":1; //红包ID
@property (nonatomic, assign) NSInteger redPackType;//":1; //红包类型1公共红包，2个人红包，3团队红包
@property (nonatomic, strong) NSString *redPackTitle;//":"长的帅红包"; //红包名称
@property (nonatomic, strong) NSString *redPackRuleMemo;//":"长的帅才能领"; //红包规则说明
@property (nonatomic, strong) NSString *redPackMemo;//":你要满足长的帅; //红包备注说明
@property (nonatomic, strong) NSDate *createdAt;//":2015-; //创建时间
@property (nonatomic, strong) NSDate *updatedAt;//":2015-; //修改时间
@property (nonatomic, assign) NSInteger redPackValueType;//":"1"; //1现金，2保单收益翻倍，3.。。
@property (nonatomic, assign) CGFloat redPackValue;//":"100.00"; //价值；现金直接存入，翻倍X
@property (nonatomic, strong) NSString *redPackObjId;//":; //如果是个人/团队红包，需要关联个人/团队长ID
@property (nonatomic, assign) NSInteger redPackStatus;//":"1"; //状态；1正常，0禁用，-1删除
@property (nonatomic, strong) NSString *userId;//":"1"; //领取红包经纪人ID
@property (nonatomic, assign) NSInteger redPackUserStatus;//null或0未领取，1已领取
@property (nonatomic, assign) NSInteger seqNo;//":"1"; //红包排序，降序
@property (nonatomic, strong) NSString *redPackLogo;//":"XXXXXXX"; //红包logo
@property (nonatomic, strong) NSString *redPackBgImg;//":"XXXXXXXX"; //红包背景图
@property (nonatomic, assign) BOOL keepTop;//":"0"; //置顶，1是，0不是

@end
