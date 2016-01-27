//
//  GridView.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/29.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "GridView.h"
#import "define.h"

@implementation GridView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, _COLOR(0xe6, 0xe6, 0xe6).CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) / 2, CGRectGetWidth(self.frame), 0.5));
    CGContextFillRect(context, CGRectMake(CGRectGetWidth(self.frame)/2, 0, 0.5, CGRectGetHeight(self.frame)));
}


@end
