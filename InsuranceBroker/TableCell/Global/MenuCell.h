//
//  MenuCell.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/25.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UIButton *btnSelect;
@property (nonatomic, strong) IBOutlet UILabel *lbTitle;

- (void) setItemSelected:(BOOL) flag;

@end
