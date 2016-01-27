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

@property (nonatomic, strong) NSDate *redPackdate;//最后一个红包的时间
@property (nonatomic, assign) BOOL isRedPack;//是否标红

+ (AppContext *)sharedAppContext;
- (void)saveData;
- (void)resetData;
- (void) loadData;
- (void)removeData;

@end
