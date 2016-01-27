//
//  CustomerInfoEditVC.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/23.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "BaseViewController.h"
#import "TagListView.h"
#import "OnwerTagView.h"
#import "CustomerDetailModel.h"

@interface CustomerInfoEditVC : BaseViewController<TagListViewDelegate, OnwerTagViewDelegate, UITextFieldDelegate>

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *viewHConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *tagVConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *myTagVConstraint;

@property (nonatomic, strong) IBOutlet UITextField *tfName;
@property (nonatomic, strong) IBOutlet UITextField *tfMobile;
@property (nonatomic, strong) IBOutlet TagListView *tagView;
@property (nonatomic, strong) IBOutlet OnwerTagView *onwerTag;

@property (nonatomic, strong) CustomerDetailModel *data;

- (BOOL) isHasModify;
- (NSArray *) tagModelArrayFromIdAndName;
- (void) updateOrAddLabelInfo;


@end
