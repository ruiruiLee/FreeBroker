//
//  PolicyInfoTableViewCell.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/24.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftImgButtonLeft.h"

@interface PolicyInfoTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *lbNo;//编号
@property (nonatomic, strong) IBOutlet UILabel *lbUpdateTime;
@property (nonatomic, strong) IBOutlet UIView *contentBg;
@property (nonatomic, strong) IBOutlet UIImageView *logoImgV;
@property (nonatomic, strong) IBOutlet UILabel *lbName;
@property (nonatomic, strong) IBOutlet UILabel *lbPlate;
@property (nonatomic, strong) IBOutlet LeftImgButtonLeft *btnStatus;
@property (nonatomic, strong) IBOutlet UILabel *lbContent;
@property (nonatomic, strong) IBOutlet UILabel *lbStatus;


@end
