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
                self.pushCustomerNum = [[dic objectForKey:@"pushCustomerNum"] integerValue];
                self.isNewMessage = [[dic objectForKey:@"isNewMessage"] boolValue];
                self.arrayNewsTip =[dic objectForKey:@"arrayNewsTip"];
            }
            else{
                self.userInfoDic = [[NSMutableDictionary alloc] init];
                self.isLogin = NO;
                self.firstLaunch = NO;
                self.redBagId = nil;
                self.isRedPack = NO;
                self.pushCustomerNum = 0;
                self.isNewMessage = NO;
                self.arrayNewsTip= [NSMutableArray new];
            }
        }else{
            self.userInfoDic = [[NSMutableDictionary alloc] init];
            self.isLogin = NO;
            self.firstLaunch = NO;
            self.redBagId = nil;
            self.isRedPack = NO;
            self.pushCustomerNum = 0;
            self.isNewMessage = NO;
            self.arrayNewsTip= [NSMutableArray new];
        }
    }
    
    return self;
}

// 判断该类别是否显示红点
- (BOOL)judgeDisplay:(NSInteger)category{
    for (NSDictionary *dic in self.arrayNewsTip) {
        if (category==[[dic objectForKey:@"category"] integerValue]) {
            return [[dic objectForKey:@"isNew"] boolValue];
        }
    }
    return false;
}


- (void)changeNewsTip:(NSInteger)category display:(BOOL)display{
    int i=0;
    for (NSMutableDictionary *dicOld in _arrayNewsTip){
        
        if (category==[[dicOld objectForKey:@"category"] integerValue]){
            NSMutableDictionary *dic= [NSMutableDictionary dictionaryWithDictionary:dicOld];
            [dic setValue:[NSNumber numberWithBool:display] forKey:@"isNew"];
            [_arrayNewsTip replaceObjectAtIndex: i withObject:dic];
            break;
        }
        i++;
    }
    
    BOOL displayMsg =NO;
    for (NSDictionary *dic in _arrayNewsTip) {
        if ([[dic objectForKey:@"isNew"] boolValue]) {
            displayMsg = YES;
            break;
        }
    }
    self.isNewMessage = displayMsg;
    [self saveData];
}
// 存储类别显示红点信息
- (void)SaveNewsTip:(NSArray*) arrayNew{
    if (_arrayNewsTip.count==0) {
        _arrayNewsTip= [NSMutableArray arrayWithArray: arrayNew];
        BOOL displayMsg =NO;
        for (NSDictionary *dic in _arrayNewsTip) {
            if ([[dic objectForKey:@"isNew"] boolValue]) {
                displayMsg = YES;
                break;
            }
        }
        self.isNewMessage = displayMsg;
        [self saveData];
        return;
    }
    BOOL displayMsg = self.isNewMessage;
    int i=0;
    NSMutableArray * changArray = [NSMutableArray arrayWithArray:arrayNew];
    for (NSDictionary *dicNew in arrayNew) {
        NSMutableDictionary *dic= [NSMutableDictionary dictionaryWithDictionary:dicNew];
        for (NSDictionary *dicOld in _arrayNewsTip) {
            
            if ([[dicNew objectForKey:@"category"] integerValue]==
                [[dicOld objectForKey:@"category"] integerValue])
                // 有消息更新
            {
                long long datenew = [[dicNew objectForKey:@"lastNewsDt"] longLongValue];
                long long dateold = [[dicOld objectForKey:@"lastNewsDt"] longLongValue];
                if (datenew>dateold) {
                    
                    [dic setValue: [NSNumber numberWithBool:true]   forKey:@"isNew"];
                    //                   [dic setValue: [NSNumber numberWithLong:datenew]   forKey:@"lastNewsDt"];
                    [dic setValue:[NSNumber numberWithLongLong:datenew] forKey:@"lastNewsDt"];
                    displayMsg = YES;
                }
                else{ //没有消息更新
                    [dic setValue: [dicOld objectForKey:@"isNew"]  forKey:@"isNew"];
                    
                }
                [changArray replaceObjectAtIndex: i withObject:dic];
                
                
            }
        }
        i++;
    }
    self.isNewMessage = displayMsg;
    [_arrayNewsTip removeAllObjects];
    self.arrayNewsTip =  [NSMutableArray arrayWithArray: changArray];
    [self saveData];
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
    [dic setObject:[NSNumber numberWithInteger:self.pushCustomerNum] forKey:@"pushCustomerNum"];
    // 用于判断是否有新消息所用
    [dic setObject:[NSNumber numberWithBool:self.isNewMessage ] forKey:@"isNewMessage"];
    if(self.arrayNewsTip)
        [dic setObject:self.arrayNewsTip forKey:@"arrayNewsTip"];
    
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
    
    //    [dic setObject:[NSNumber numberWithBool:NO] forKey:@"isNewMessage"];
    //    [self.arrayNewsTip removeAllObjects];
    //     [dic setObject:self.arrayNewsTip forKey:@"arrayNewsTip"];
    [dic setObject:[NSNumber numberWithInteger:self.pushCustomerNum] forKey:@"pushCustomerNum"];
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
            self.isNewMessage = [[dic objectForKey:@"isNewMessage"] boolValue];
            self.arrayNewsTip =[dic objectForKey:@"arrayNewsTip"];
            self.pushCustomerNum = [[dic objectForKey:@"pushCustomerNum"] integerValue];
        }
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
