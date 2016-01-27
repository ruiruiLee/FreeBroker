//
//  TagObjectModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/23.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "Mantle.h"
#import <UIKit/UIKit.h>

@interface TagObjectModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *labelName;
@property (nonatomic, copy) NSString *labelId;//没有labelId新增；有labelId进行修改
@property (nonatomic, strong) NSString *labelCustomerNums;
@property (nonatomic, assign) NSInteger labelStatus;//数据状态，1有效，0无效，-1删除
@property (nonatomic, assign) NSInteger labelType;//1、系统定义标签，2客户定义自定义标签
@property (nonatomic, strong) NSString *userId;//如果为自定义，有经纪人ID；系统标签没有值

+ (NSMutableArray *) shareTagList;

@end
