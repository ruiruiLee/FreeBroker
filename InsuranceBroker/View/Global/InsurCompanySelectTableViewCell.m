//
//  InsurCompanySelectTableViewCell.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/14.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "InsurCompanySelectTableViewCell.h"
#import "define.h"

@implementation InsurCompanySelectTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.imageView.layer.borderWidth = 0.5;
    self.imageView.layer.borderColor = _COLOR(0xe6, 0xe6, 0xe6).CGColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews

{
    
    [super layoutSubviews];
    
    [self.imageView setFrame:CGRectMake(10, 10, 40, 40)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    CGRect frame = self.textLabel.frame;
    self.textLabel.frame = CGRectMake(60, frame.origin.y, frame.size.width + 20, frame.size.height);
    
}

@end
