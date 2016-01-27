//
//  AppInfoView.m
//  SpringCare
//
//  Created by LiuZach on 15/10/27.
//  Copyright © 2015年 cmkj. All rights reserved.
//

#import "AppInfoView.h"
#import "define.h"

@implementation AppInfoView

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        _logo = [[UIImageView alloc] initWithFrame:CGRectMake(10, 0, 60, 60)];
        [self addSubview:_logo];
        _logo.clipsToBounds = YES;
        _logo.userInteractionEnabled = NO;
        
        
        _lbName = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 80, 15)];
        _lbName.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_lbName];
        _lbName.backgroundColor = [UIColor clearColor];
        _lbName.textColor = _COLOR(0x21, 0x21, 0x21);
        _lbName.font = _FONT(15);
        
    }
    
    return self;
}

@end
