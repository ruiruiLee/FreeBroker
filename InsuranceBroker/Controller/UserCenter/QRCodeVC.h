//
//  QRCodeVC.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/29.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "BaseViewController.h"

@interface QRCodeVC : BaseViewController

@property (nonatomic, strong) IBOutlet UIImageView *photoImg;
@property (nonatomic, strong) IBOutlet UILabel *lbName;
@property (nonatomic, strong) IBOutlet UILabel *lbAdd;
@property (nonatomic, strong) IBOutlet UIImageView *imgQR;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *viewHConstraint;

@end
