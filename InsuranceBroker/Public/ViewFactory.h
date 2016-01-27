//
//  ViewFactory.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/16.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "InfoTipsView.h"

@interface ViewFactory : NSObject

/**
 标准化生成UILabel
 */
+ (UILabel *) CreateLabelViewWithFont:(UIFont *) font TextColor:(UIColor *)color;

@end
