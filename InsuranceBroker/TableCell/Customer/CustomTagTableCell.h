//
//  CustomTagTableCell.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/15.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTagTableCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *photoImage;
@property (nonatomic, strong) IBOutlet UILabel *lbTitle;
@property (nonatomic, strong) IBOutlet UILabel *lbCount;

@end
