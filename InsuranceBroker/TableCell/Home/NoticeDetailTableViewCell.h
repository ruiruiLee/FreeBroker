//
//  NoticeDetailTableViewCell.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/30.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *lbTitle;
@property (nonatomic, strong) IBOutlet UIImageView *photoImgV;
@property (nonatomic, strong) IBOutlet UILabel *lbContent;
@property (nonatomic, strong) IBOutlet UIButton *btnDetail;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *imgVConstraint;

@end
