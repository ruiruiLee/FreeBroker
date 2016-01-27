//
//  MenuCell.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/25.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "MenuCell.h"

@implementation MenuCell

- (void)awakeFromNib {
    // Initialization code
    
    self.btnSelect.tintColor = [UIColor clearColor];
    self.btnSelect.userInteractionEnabled = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setItemSelected:(BOOL) flag
{
    if(flag)
        self.btnSelect.selected = YES;
    else
        self.btnSelect.selected = NO;
}

@end
