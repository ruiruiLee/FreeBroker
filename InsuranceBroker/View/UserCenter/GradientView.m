//
//  GradientView.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/30.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView


- (void) setGradientColor:(UIColor *) begin end:(UIColor *)end
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    
    gradient.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    gradient.colors = [NSArray arrayWithObjects:
                       (id)begin.CGColor,
                       (id)end.CGColor,
                       nil];
    
    [self.layer insertSublayer:gradient atIndex:0];
}

@end
