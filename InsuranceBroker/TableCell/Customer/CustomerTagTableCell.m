//
//  CustomTagTableCell.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/21.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "CustomerTagTableCell.h"
#import "define.h"

@implementation CustomerTagTableCell

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
