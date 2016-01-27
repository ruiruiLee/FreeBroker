//
//  ProviendeModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/11.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "ProviendeModel.h"

@implementation ProviendeModel

+ (NSMutableArray *) shareProviendeModelArray;//:(Completion ) completion
{
    static NSMutableArray *provience = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        provience = [[NSMutableArray alloc] init];
        
//        [NetWorkHandler requestToGetProvinces:^(int code, id content) {
//            if(code == 200){
//                NSArray * rows = [ProviendeModel modelArrayFromArray:[[content objectForKey:@"data"] objectForKey:@"rows"]];
//                [provience removeAllObjects];
//                [provience addObjectsFromArray:rows];
//            }
//            if(completion)
//                completion(code, content);
//            
//        }];
    });
    
    return provience;
}

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary
{
    ProviendeModel *model  = [[ProviendeModel alloc] init];
    
    model.provinceId = [dictionary objectForKey:@"provinceId"];
    model.provinceName = [dictionary objectForKey:@"provinceName"];
    model.provinceShortName = [dictionary objectForKey:@"provinceShortName"];
    model.seqNo = [dictionary objectForKey:@"seqNo"];
    
    model.citymodel = nil;
    
    return model;
}

+ (NSArray *) modelArrayFromArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i++) {
        NSDictionary *dic = [array objectAtIndex:i];
        [result addObject:[ProviendeModel modelFromDictionary:dic]];
    }
    
    return result;
}

@end
