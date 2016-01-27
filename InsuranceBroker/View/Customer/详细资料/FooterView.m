//
//  FooterView.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/7.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "FooterView.h"
#import "define.h"

@implementation FooterView

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        
        self.backgroundColor = _COLOR(250, 250, 250);
        
        lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, frame.size.height)];
        lbTitle.backgroundColor = [UIColor clearColor];
        lbTitle.text = @"正在努力加载中...";
        lbTitle.textAlignment = NSTextAlignmentCenter;
        lbTitle.font = _FONT(12);
        [self addSubview:lbTitle];
        lbTitle.textColor = _COLOR(0x75, 0x75, 0x75);
        
        _loadingview =[[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(20, 5, 40, frame.size.height - 10)];
        [self addSubview:_loadingview];
        _loadingview.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
        _loadingview.hidesWhenStopped = NO;
        [_loadingview startAnimating];

        lbTitle.hidden = YES;
        
        _loadbtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 4, frame.size.width - 20, frame.size.height - 8)];
        [self addSubview:_loadbtn];
        [_loadbtn setTitle:@"加载更多" forState:UIControlStateNormal];
        _loadbtn.backgroundColor = _COLOR(0xff, 0x66, 0x19);
        _loadbtn.titleLabel.font = _FONT(15);
        [_loadbtn addTarget:self action:@selector(loadbtclick) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)loadbtclick {
     NSLog(@"按钮被点击了");
     //隐藏按钮
     self.loadbtn.hidden=YES;
     //显示菊花
     lbTitle.hidden = NO;
     _loadingview.hidden = NO;
    
    if(_delegate && [_delegate respondsToSelector:@selector(NotifyToLoadMore:)]){
        [_delegate NotifyToLoadMore:self];
    }
 }

- (void) startLoading
{
    
}

- (void) endLoading
{
    lbTitle.hidden = YES;
    self.loadbtn.hidden = NO;
    _loadingview.hidden = YES;
//    [_loadingview stopAnimating];
}

@end
