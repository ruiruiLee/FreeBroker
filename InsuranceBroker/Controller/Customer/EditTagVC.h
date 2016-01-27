//
//  EditTagVC.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/22.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "BaseViewController.h"
#import "CustomerPanEditView.h"
#import "TagObjectModel.h"

@interface EditTagVC : BaseViewController <CustomerPanEditViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollview;
@property (nonatomic, strong) IBOutlet UITextField *tfTagName;
@property (nonatomic, strong) IBOutlet UIButton *btnDelTag;
@property (nonatomic, strong) IBOutlet CustomerPanEditView *editView;


@property (nonatomic, strong) IBOutlet NSLayoutConstraint *conVConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *bgHConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *bgVConstraint;

@property (nonatomic, strong) TagObjectModel *labelModel;

@end
