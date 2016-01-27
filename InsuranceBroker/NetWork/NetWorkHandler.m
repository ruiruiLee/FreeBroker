//
//  NetWorkHandler.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/28.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "NetWorkHandler.h"
#import "SBJson.h"
#import "ProjectDefine.h"
#import "define.h"
#import "EGOCache.h"
static NetWorkHandler *networkmanager;

@implementation NetWorkHandler

+ (NetWorkHandler *) shareNetWorkHandler
{
    if(networkmanager == nil)
    {
        networkmanager = [[NetWorkHandler alloc] init];
    }
    
    return networkmanager;
}

- (id) init
{
    self = [super init];
    if(self){
        [ProjectDefine shareProjectDefine];
        self.manager = [AFHTTPRequestOperationManager manager];
    }
    
    return self;
}

- (void) getWithMethod:(NSString *)method BaseUrl:(NSString *)url Params:(NSMutableDictionary *) params Completion:(Completion)completion
{
    NSString *path = url;
    if (method != nil && method.length > 0) {
        path = [url stringByAppendingString:method];
    }
    [self addDeviceAndAppInfo:params];
    if(![method isEqualToString:@"/api/user/login"])
    {
        [self addClientKey:params];
    }
    /**
     * 处理短时间内重复请求
     **/
    NSMutableString *Tag = [[NSMutableString alloc] init];
    [Tag appendString:path];
    for (int i = 0; i < [params.allKeys count]; i++) {
        NSString *key = [params.allKeys objectAtIndex:i];
        [Tag appendFormat:@"%@=%@", key, [params objectForKey:key]];
    }
    
    if([ProjectDefine searchRequestTag:Tag])
    {
        return;
    }
    [ProjectDefine addRequestTag:Tag];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
//    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [self.manager GET:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *result = nil;
        if([responseObject isKindOfClass:[NSData class]]){
            SBJsonParser *_parser = [[SBJsonParser alloc] init];
            result = [_parser objectWithData:(NSData *)responseObject];
        }else{
            result = responseObject;
        }
        
        NSLog(@"请求URL：%@ \n请求方法:%@ \n请求参数：%@\n 请求结果：%@\n==================================", url, method, params, result);
        
        [self handleResponse:result Completion:completion];
        
        [ProjectDefine removeRequestTag:Tag];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"请求URL：%@ \n请求方法:%@ \n请求参数：%@\n 请求结果：%@\n==================================", url, method, params, error);
        [ProjectDefine removeRequestTag:Tag];
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[NSNumber numberWithInteger:error.code] forKey:@"code"];
        [dic setObject:error.localizedDescription forKey:@"msg"];
        [self handleResponse:dic Completion:completion];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}


- (void) postWithMethod:(NSString *)method BaseUrl:(NSString *)url Params:(NSMutableDictionary *) params Completion:(Completion)completion
{
    NSString *path = url;
    if (method != nil && method.length > 0) {
        path = [url stringByAppendingString:method];
    }
    
    [self addDeviceAndAppInfo:params];
    if(![method isEqualToString:@"/api/user/login"])
    {
        [self addClientKey:params];
    }
    
    /**
     * 处理短时间内重复请求
     **/
    NSMutableString *Tag = [[NSMutableString alloc] init];
    [Tag appendString:path];
    for (int i = 0; i < [params.allKeys count]; i++) {
        NSString *key = [params.allKeys objectAtIndex:i];
        [Tag appendFormat:@"%@=%@", key, [params objectForKey:key]];
    }
    
    if([ProjectDefine searchRequestTag:Tag])
    {
//        return;
    }
    [ProjectDefine addRequestTag:Tag];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
//    self.manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [self.manager POST:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [ProjectDefine removeRequestTag:Tag];
        NSDictionary *result = nil;
        if([responseObject isKindOfClass:[NSData class]]){
            SBJsonParser *_parser = [[SBJsonParser alloc] init];
            result = [_parser objectWithData:(NSData *)responseObject];
        }else{
            result = responseObject;
        }
        
        
        NSLog(@"请求URL：%@ \n请求方法:%@ \n请求参数：%@\n 请求结果：%@\n==================================", url, method, params, result);

        [self handleResponse:result Completion:completion];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [ProjectDefine removeRequestTag:Tag];
        NSLog(@"请求URL：%@ \n请求方法:%@ \n请求参数：%@\n 请求结果：%@\n==================================", url, method, params, error);
//        if (error.code != -1001) {
//            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:error.localizedDescription delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//            [alertView show];
//        }
        
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
        [dic setObject:[NSNumber numberWithInteger:error.code] forKey:@"code"];
        [dic setObject:error.localizedDescription forKey:@"msg"];
        
        [self handleResponse:dic Completion:completion];
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    }];
}

- (void) handleResponse:(NSDictionary *)result Completion:(Completion)completion {
    if(![result isKindOfClass:[NSDictionary class]]){
        if(completion){
            completion(-1, nil);
        }
    }else{
        NSInteger code = [[result objectForKey:@"code"] integerValue];
        if(completion){
            completion(code, result);
        }
    }
}

- (void) addDeviceAndAppInfo:(NSMutableDictionary *) parmas
{
    NSString *version = [Util getCurrentVersion];
    [Util setValueForKeyWithDic:parmas value:version key:@"appVersion"];
    NSNumber *deviceType = [NSNumber numberWithInt:2];
    [Util setValueForKeyWithDic:parmas value:deviceType key:@"deviceType"];
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    [Util setValueForKeyWithDic:parmas value:delegate.deviceToken key:@"deviceId"];
}

- (void) addClientKey:(NSMutableDictionary *) parmas
{
    UserInfoModel *user = [UserInfoModel shareUserInfoModel];
    [Util setValueForKeyWithDic:parmas value:user.clientKey key:@"clientKey"];
}


+ (NSDictionary *) getRulesByField:(NSString *) field op:(NSString *) op data:(NSString *) data
{
    NSMutableDictionary *rule = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:rule value:field key:@"field"];
    [Util setValueForKeyWithDic:rule value:op key:@"op"];
    [Util setValueForKeyWithDic:rule value:data key:@"data"];
    
    return rule;
}

+ (NSString *) getStringWithList:(NSArray *)array
{
    NSMutableString *result = [[NSMutableString alloc] init];
    for (int i = 0; i < [array count]; i++) {
        NSString *str = [array objectAtIndex:i];
        [result appendString:str];
        if(i != [array count] -1)
            [result appendString:@"|"];
    }
    
    return result;
}

+ (NSString *) objectToJson:(id) obj
{
    SBJsonWriter *writer = [[SBJsonWriter alloc] init];
    return [writer stringWithObject:obj];
}

@end
