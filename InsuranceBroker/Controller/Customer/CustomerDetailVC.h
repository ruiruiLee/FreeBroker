//
//  CustomerDetailVC.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/21.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomDetailHeaderView.h"
#import "InsuranceInfoView.h"
#import "UserPolicyListView.h"
#import "InsuranceDetailView.h"
#import "CustomerFollowUpInfoView.h"

#import "CustomerInfoModel.h"

@interface CustomerDetailVC : BaseViewController<CustomDetailHeaderViewDelegate>
{
    InsuranceInfoView *_insuranceView;
    UserPolicyListView *_policyListView;
    CustomerFollowUpInfoView *_followUpView;
    InsuranceDetailView *_insuranceDetailView;
    
    BaseInsuranceInfo *_selectedView;
}

@property (nonatomic, strong) IBOutlet UIScrollView *scrollview;
@property (nonatomic, strong) IBOutlet CustomDetailHeaderView *headerView;
@property (nonatomic, strong) IBOutlet UIButton *btnInfo;//投保资料
@property (nonatomic, strong) IBOutlet UIButton *btnSituation;//客户跟进
@property (nonatomic, strong) IBOutlet UIButton *btnOrderInfo;//订单信息
@property (nonatomic, strong) IBOutlet UILabel *lbFocusLine;//状态条
@property (nonatomic, strong) IBOutlet UIView *detailView;//详情

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *headerVConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *headerHConstraint;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *viewVConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *detailVConstraint;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *scrollOffsetConstraint;//scrollview离底部的距离

@property (nonatomic, strong) UIButton *btnQuote;//立即报价
@property (nonatomic, strong) CustomerInfoModel *customerinfoModel;;

- (void) loadDetailWithCustomerId:(NSString *)customerId;

- (IBAction) doBtnRing:(UIButton *)sender;
- (IBAction) doBtnEmail:(UIButton *)sender;

@end
