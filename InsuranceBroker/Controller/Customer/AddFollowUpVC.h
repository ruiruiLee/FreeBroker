//
//  AddFollowUpVC.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/25.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "BaseViewController.h"
#import "VisitInfoModel.h"
//#import "CustomerDetailModel.h"
#import "CustomerInfoModel.h"
#import "PlaceholderTextView.h"

@interface AddFollowUpVC : BaseViewController

@property (nonatomic, strong) IBOutlet PlaceholderTextView *tfview;
@property (nonatomic, strong) IBOutlet UITextField *tfStatus;
@property (nonatomic, strong) IBOutlet UITextField *tfWay;
@property (nonatomic, strong) IBOutlet UITextField *tfTIme;
@property (nonatomic, strong) IBOutlet PlaceholderTextView *tfAdd;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *addVConstraint;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *viewHConstraint;
@property (nonatomic, strong) CustomerInfoModel *customerModel;
@property (nonatomic, strong) VisitInfoModel *visitModel;
@property (nonatomic, strong) NSString *customerId;

- (IBAction) addFollowDate:(id) sender;

@end
