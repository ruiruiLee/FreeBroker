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
                self.redPackdate = [dic objectForKey:@"redPackdate"];
                self.isRedPack = [[dic objectForKey:@"isRedPack"] boolValue];
            }
            else{
                self.userInfoDic = [[NSMutableDictionary alloc] init];
                self.isLogin = NO;
                self.firstLaunch = NO;
                self.redPackdate = nil;
                self.isRedPack = NO;
            }
        }else{
            self.userInfoDic = [[NSMutableDictionary alloc] init];
            self.isLogin = NO;
            self.firstLaunch = NO;
            self.redPackdate = nil;
            self.isRedPack = NO;
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
    if(self.redPackdate)
        [dic setObject:self.redPackdate forKey:@"redPackdate"];
    
    [dic writeToFile:file atomically:YES];
}

- (void)removeData
{
    NSString *file = [docDir stringByAppendingPathComponent:@"data.plist"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setObject:@{} forKey:@"userInfoDic"];
    [dic setObject:[NSNumber numberWithBool:NO] forKey:@"isLogin"];
    [dic setObject:[NSNumber numberWithBool:self.firstLaunch] forKey:@"firstLaunch"];
    [dic setObject:[NSNumber numberWithBool:self.isRedPack] forKey:@"isRedPack"];
    
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
            self.redPackdate = [dic objectForKey:@"redPackdate"];
            self.isRedPack = [[dic objectForKey:@"isRedPack"] boolValue];
        }
        else{
            self.userInfoDic = [[NSMutableDictionary alloc] init];
            self.isLogin = NO;
            self.firstLaunch = NO;
            self.redPackdate = nil;
            self.isRedPack = NO;
        }
    }else{
        self.userInfoDic = [[NSMutableDictionary alloc] init];
        self.isLogin = NO;
        self.firstLaunch = NO;
        self.redPackdate = nil;
        self.isRedPack = NO;
    }
}

- (void)resetData
{
    
//    NSString *file = [docDir stringByAppendingPathComponent:@"data.plist"];
//    [[NSFileManager defaultManager] removeItemAtPath:file error:nil];
    [self saveData];
}

- (void)dealloc
{
    self.docDir = nil;
}

@end
