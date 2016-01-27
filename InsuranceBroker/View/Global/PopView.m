//
//  PopView.m
//  SpringCare
//
//  Created by LiuZach on 15/11/20.
//  Copyright © 2015年 cmkj. All rights reserved.
//

#import "PopView.h"
#import "define.h"
#import "AppInfoView.h"

@implementation PopView
@synthesize bgView;
@synthesize view;
@synthesize delegate;

- (id) initWithImageArray:(NSArray*) images nameArray:(NSArray*) names
{
    self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, SCREEN_HEIGHT)];
    
    if(self){
        
//        self.backgroundColor = [UIColor blackColor];
        
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, SCREEN_HEIGHT)];
        [self addSubview:view];
        view.backgroundColor = [UIColor clearColor];
        
        bgView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, ScreenWidth, 200)];
        [self addSubview:bgView];
        bgView.backgroundColor = [UIColor whiteColor];
        
        CGFloat step = (ScreenWidth - [names count] * 80) /  ([names count] + 1);
        
        CGFloat ox = step;
        
        for (int i = 0; i < [names count]; i++) {
            
            AppInfoView *control = [[AppInfoView alloc] initWithFrame:CGRectMake(ox, 20, 80, 80)];
            [bgView addSubview:control];
            control.lbName.text = [names objectAtIndex:i];
            control.logo.image = ThemeImage([images objectAtIndex:i]);
            [control addTarget:self action:@selector(handleControlClickedEvent:) forControlEvents:UIControlEventTouchUpInside];
            control.lbName.font = _FONT(14);
            CGRect rect = control.lbName.frame;
            control.lbName.frame = CGRectMake(rect.origin.x, rect.origin.y + 15, rect.size.width, rect.size.height);
            
            control.tag = 1000 + i;
            
            ox += (step + 80);
        }
        
        UIButton *btnCancel = [[UIButton alloc] initWithFrame:CGRectMake(20, 130, ScreenWidth - 20 * 2, 42)];
        btnCancel.layer.cornerRadius = 3;
//        btnCancel.layer.borderWidth = 1;
//        btnCancel.layer.borderColor = [UIColor grayColor].CGColor;
        [btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        [btnCancel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btnCancel.titleLabel.font = _FONT(18);
        btnCancel.backgroundColor = _COLOR(0xff, 0x66, 0x19);
        [bgView addSubview:btnCancel];
        [btnCancel addTarget:self action:@selector(handleCancelClicked:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
}

- (void) handleControlClickedEvent:(UIControl *) control
{
    NSInteger tag = control.tag;
    
    [UIView animateWithDuration:0.25 animations:^{
        view.alpha = 1;
        view.backgroundColor = [UIColor clearColor];
        bgView.frame = CGRectMake(0, SCREEN_HEIGHT, ScreenWidth, 200);
    } completion:^(BOOL finished) {
        self.hidden = YES;
        
        if(delegate && [delegate respondsToSelector:@selector(HandleItemSelect:withTag:)])
        {
            [delegate HandleItemSelect:self withTag:tag - 1000];
        }
        
    }];
}

- (void) show
{
    self.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.3;
        bgView.frame = CGRectMake(0, SCREEN_HEIGHT - 200, ScreenWidth, 200);
    }];
}

- (void) hidden
{
    [UIView animateWithDuration:0.25 animations:^{
        view.alpha = 1;
        view.backgroundColor = [UIColor clearColor];
        bgView.frame = CGRectMake(0, SCREEN_HEIGHT, ScreenWidth, 200);
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
}

- (void) handleCancelClicked:(UIButton *)sender
{
    [self hidden];
}

@end
