//
//  UserPolicyListView.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/24.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "InsuranceInfoView.h"

@class BaseInsuranceInfo;

@protocol BaseInsuranceInfoDelegate <NSObject>

- (void) NotifyAddFollowUpInfo:(BaseInsuranceInfo *) sender;//添加客户跟进信息
- (void) NotifyHandleFollowUpClicked:(BaseInsuranceInfo *)sender idx:(NSInteger) idx;
- (void) NotifyToLoadMoreFollowUp:(BaseInsuranceInfo *)sender;
- (void) NotifyModifyInsuranceInfo:(BaseInsuranceInfo *) sender;//编辑投保资料
- (void) NotifyHandlePolicyClicked:(BaseInsuranceInfo *)sender idx:(NSInteger) idx;//处理保单列表点击
- (void) NotifyToLoadMorePloicy:(BaseInsuranceInfo *)sender;

- (void) NotifyHandleItemDelegateClicked:(BaseInsuranceInfo *)sender model:(id) model;//处理保单列表点击

@end

@interface BaseInsuranceInfo : UIView <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, strong)  UITableView *tableview;
@property (nonatomic, strong)  UILabel *lbTitle;
@property (nonatomic, strong)  UILabel *lbSepLine;
@property (nonatomic, strong)  UIButton *btnEdit;

@property (nonatomic, weak) id<BaseInsuranceInfoDelegate> delegate;

- (CGFloat) resetSubviewsFrame;

- (void) doEditButtonClicked:(UIButton *)sender;

@end
