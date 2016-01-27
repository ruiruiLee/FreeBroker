//
//  MainFunctionButton.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/18.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "MainFunctionButton.h"
#import "define.h"

@implementation MainFunctionButton
@synthesize lbExplain;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.clipsToBounds = YES;
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        lbExplain = [ViewFactory CreateLabelViewWithFont:_FONT(12) TextColor:_COLOR(0x75, 0x75, 0x75)];
        [self addSubview:lbExplain];
        lbExplain.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if(self){
        
        self.clipsToBounds = YES;
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        lbExplain = [ViewFactory CreateLabelViewWithFont:_FONT(12) TextColor:_COLOR(0x75, 0x75, 0x75)];
        [self addSubview:lbExplain];
        lbExplain.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    CGRect frame = self.frame;
    
    UIImageView *imgv = self.imageView;
    CGRect imgvframe = imgv.frame;
    
    UILabel *titlelabel = self.titleLabel;
    CGRect titleframe = titlelabel.frame;
    
    CGFloat h = (frame.size.height - imgvframe.size.height - 10 - titleframe.size.height - 6 - 14)/2;
    
    imgv.frame = CGRectMake((frame.size.width - imgvframe.size.width)/2, h, imgvframe.size.width, imgvframe.size.height);
    titlelabel.frame = CGRectMake(0, h + imgvframe.size.height + 10, frame.size.width, titleframe.size.height);
    lbExplain.frame = CGRectMake(0, h + imgvframe.size.height + 16 + titleframe.size.height, frame.size.width, 14);
    
}

@end
