//
//  TagObjectModel.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/23.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "TagObjectModel.h"

static BOOL isLoadTagList = NO;

@implementation TagObjectModel

+ (NSMutableArray *) shareTagList
{
    static NSMutableArray *tagList = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        tagList = [[NSMutableArray alloc] init];
    });
    
    return tagList;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"labelName": @"labelName",
             @"labelId": @"labelId",
             @"labelCustomerNums": @"labelCustomerNums",
             @"labelStatus": @"labelStatus",
             @"labelType": @"labelType",
             @"userId": @"userId"
             };
}

@end
