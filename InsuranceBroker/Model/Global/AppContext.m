//
//  AppContext.m
//  Zwjxt
//
//  Created by Liang on 8/31/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppContext.h"

static AppContext *context = nil;

@implementation AppContext

@synthesize docDir;
@synthesize userInfoDic;
@synthesize isLogin;

+ (AppContext *) sharedAppContext
{
    if(context == nil)
    {
        context = [[AppContext alloc] init];
    }
    
    return context;
}

- (id)init
{
    if ((self = [super init])) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.docDir = [paths objectAtIndex:0];
        NSString *file = [docDir stringByAppendingPathComponent:@"data.plist"];
        if ([[NSFileManager defaultManager] fileExistsAtPath:file]) {
            NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:file];
            if (dic != nil) {
                self.userInfoDic = [[NSMutableDictionary alloc] initWithDictionary:[dic objectForKey:@"userInfoDic"]];
                self.isLogin = [[dic objectForKey:@"isLogin"] boolValue];
                self.firstLaunch = [[dic objectForKey:@"firstLaunch"] boolValue];
                self.redBagId = [dic objectForKey:@"redBagId"];
                self.isRedPack = [[dic objectForKey:@"isRedPack"] boolValue];
                self.isHasNotice = [[dic objectForKey:@"isHasNotice"] boolValue];
                self.isHasNewPolicy = [[dic objectForKey:@"isHasNewPolicy"] boolValue];
                self.isHasTradingMsg = [[dic objectForKey:@"isHasTradingMsg"] boolValue];
                self.isHasIncentivePolicy = [[dic objectForKey:@"isHasIncentivePolicy"] boolValue];
                self.pushCustomerNum = [[dic objectForKey:@"pushCustomerNum"] integerValue];
                self.isNewMessage = [[dic objectForKey:@"isNewMessage"] boolValue];
            }
            else{
                self.userInfoDic = [[NSMutableDictionary alloc] init];
                self.isLogin = NO;
                self.firstLaunch = NO;
                self.redBagId = nil;
                self.isRedPack = NO;
                self.isHasNotice = NO;
                self.isHasNewPolicy = NO;
                self.isHasTradingMsg = NO;
                self.isHasIncentivePolicy = NO;
                self.pushCustomerNum = 0;
                self.isNewMessage = NO;
            }
        }else{
            self.userInfoDic = [[NSMutableDictionary alloc] init];
            self.isLogin = NO;
            self.firstLaunch = NO;
            self.redBagId = nil;
            self.isRedPack = NO;
            self.isHasNotice = NO;
            self.isHasNewPolicy = NO;
            self.isHasTradingMsg = NO;
            self.isHasIncentivePolicy = NO;
            self.pushCustomerNum = 0;
            self.isNewMessage = NO;
        }
    }
    
    return self;
}

- (void)saveData
{
    NSString *file = [docDir stringByAppendingPathComponent:@"data.plist"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    if(userInfoDic)
        [dic setObject:userInfoDic forKey:@"userInfoDic"];
    else
        [dic setObject:@{} forKey:@"userInfoDic"];
    
    [dic setObject:[NSNumber numberWithBool:self.isLogin] forKey:@"isLogin"];
    [dic setObject:[NSNumber numberWithBool:self.firstLaunch] forKey:@"firstLaunch"];
    if(self.redBagId)
        [dic setObject:self.redBagId forKey:@"redPackdate"];
    [dic setObject:[NSNumber numberWithBool:self.isRedPack] forKey:@"isRedPack"];
    [dic setObject:[NSNumber numberWithBool:self.isHasNotice] forKey:@"isHasNotice"];
    [dic setObject:[NSNumber numberWithBool:self.isHasNewPolicy] forKey:@"isHasNewPolicy"];
    [dic setObject:[NSNumber numberWithBool:self.isHasTradingMsg] forKey:@"isHasTradingMsg"];
    [dic setObject:[NSNumber numberWithBool:self.isHasIncentivePolicy] forKey:@"isHasIncentivePolicy"];
    [dic setObject:[NSNumber numberWithInt:self.pushCustomerNum] forKey:@"pushCustomerNum"];
    [dic setObject:[NSNumber numberWithBool:self.isNewMessage ] forKey:@"isNewMessage"];
    
    [dic writeToFile:file atomically:YES];
}

- (void)removeData
{
    NSString *file = [docDir stringByAppendingPathComponent:@"data.plist"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@{} forKey:@"userInfoDic"];
    [dic setObject:[NSNumber numberWithBool:NO] forKey:@"isLogin"];
    [dic setObject:[NSNumber numberWithBool:self.firstLaunch] forKey:@"firstLaunch"];
    [dic setObject:[NSNumber numberWithBool:NO] forKey:@"isRedPack"];
    [dic setObject:[NSNumber numberWithBool:NO] forKey:@"isHasNotice"];
    [dic setObject:[NSNumber numberWithBool:NO] forKey:@"isHasNewPolicy"];
    [dic setObject:[NSNumber numberWithBool:NO] forKey:@"isHasTradingMsg"];
    [dic setObject:[NSNumber numberWithBool:NO] forKey:@"isHasIncentivePolicy"];
    [dic setObject:[NSNumber numberWithBool:NO] forKey:@"isNewMessage"];
    [dic setObject:[NSNumber numberWithInt:self.pushCustomerNum] forKey:@"pushCustomerNum"];
    
    [dic writeToFile:file atomically:YES];
}


- (void) loadData
{
    NSString *file = [docDir stringByAppendingPathComponent:@"data.plist"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:file]) {
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:file];
        if (dic != nil) {
            self.userInfoDic = [[NSMutableDictionary alloc] initWithDictionary:[dic objectForKey:@"userInfoDic"]];
            self.isLogin = [[dic objectForKey:@"isLogin"] boolValue];
            self.firstLaunch = [[dic objectForKey:@"firstLaunch"] boolValue];
            self.redBagId = [dic objectForKey:@"redBagId"];
            self.isRedPack = [[dic objectForKey:@"isRedPack"] boolValue];
            self.isHasNotice = [[dic objectForKey:@"isHasNotice"] boolValue];
            self.isHasNewPolicy = [[dic objectForKey:@"isHasNewPolicy"] boolValue];
            self.isHasTradingMsg = [[dic objectForKey:@"isHasTradingMsg"] boolValue];
            self.isHasIncentivePolicy = [[dic objectForKey:@"isHasIncentivePolicy"] boolValue];
            self.isNewMessage = [[dic objectForKey:@"isNewMessage"] boolValue];
            self.pushCustomerNum = [[dic objectForKey:@"pushCustomerNum"] integerValue];
        }
        else{
            self.userInfoDic = [[NSMutableDictionary alloc] init];
            self.isLogin = NO;
            self.firstLaunch = NO;
            self.redBagId = nil;
            self.isRedPack = NO;
            self.isHasNotice = NO;
            self.isHasNewPolicy = NO;
            self.isHasTradingMsg = NO;
            self.isHasIncentivePolicy = NO;
            self.isNewMessage = NO;
            self.pushCustomerNum = 0;
        }
    }else{
        self.userInfoDic = [[NSMutableDictionary alloc] init];
        self.isLogin = NO;
        self.firstLaunch = NO;
        self.redBagId = nil;
        self.isRedPack = NO;
        self.isHasNotice = NO;
        self.isHasNewPolicy = NO;
        self.isHasTradingMsg = NO;
        self.isHasIncentivePolicy = NO;
        self.isNewMessage = NO;
        self.pushCustomerNum = 0;
    }
}

- (void)resetData
{
    [self saveData];
}

- (void)dealloc
{
    self.docDir = nil;
}

@end
