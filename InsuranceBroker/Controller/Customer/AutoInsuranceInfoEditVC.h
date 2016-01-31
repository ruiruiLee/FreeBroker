//
//  AutoInsuranceInfoEditVC.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/26.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "BaseViewController.h"
#import "BaseLineTextField.h"
#import "CustomerDetailModel.h"
#import "LeftImgButton.h"

@interface AutoInsuranceInfoEditVC : BaseViewController<UITableViewDataSource, UITableViewDelegate>
{
    UILabel *_lbProvience;
}


@property (nonatomic, strong) IBOutlet NSLayoutConstraint *viewHConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *baseViewVConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *tableVConstraint;

@property (nonatomic, strong) IBOutlet UITableView *tableview;
@property (nonatomic, strong) IBOutlet BaseLineTextField *tfName;//车主姓名
@property (nonatomic, strong) IBOutlet BaseLineTextField *tfCert;//身份证号码
@property (nonatomic, strong) IBOutlet BaseLineTextField *tfNo;//车牌号
@property (nonatomic, strong) IBOutlet UILabel *lbDateTitle;
@property (nonatomic, strong) IBOutlet BaseLineTextField *tfDate;//登记日期
@property (nonatomic, strong) IBOutlet BaseLineTextField *tfModel;//品牌型号
@property (nonatomic, strong) IBOutlet BaseLineTextField *tfIdenCode;//识别码
@property (nonatomic, strong) IBOutlet BaseLineTextField *tfMotorCode;//发动机号
@property (nonatomic, strong) IBOutlet UIView *licenseView;//基本信息
@property (nonatomic, strong) IBOutlet UIImageView *imgLicense;//照片
@property (nonatomic, strong) IBOutlet UIButton *btnReSubmit;//重新上传
@property (nonatomic, strong) IBOutlet UIView *contenView;//基本信息

@property (nonatomic, strong) IBOutlet LeftImgButton *btnNoNo;//新车未上牌

@property (nonatomic, strong) UIButton *btnQuote;//立即报价
@property (nonatomic, strong) UILabel *lbAttribute;

@property (nonatomic, strong) CustomerDetailModel *customerModel;
@property (nonatomic, strong) NSString *customerId;

- (IBAction)doButtonEditNo:(UIButton *)sender;
- (IBAction)doButtonHowToWrite:(UIButton *)sender;


@end
