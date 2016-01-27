//
//  LucyMoneyTableCell.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/22.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LucyMoneyTableCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *logoImgV;
@property (nonatomic, strong) IBOutlet UILabel *lbTitle;
@property (nonatomic, strong) IBOutlet UILabel *lbExplain;
@property (nonatomic, strong) IBOutlet UILabel *lbAmount;
@property (nonatomic, strong) IBOutlet UIButton *btnReceive;

@end
