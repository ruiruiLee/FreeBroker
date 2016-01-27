//
//  ProjectDefine.h
//  SpringCare
//
//  Created by LiuZach on 15/3/23.
//  Copyright (c) 2015年 cmkj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectDefine : NSObject

@property(nonatomic, retain) NSMutableArray *TagList;

+(ProjectDefine*)shareProjectDefine;

+(BOOL)searchRequestTag:(NSString*)string;

+(void)removeRequestTag:(NSString*)string;

+(void)addRequestTag:(NSString*)string;

+(void)showMessageAutoHide:(NSString*)string;

+(void)showMessage:(NSString*)string;

+(void)hideMessage:(NSString*)string;

@end
