//
//  TagButton.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/23.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "TagButton.h"
#import "define.h"

@implementation TagButton
@synthesize tagType;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.clipsToBounds = YES;
        self.tagType = enumTagButtonNormal;
        [self initSubViews];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.clipsToBounds = YES;
        self.tagType = enumTagButtonNormal;
        [self initSubViews];
    }
    
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    UIImage *image = ThemeImage(@"tag_del");
    CGRect titleFrame = self.titleLabel.frame;
    delImag.frame = CGRectMake(titleFrame.origin.x + titleFrame.size.width + 2, titleFrame.origin.y + titleFrame.size.height / 2 - image.size.height/2 , image.size.width, image.size.height);
}

- (void) initSubViews
{
    delImag = [[UIImageView alloc] initWithImage:ThemeImage(@"tag_del")];
    delImag.hidden = YES;
//    delImag.alpha = 0;
    [self addSubview:delImag];
    delImag.clipsToBounds = YES;
}

- (void) setTagType:(TagButtonType)type
{
    CGRect oFrame = self.frame;
    CGRect titleFrame = self.titleLabel.frame;
    
    if (type == enumTagButtonDel) {
        
        delImag.hidden = NO;
        self.backgroundColor = _COLOR(0xff, 0x66, 0x19);
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.25 animations:^{
            UIImage *image = ThemeImage(@"tag_del");
            self.frame = CGRectMake(oFrame.origin.x, oFrame.origin.y, oFrame.size.width + image.size.width + 5, oFrame.size.height);
            delImag.frame = CGRectMake(titleFrame.origin.x + titleFrame.size.width + 2, titleFrame.origin.y + titleFrame.size.height / 2 - image.size.height/2 , image.size.width, image.size.height);
        } completion:^(BOOL finished) {
            delImag.hidden = NO;
        }];
    }else{
        self.backgroundColor = [UIColor clearColor];
        [UIView animateWithDuration:0.25 animations:^{
            self.frame = CGRectMake(oFrame.origin.x, oFrame.origin.y, oFrame.size.width - delImag.frame.size.width, oFrame.size.height);
            UIImage *image = ThemeImage(@"tag_del");
            delImag.frame = CGRectMake(titleFrame.origin.x + titleFrame.size.width + 2, titleFrame.origin.y + titleFrame.size.height / 2 - image.size.height/2 , 0, 0);
        } completion:^(BOOL finished) {
            delImag.hidden = YES;
        }];
    }
    
    tagType = type;
}

@end
