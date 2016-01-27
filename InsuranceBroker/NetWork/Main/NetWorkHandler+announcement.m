//
//  NetWorkHandler+announcement.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/12.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NetWorkHandler+announcement.h"
#import "define.h"

@implementation NetWorkHandler (announcement)

+ (void) requestToAnnouncement:(NSString *)userId
                    completion:(Completion)completion
{
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    NSMutableDictionary *pramas = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:pramas value:userId key:@"userId"];
    
    [handle postWithMethod:@"/api/news/announcement" BaseUrl:SERVER_ADDRESS Params:pramas Completion:completion];
}

@end
