//
//  OfferDetailTableViewCell.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/2.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "OfferDetailTableViewCell.h"
#import "define.h"

@implementation OfferDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.photo.image = ThemeImage(@"chexian");
    self.btnAdd.layer.cornerRadius = 3;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
