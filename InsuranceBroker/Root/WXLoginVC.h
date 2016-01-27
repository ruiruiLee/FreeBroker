//
//  WXLoginVC.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/4.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseViewController.h"
#import "LeftImgButton.h"

@interface WXLoginVC : BaseViewController

@property (nonatomic, strong) IBOutlet LeftImgButton *btnWechat;
@property (nonatomic, strong) IBOutlet UILabel *lbAgreement;

@end
