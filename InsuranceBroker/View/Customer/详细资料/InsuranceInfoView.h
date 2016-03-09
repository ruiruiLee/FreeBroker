//
//  InsuranceInfoView.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/24.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    enumInsuranceInfoViewTypeInsurance,
    enumInsuranceInfoViewTypeFollowUp,
    enumInsuranceInfoViewTypePolicy,
} InsuranceInfoViewType;

@class InsuranceInfoView;
@protocol InsuranceInfoViewDelegate <NSObject>

- (void) NotifyAddButtonClicked:(InsuranceInfoView *) sender type:(InsuranceInfoViewType) type;//处理添加按钮点击事件

@end

@interface InsuranceInfoView : UIView 

@property (nonatomic, strong) IBOutlet UIView *addCarInfo;
@property (nonatomic, strong) IBOutlet UIButton *btnAdd;
@property (nonatomic, strong) IBOutlet UILabel *lbExplain;
@property (nonatomic, strong) IBOutlet UILabel *lbTitle;
@property (nonatomic, strong) IBOutlet UILabel *lbSepLine;
@property (nonatomic, strong) IBOutlet UIActivityIndicatorView *indicatorView;

@property (nonatomic, weak) id<InsuranceInfoViewDelegate> delegate;

@property (nonatomic, assign) InsuranceInfoViewType type;


//+ (id) loadFromNib;

- (IBAction) handleAddButtonClicked:(UIButton *)sender;

- (void) startAnimation;
- (void) endAnimation;

@end
