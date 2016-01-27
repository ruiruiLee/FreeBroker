//
//  CustomerTableViewCell.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/21.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *photoImage;
@property (nonatomic, strong) IBOutlet UIImageView *logoImage;
@property (nonatomic, strong) IBOutlet UILabel *lbName;
@property (nonatomic, strong) IBOutlet UILabel *lbStatus;
@property (nonatomic, strong) IBOutlet UILabel *lbTimr;
@property (nonatomic, strong) IBOutlet UIButton *btnApply;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *width;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *height;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *timerWidth;

@end
