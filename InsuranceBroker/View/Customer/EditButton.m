//
//  EditButton.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/8.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "EditButton.h"
#import "define.h"

@implementation EditButton
@synthesize delFlag;

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        delFlag = [[UIImageView alloc] initWithImage:ThemeImage(@"del_red")];
        [self addSubview:delFlag];
        delFlag.backgroundColor = [UIColor clearColor];
        
        self.editType = enumEditTypeNormal;
    }
    
    return self;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    UIImageView *imgv = self.imageView;
    CGRect imgvframe = imgv.frame;
    
    CGRect delFrame = delFlag.frame;
    delFlag.frame = CGRectMake(imgvframe.origin.x - delFrame.size.width / 2, imgvframe.origin.y - delFrame.size.height / 2 + 2, delFrame.size.width, delFrame.size.height);
}

- (void) setEditType:(enumEditType)type
{
    _editType = type;
    if(_editType == enumEditTypeDel){
        self.delFlag.hidden = NO;
    }
    else{
        self.delFlag.hidden = YES;
    }
}

@end
