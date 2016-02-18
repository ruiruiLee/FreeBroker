//
//  LucyMoneyTableCell.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/22.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "LucyMoneyTableCell.h"
#import "define.h"

@implementation LucyMoneyTableCell

- (void)awakeFromNib {
    // Initialization code
//    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.btnReceive.layer.cornerRadius = 3;
    self.lbExplain.textColor = Subhead_Color;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) layoutSubviews
{
    [super layoutSubviews];
}

@end
