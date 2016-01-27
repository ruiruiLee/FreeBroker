//
//  NoticeListTableViewCell.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/29.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoticeListTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *photoLogo;
@property (nonatomic, strong) IBOutlet UILabel *lbTitle;
@property (nonatomic, strong) IBOutlet UILabel *lbContent;
@property (nonatomic, strong) IBOutlet UILabel *lbTime;

@end
