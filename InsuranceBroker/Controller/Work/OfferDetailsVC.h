//
//  OfferDetailsVC.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/2.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseViewController.h"
#import "LeftImgButton.h"

@interface OfferDetailsVC : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *viewHConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *tableVConstraint;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *btnNameHConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *btnNoHConstraint;

@property (nonatomic, strong) IBOutlet UILabel *lbIdenCode;//编号
@property (nonatomic, strong) IBOutlet LeftImgButton *btnName;//姓名
@property (nonatomic, strong) IBOutlet LeftImgButton *btnNo;//车牌号
@property (nonatomic, strong) IBOutlet UILabel *lbPlan;//方案
@property (nonatomic, strong) IBOutlet UILabel *lbTime;//发起时间
@property (nonatomic, strong) IBOutlet UITableView *tableview;
@property (nonatomic, strong) IBOutlet UILabel *lbWarning;

@property (nonatomic, strong) IBOutlet UIScrollView *scrollview;

@property (nonatomic, strong) IBOutlet NSString *orderId;

@end
