//
//  CustomDetailHeaderView.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/21.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "CustomDetailHeaderView.h"
#import "define.h"

@implementation CustomDetailHeaderView
@synthesize delegate;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.clipsToBounds = YES;
        
        if (nil != self) {
            self.photoImageV = [self.contentView viewWithTag:1001];
            self.lbName = [self.contentView viewWithTag:1002];
            self.lbMobile = [self.contentView viewWithTag:1003];
            self.lbTag = [self.contentView viewWithTag:1004];
            self.lbSepLine1 = [self.contentView viewWithTag:1005];
            self.lbSepLine2 = [self.contentView viewWithTag:1006];
            self.btnEditUser = [self.contentView viewWithTag:1007];
            self.btnPhone = [self.contentView viewWithTag:1008];
            self.btnMsg = [self.contentView viewWithTag:1009];
            
            [self.btnEditUser addTarget:self action:@selector(EditUserInfo:) forControlEvents:UIControlEventTouchUpInside];
            [self.btnPhone addTarget:self action:@selector(PhoneUser:) forControlEvents:UIControlEventTouchUpInside];
            [self.btnMsg addTarget:self action:@selector(SendMsgToUser:) forControlEvents:UIControlEventTouchUpInside];
            
            self.lbSepLine1.backgroundColor = _COLOR(222, 222, 222);
            self.lbSepLine2.backgroundColor = _COLOR(222, 222, 222);
        }
    }
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    
    self.lbSepLine1.layer.borderWidth = 0.25;
    self.lbSepLine1.layer.borderColor = [UIColor clearColor].CGColor;
    self.lbSepLine2.layer.borderWidth = 0.25;
    self.lbSepLine2.layer.borderColor = [UIColor clearColor].CGColor;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
}

- (IBAction)EditUserInfo:(id)sender
{
    if(delegate && [delegate respondsToSelector:@selector(NotifyToEditUserInfo:)]){
        [delegate NotifyToEditUserInfo:self];
    }
}

- (IBAction)PhoneUser:(id)sender
{
    
}

- (IBAction)SendMsgToUser:(id)sender
{
    
}

@end
