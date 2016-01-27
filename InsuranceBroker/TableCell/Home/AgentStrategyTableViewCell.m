//
//  AgentStrategyTableViewCell.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/12.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "AgentStrategyTableViewCell.h"
#import "define.h"

@implementation AgentStrategyTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.photoImgV.layer.borderWidth = 0.4;
    self.photoImgV.layer.borderColor = _COLOR(0xe6, 0xe6, 0xe6).CGColor;
    self.lbContent.preferredMaxLayoutWidth = ScreenWidth - 20 - 20 - 20 - 70;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
