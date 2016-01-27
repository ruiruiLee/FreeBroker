//
//  CustomTagTableCell.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/15.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "CustomTagTableCell.h"
#import "define.h"

@implementation CustomTagTableCell

- (void)awakeFromNib {
    // Initialization code
    self.lbTitle.textColor = _COLOR(0x21, 0x21, 0x21);
    self.lbCount.layer.cornerRadius = 10;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
