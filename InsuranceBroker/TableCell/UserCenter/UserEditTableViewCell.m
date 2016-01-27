//
//  UserEditTableViewCell.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/29.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "UserEditTableViewCell.h"

@implementation UserEditTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.imgv.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
