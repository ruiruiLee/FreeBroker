//
//  UserNameEditButton.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/2.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "UserNameEditButton.h"
#import "define.h"

#define sep 10

@implementation UserNameEditButton

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        imagv1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
        [self addSubview:imagv1];
        imagv1.image = ThemeImage(@"QR_code");
        
        imagv2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 9, 16)];
        [self addSubview:imagv2];
        imagv2.image = ThemeImage(@"name_arrow");
    }
    
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self reset];
}

- (void) reset
{
    CGRect frame = self.titleLabel.frame;
    UILabel *lb = self.titleLabel;
    CGFloat height = self.frame.size.height;
    
    CGFloat ox = (ScreenWidth - (sep * 2 + frame.size.width + 16 + 9))/2;
    
    lb.frame = CGRectMake(ox, frame.origin.y, frame.size.width, frame.size.height);
    imagv1.frame = CGRectMake(ox + sep + frame.size.width, (height - 16) /2, 16, 16);
    imagv2.frame = CGRectMake(ox + 16 + sep * 2 + frame.size.width, (height - 16)/2, 9, 16);
}

- (void) setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self reset];
}

@end
