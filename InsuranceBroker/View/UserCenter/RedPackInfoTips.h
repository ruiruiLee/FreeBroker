//
//  RedPackInfoTips.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RedPackInfoTips : UIView
{
    UIView *alview;
}

@property (nonatomic, strong) UIView *alview;
@property (nonatomic, strong) UIView *bgview;
@property (nonatomic, strong) UILabel *lbTitle;
@property (nonatomic, strong) UILabel *lbLine;
@property (nonatomic, strong) UIImageView *logo;
@property (nonatomic, strong) UILabel *lbShowInfo;
@property (nonatomic, strong) UILabel *lbDetail;
@property (nonatomic, strong) UIButton *btnSubmit;

- (void) show;
- (void) hidden;

@end
