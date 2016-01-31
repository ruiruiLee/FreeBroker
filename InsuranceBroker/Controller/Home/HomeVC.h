//
//  HomeVC.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/18.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "BaseViewController.h"
#import "HeadlineView.h"
#import "MainFunctionButton.h"
#import "LeftImgButton.h"
#import "AdScrollView.h"
#import "NewUserModel.h"

@interface HomeVC : BaseViewController<HeadlineViewDelegate>
{
//    NSArray *data;
    
//    LeftImgButton *_btnRaider;//攻略
//    LeftImgButton *_btnService;//客服
//    LeftImgButton *_btnMessage;//消息
    
    //ad
    NSArray *_adArray;
    //headline
    NSArray *_headlineArray;
    //newuser
    NewUserModel *_newUserModel;
}

@property (nonatomic, strong) IBOutlet UIScrollView *scrollview;

@property (nonatomic, strong) IBOutlet HeadlineView *headline;
@property (nonatomic, strong) IBOutlet AdScrollView *adView;

@property (nonatomic, strong) IBOutlet MainFunctionButton *btnAutoInsu;//车险
@property (nonatomic, strong) IBOutlet MainFunctionButton *btnInvit;//邀请

//间隔线宽
@property (nonatomic, strong) IBOutlet UILabel *lbsepline1;
@property (nonatomic, strong) IBOutlet UILabel *lbsepline2;//

//底部图片跳转页面
@property (nonatomic, strong) IBOutlet UIButton *btnNewUser;

//NSLayoutConstraint
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *scHConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *scVConstraint;
//广告
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *adVConstraint;
//@property (nonatomic, strong) IBOutlet NSLayoutConstraint *adHConstraint;
//头条
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *headVConstraint;
//@property (nonatomic, strong) IBOutlet NSLayoutConstraint *headHConstraint;
//车险
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *autoBgVConstraint;
//@property (nonatomic, strong) IBOutlet NSLayoutConstraint *autoBgHConstraint;//
//销售攻略背景
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *additionBgVConstraint;
//@property (nonatomic, strong) IBOutlet NSLayoutConstraint *additionBgHConstraint;//
//新用户
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *userNewVConstraint;
//@property (nonatomic, strong) IBOutlet NSLayoutConstraint *userNewHConstraint;//

@property (nonatomic, strong) IBOutlet LeftImgButton *_btnMessage;//消息

//我的消息
- (IBAction) doBtnNoticeList:(id) sender;
- (IBAction) doBtnAgentStrategy:(id)sender;
- (IBAction) doBtnMyService:(id)sender;

@end
