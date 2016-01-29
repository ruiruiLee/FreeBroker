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
    beginColor = begin;
    endColor = end;
//    CAGradientLayer *gradient = [CAGradientLayer layer];
//    
//    gradient.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//    
//    gradient.colors = [NSArray arrayWithObjects:
//                       (id)begin.CGColor,
//                       (id)end.CGColor,
//                       nil];
//    
//    NSArray *array = self.layer.sublayers;
//    NSInteger idx = [array count] - 5;
//    if(idx < 0)
//        idx = 0;
//    [self.layer insertSublayer:gradient atIndex:idx];
}

- (void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    NSArray *colors = [NSArray arrayWithObjects:
                       beginColor,
                       endColor,
                       nil];
    [self _drawGradientColor:context
                        rect:rect
                     options:kCGGradientDrawsAfterEndLocation
                      colors:colors];
    CGContextStrokePath(context);// 描线,即绘制形状
    CGContextFillPath(context);// 填充形状内的颜色
}

- (void)_drawGradientColor:(CGContextRef)p_context rect:(CGRect)p_clipRect options:(CGGradientDrawingOptions)p_options colors:(NSArray *)p_colors {
    CGContextSaveGState(p_context);// 保持住现在的context
    CGContextClipToRect(p_context, p_clipRect);// 截取对应的context
    int colorCount = p_colors.count;
    int numOfComponents = 4;
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGFloat colorComponents[colorCount * numOfComponents];
    for (int i = 0; i < colorCount; i++) {
        UIColor *color = p_colors[i];
        CGColorRef temcolorRef = color.CGColor;
        const CGFloat *components = CGColorGetComponents(temcolorRef);
        for (int j = 0; j < numOfComponents; ++j) {
            colorComponents[i * numOfComponents + j] = components[j];
        }
    }
    CGGradientRef gradient =  CGGradientCreateWithColorComponents(rgb, colorComponents, NULL, colorCount);
    CGColorSpaceRelease(rgb);
    CGPoint startPoint = p_clipRect.origin;
    CGPoint endPoint = CGPointMake(CGRectGetMinX(p_clipRect), CGRectGetMaxY(p_clipRect));
    CGContextDrawLinearGradient(p_context, gradient, startPoint, endPoint, p_options);
    CGGradientRelease(gradient);
    CGContextRestoreGState(p_context);// 恢复到之前的context
}

@end
