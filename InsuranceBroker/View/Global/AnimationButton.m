//
//  AnimationButton.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/15.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "AnimationButton.h"

@interface AnimationButton ()

//缩小
- (void) animationFromLarger;

//放大
- (void) animationFromSmaller;

@end

@implementation AnimationButton


- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self){

        self.clipsToBounds = YES;
        
        [self addTarget:self action:@selector(animationFromLarger) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(animationFromSmaller) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void) setImage:(UIImage *)image forState:(UIControlState)state
{
//    [super setImage:image forState:state];
    self.layer.contents = (id) image.CGImage;
}

- (void) animationFromLarger
{
    //1.创建动画
     CABasicAnimation *anima=[CABasicAnimation animationWithKeyPath:@"bounds"];
     //1.1设置动画执行时间
     anima.duration=0.25;
     //1.2设置动画执行完毕后不删除动画
     anima.removedOnCompletion=NO;
     //1.3设置保存动画的最新状态
     anima.fillMode=kCAFillModeForwards;
     //1.4修改属性，执行动画
     CGRect frame = self.bounds;
     anima.toValue=[NSValue valueWithCGRect:CGRectMake(0, 0, frame.size.width*0.92, frame.size.height*0.92)];
     //2.添加动画到layer
    [self.layer addAnimation:anima forKey:nil];
}

- (void) animationFromSmaller
{
    //1.创建动画
     CABasicAnimation *anima=[CABasicAnimation animationWithKeyPath:@"bounds"];
     //1.1设置动画执行时间
     anima.duration=0.25;
     //1.2设置动画执行完毕后不删除动画
     anima.removedOnCompletion=NO;
     //1.3设置保存动画的最新状态
     anima.fillMode=kCAFillModeForwards;
     //1.4修改属性，执行动画
     anima.toValue=[NSValue valueWithCGRect:self.bounds];
     //2.添加动画到layer
     [self.layer addAnimation:anima forKey:nil];

}

@end
