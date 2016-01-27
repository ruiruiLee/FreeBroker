//
//  CustomerFollowUpTableCell.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/25.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomerFollowUpTableCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *logoImgV;
@property (nonatomic, strong) IBOutlet UILabel *lbSchedule;
@property (nonatomic, strong) IBOutlet UILabel *lbTime;
@property (nonatomic, strong) IBOutlet UILabel *lbContent;
@property (nonatomic, strong) IBOutlet UILabel *lbAddress;

@end
