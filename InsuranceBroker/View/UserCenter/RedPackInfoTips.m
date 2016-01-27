//
//  RedPackInfoTips.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "RedPackInfoTips.h"
#import "define.h"

@implementation RedPackInfoTips
@synthesize alview;

- (id) init
{
    self = [super init];
    if(self){
        
        alview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, SCREEN_HEIGHT)];
        [self addSubview:alview];
        alview.backgroundColor = [UIColor blackColor];
        alview.alpha = 0.3;
        
        self.bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 60, 220)];
        [self addSubview:self.bgview];
        self.bgview.backgroundColor = [UIColor whiteColor];
        self.bgview.layer.cornerRadius = 4;
        self.bgview.center = alview.center;
        
        self.lbTitle = [ViewFactory CreateLabelViewWithFont:_FONT(15) TextColor:_COLOR(0x21, 0x21, 0x21)];
        [self.bgview addSubview:self.lbTitle];
        self.lbTitle.translatesAutoresizingMaskIntoConstraints = YES;
        self.lbTitle.frame = CGRectMake(20, 20, ScreenWidth - 100, 20);
        self.lbTitle.text = @"红包详情";
        
        self.lbLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, ScreenWidth - 60, 0.5)];
        [self.bgview addSubview:self.lbLine];
        self.lbLine.backgroundColor = _COLOR(0xe6, 0xe6, 0xe6);
        
        self.logo = [[UIImageView alloc] initWithFrame:CGRectMake(44, 90, 24, 24)];
        [self.bgview addSubview:self.logo];
        self.logo.image = ThemeImage(@"bravo");
        
        self.lbShowInfo = [ViewFactory CreateLabelViewWithFont:_FONT(18) TextColor:_COLOR(0x21, 0x21, 0x21)];
        [self.bgview addSubview:self.lbShowInfo];
        self.lbShowInfo.translatesAutoresizingMaskIntoConstraints = YES;
        self.lbShowInfo.frame = CGRectMake(74, 90, ScreenWidth - 140, 24);
        self.lbShowInfo.text = @"恭喜！领取成功";
        
        self.lbDetail = [ViewFactory CreateLabelViewWithFont:_FONT(13) TextColor:_COLOR(0x75, 0x75, 0x75)];
        [self.bgview addSubview:self.lbDetail];
        self.lbDetail.translatesAutoresizingMaskIntoConstraints = YES;
        self.lbDetail.frame = CGRectMake(20, 130, ScreenWidth - 100, 20);
        self.lbDetail.text = @"请在收益统计中查看明细";
        self.lbDetail.textAlignment = NSTextAlignmentCenter;
        
        self.btnSubmit = [[UIButton alloc] initWithFrame:CGRectMake(16, 170, ScreenWidth - 92, 36)];
        [self.bgview addSubview:self.btnSubmit];
        self.btnSubmit.backgroundColor = _COLOR(0xff, 0x66, 0x19);
        self.btnSubmit.titleLabel.font = _FONT(15);
        [self.btnSubmit setTitle:@"朕知道了" forState:UIControlStateNormal];
        [self.btnSubmit addTarget:self action:@selector(hidden) forControlEvents:UIControlEventTouchUpInside];
        self.btnSubmit.layer.cornerRadius = 3;
    }
    
    return self;
}

- (void) show
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.hidden = NO;
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 1;
        self.frame = CGRectMake(0, 0, ScreenWidth, SCREEN_HEIGHT);
    }];
}

- (void) hidden
{
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
        alview.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

@end
