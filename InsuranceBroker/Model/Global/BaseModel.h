//
//  BaseModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/5.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseModel : NSObject

+ (NSDate *)dateFromString:(NSString *)string;
+ (NSDateFormatter *)dateFormatter;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSDate *)dateFromInteger:(long long)integer;

+ (BaseModel *) modelFromDictionary:(NSDictionary *)dictionary;

//数组
+ (NSArray *) modelArrayFromArray:(NSArray *)array;

+ (BOOL) dateIsNil:(NSDate *) date;

@end
