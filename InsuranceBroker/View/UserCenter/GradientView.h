//
//  GradientView.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/30.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GradientView : UIView
{
    UIColor *beginColor;
    UIColor *endColor;
}


- (void) setGradientColor:(UIColor *) begin end:(UIColor *)end;

@end
