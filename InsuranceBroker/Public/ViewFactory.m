//
//  ViewFactory.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/16.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "ViewFactory.h"

@implementation ViewFactory

+ (UILabel *) CreateLabelViewWithFont:(UIFont *) font TextColor:(UIColor *)color
{
    UILabel *lb = [[UILabel alloc] init];
    
    lb.textColor = color;
    
    lb.font = font;
    
    lb.backgroundColor = [UIColor clearColor];
    
    lb.translatesAutoresizingMaskIntoConstraints = NO;
    
    return lb;
}

@end
