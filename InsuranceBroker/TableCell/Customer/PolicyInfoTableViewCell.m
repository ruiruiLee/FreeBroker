//
//  PolicyInfoTableViewCell.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/24.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "PolicyInfoTableViewCell.h"
#import "define.h"

@implementation PolicyInfoTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.logoImgV.image = ThemeImage(@"chexian");
    self.contentBg.layer.borderWidth = 0.5;
    self.contentBg.layer.borderColor = _COLOR(0xe6, 0xe6, 0xe6).CGColor;
    self.logoImgV.layer.borderWidth = 0.5;
    self.logoImgV.layer.borderColor = _COLOR(0xe6, 0xe6, 0xe6).CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
