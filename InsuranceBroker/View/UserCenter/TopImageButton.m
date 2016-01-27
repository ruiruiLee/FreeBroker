//
//  TopImageButton.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/22.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "TopImageButton.h"

@implementation TopImageButton

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
//        self.clipsToBounds = YES;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
//        self.clipsToBounds = YES;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
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
    
    CGFloat h = (frame.size.height - imgvframe.size.height - 2 - titleframe.size.height)/2;
    if(titleframe.size.height == 0){
        NSString *string = @"阿迪风格";
        CGSize size = [string sizeWithFont:self.titleLabel.font];
        h = (frame.size.height - imgvframe.size.height - 2 - size.height)/2;
    }
    
    imgv.frame = CGRectMake((frame.size.width - imgvframe.size.width)/2, h, imgvframe.size.width, imgvframe.size.height);
    titlelabel.frame = CGRectMake(0, h + imgvframe.size.height + 2, frame.size.width, titleframe.size.height);
}


@end
