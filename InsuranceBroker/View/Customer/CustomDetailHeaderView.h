//
//  CustomDetailHeaderView.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/21.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubView.h"

@class CustomDetailHeaderView;

@protocol CustomDetailHeaderViewDelegate <NSObject>

- (void) NotifyToEditUserInfo:(CustomDetailHeaderView*) sender;

@end

@interface CustomDetailHeaderView : SubView

@property (nonatomic, strong) IBOutlet UIImageView *photoImageV;//头像
@property (nonatomic, strong) IBOutlet UILabel *lbName;
@property (nonatomic, strong) IBOutlet UILabel *lbMobile;
@property (nonatomic, strong) IBOutlet UILabel *lbTag;
@property (nonatomic, strong) IBOutlet UILabel *lbSepLine1;
@property (nonatomic, strong) IBOutlet UILabel *lbSepLine2;
@property (nonatomic, strong) IBOutlet UIButton *btnEditUser;
@property (nonatomic, strong) IBOutlet UIButton *btnPhone;
@property (nonatomic, strong) IBOutlet UIButton *btnMsg;

@property (nonatomic, weak) id<CustomDetailHeaderViewDelegate> delegate;

- (IBAction)EditUserInfo:(id)sender;
- (IBAction)PhoneUser:(id)sender;
- (IBAction)SendMsgToUser:(id)sender;

@end
