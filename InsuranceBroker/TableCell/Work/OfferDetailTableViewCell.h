//
//  OfferDetailTableViewCell.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/2.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OfferDetailTableViewCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIImageView *photo;//
@property (nonatomic, strong) IBOutlet UILabel *lbName;//险种
@property (nonatomic, strong) IBOutlet UILabel *lbPrice;//保单价
@property (nonatomic, strong) IBOutlet UILabel *lbtruePrice;//折后价
@property (nonatomic, strong) IBOutlet UILabel *lbGain;//赚
@property (nonatomic, strong) IBOutlet UILabel *lbRebate;//折扣

@property (nonatomic, strong) IBOutlet UILabel *lbNoRebate;
@property (nonatomic, strong) IBOutlet UILabel *lbRebateTitle;

@property (nonatomic, strong) IBOutlet UIButton *btnAdd;
@property (nonatomic, strong) IBOutlet UIButton *btnReduce;

@end
