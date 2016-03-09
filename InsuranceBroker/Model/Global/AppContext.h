//
//  AppContext.h
//  Zwjxt
//
//  Created by Liang on 8/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppContext : NSObject
{
    NSString *docDir;

    NSMutableDictionary *userInfoDic;
}

@property(nonatomic, strong)NSString *docDir;


@property(nonatomic, copy) NSMutableDictionary *userInfoDic;
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, assign) BOOL firstLaunch;

@property (nonatomic, strong) NSString *redBagId;//最后一个红包的id
@property (nonatomic, assign) BOOL isRedPack;//是否标红

//我的消息
//@property (nonatomic, assign) BOOL isHasNotice;//通知消息
//@property (nonatomic, assign) BOOL isHasNewPolicy;//新政策
//@property (nonatomic, assign) BOOL isHasTradingMsg;//交易消息
//@property (nonatomic, assign) BOOL isHasIncentivePolicy;//激励政策
@property (nonatomic, assign) BOOL isNewMessage;
@property (nonatomic, retain) NSMutableArray* arrayNewsTip;

//推送客户
@property (nonatomic, assign) NSInteger pushCustomerNum;//推送客户

+ (AppContext *)sharedAppContext;
- (void)saveData;
- (void)resetData;
- (void) loadData;
- (void)removeData;
- (BOOL)judgeDisplay:(NSInteger)category;  // 判断是否有新的消息 好显示红点
- (void)SaveNewsTip:(NSArray*) arrayNew; // 存储类别显示红点信息
- (void)changeNewsTip:(NSInteger)category display:(BOOL)display; // 点击后显示或者取消红点

@end
