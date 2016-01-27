//
//  StatisticsModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"

@interface StatisticsModel : BaseModel

@property (nonatomic, strong) NSString *statisticsId;//":1; //统计ID
@property (nonatomic, strong) NSString *userId;//":1; //经纪人ID
@property (nonatomic, strong) NSDate *beginTime;//":"visitType"; //统计开始时间
@property (nonatomic, strong) NSDate *endTime;//":"电话"; //统计结束时间
@property (nonatomic, strong) NSDate *createdAt;//":1; //统计时间
@property (nonatomic, assign) CGFloat monthTotalIn;//":23152; //月总收益
@property (nonatomic, assign) CGFloat monthTotalOut;//":"0"; //前端暂时不用
@property (nonatomic, assign) CGFloat monthTotalRatio;//":60; //超过60%
@property (nonatomic, assign) CGFloat monthInInsurance;//":"0"; //保单占比
@property (nonatomic, assign) CGFloat monthInTeam;//":0; //团队占比
@property (nonatomic, assign) CGFloat monthInRedPack;//":"0"; //红包占比
@property (nonatomic, assign) CGFloat monthInLeader;//":"0"; //管理占比
@property (nonatomic, assign) CGFloat totalIn;//":123152; //总收益

@end
