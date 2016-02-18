//
//  AutoInsuranceInfoEditVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/26.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "AutoInsuranceInfoEditVC.h"
#import "define.h"
#import "NetWorkHandler+saveOrUpdateCustomerCar.h"
#import <AVOSCloud/AVOSCloud.h>
#import "PhotoBrowserView.h"
#import "InsurCompanySelectVC.h"
#import "NetWorkHandler+queryForInsuranceCompanyList.h"
#import "NetWorkHandler+queryForCustomerCarInfo.h"
#import "InsuranceCompanyModel.h"
#import "CarAddInfoTableCell.h"
#import "ZHPickView.h"
#import "DictModel.h"
#import "UIImageView+WebCache.h"
#import "OrderWebVC.h"
#import "SJAvatarBrowser.h"

@interface AutoInsuranceInfoEditVC ()<MenuDelegate, ZHPickViewDelegate, UITextFieldDelegate>
{
    NSInteger _perInsurCompany;
    NSArray *_insurCompanyArray;
    
    NSInteger _changeNameIdx;
    NSMutableArray *_changeNameArray;
    
    NSDate *_changNameDate;
    NSDate *_signDate;
    
    ZHPickView *_datePicker;
    ZHPickView *_datePicker1;
    
    BOOL isCertModify;
}

@property (nonatomic,strong) PhotoBrowserView *photoBrowserView;
@property (nonatomic, strong) InsurCompanySelectVC *menuView;
@property (nonatomic, strong) MenuViewController *menu;

@end

@implementation AutoInsuranceInfoEditVC
@synthesize tableview;
@synthesize btnQuote;
@synthesize lbAttribute;

- (void) handleLeftBarButtonClicked:(id)sender
{
    [self.tfNo resignFirstResponder];
    [self.tfName resignFirstResponder];
    [self.tfMotorCode resignFirstResponder];
    [self.tfModel resignFirstResponder];
    [self.tfIdenCode resignFirstResponder];
    [self.tfDate resignFirstResponder];
    [self.tfCert resignFirstResponder];
    
    if(_datePicker){
        [_datePicker remove];
    }
    if(_datePicker1){
        [_datePicker1 remove];
    }
    
    BOOL flag = [self isModify];
    if(flag){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"确认放弃保存修改资料吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        [alert show];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        _perInsurCompany = -1;
        _changeNameIdx = 0;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self loadInsurCompany];
    
    isCertModify = NO;
    
    [self.tfName addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.tfNo addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.tfMotorCode addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.tfModel addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.tfIdenCode addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.tfDate addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
    [self.tfCert addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
    
//    _changeNameArray = @[@"否", @"是"];
    _changeNameArray = [[NSMutableArray alloc] init];
    DictModel *model = [[DictModel alloc] init];
    model.dictName = @"否";
    [_changeNameArray addObject:model];
    
    DictModel *model1 = [[DictModel alloc] init];
    model1.dictName = @"是";
    [_changeNameArray addObject:model1];
    
    
    self.title = @"车险信息";
    [self SetRightBarButtonWithTitle:@"保存" color:_COLORa(0xff, 0x66, 0x19, 0.5) action:NO];
    
    lbAttribute = [[UILabel alloc] init];
    lbAttribute.translatesAutoresizingMaskIntoConstraints = NO;
    lbAttribute.backgroundColor = [UIColor clearColor];
    lbAttribute.font = _FONT(11);
    lbAttribute.textColor = _COLOR(0xcc, 0xcc, 0xcc);
    [self.contenView addSubview:lbAttribute];
    lbAttribute.numberOfLines = 2;
    lbAttribute.attributedText = [self getAttbuteString];
    lbAttribute.userInteractionEnabled = YES;
    
    self.tfDate.delegate = self;
    self.tfCert.delegate = self;
    self.tfIdenCode.delegate = self;
    self.tfModel.delegate = self;
    self.tfMotorCode.delegate = self;
    self.tfName.delegate = self;
    self.tfNo.delegate = self;
    
    _lbProvience = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 16, 36)];
    _lbProvience.backgroundColor = [UIColor clearColor];
    _lbProvience.font = _FONT(15);
    _lbProvience.textColor = _COLOR(0x21, 0x21, 0x21);
    _lbProvience.text = @"川";
    self.tfNo.leftView = _lbProvience;
    self.tfNo.leftViewMode = UITextFieldViewModeAlways;
    
    [self.tableview registerNib:[UINib nibWithNibName:@"CarAddInfoTableCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self.btnReSubmit setTitle:@"上传照片" forState:UIControlStateNormal];
    [self.btnReSubmit addTarget:self action:@selector(btnPhotoPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectZero];
    btn.translatesAutoresizingMaskIntoConstraints = NO;
    [lbAttribute addSubview:btn];
    btn.backgroundColor = [UIColor clearColor];
    [btn addTarget:self action:@selector(doBtnShowLicenseView:) forControlEvents:UIControlEventTouchUpInside];
    
    [lbAttribute addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-120-[btn]-80-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btn)]];
    [lbAttribute addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[btn]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(btn)]];
    
    [self.contenView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[lbAttribute]-20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lbAttribute)]];
    [self.contenView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-336-[lbAttribute]->=20-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(lbAttribute)]];
    
    btnQuote = [[UIButton alloc] init];
    [self.view addSubview:btnQuote];
    [btnQuote setTitle:@"立即\n报价" forState:UIControlStateNormal];
    btnQuote.translatesAutoresizingMaskIntoConstraints = NO;
    btnQuote.layer.cornerRadius = 24;
    btnQuote.backgroundColor = _COLOR(0xff, 0x66, 0x19);
    btnQuote.titleLabel.font = _FONT_B(14);
    btnQuote.titleLabel.numberOfLines = 2;
    btnQuote.titleLabel.textAlignment = NSTextAlignmentCenter;
    btnQuote.layer.shadowColor = _COLOR(0xff, 0x66, 0x19).CGColor;
    btnQuote.layer.shadowOffset = CGSizeMake(0, 0);
    btnQuote.layer.shadowOpacity = 0.5;
    btnQuote.layer.shadowRadius = 1;
    [btnQuote addTarget:self action:@selector(doBtnCarInsurPlan:) forControlEvents:UIControlEventTouchUpInside];
    
    
    NSDictionary *views = NSDictionaryOfVariableBindings(btnQuote);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|->=0-[btnQuote(48)]-10-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[btnQuote(48)]->=0-|" options:0 metrics:nil views:views]];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableview.separatorColor = _COLOR(0xe6, 0xe6, 0xe6);
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableview setSeparatorInset:insets];
    }
    if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableview setLayoutMargins:insets];
    }
    
    self.imgLicense.layer.borderWidth = 0.5;
    self.imgLicense.layer.borderColor = _COLOR(0xe6, 0xe6, 0xe6).CGColor;
    self.btnReSubmit.layer.cornerRadius = 3;
    
    self.viewHConstraint.constant = ScreenWidth;
    
    [self.btnNoNo setImage:ThemeImage(@"select") forState:UIControlStateSelected];
    
    [self showLicenceView:NO];
}

- (void) valueChanged:(UITextField*) obj
{
    [self isModify];
}

- (void) loadCarInfoWithCustomerId:(NSString *) customerCarId
{
    [NetWorkHandler requestToQueryForCustomerCarInfo:customerCarId Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            CarInfoModel *model = (CarInfoModel*)[CarInfoModel modelFromDictionary:[content objectForKey:@"data"]];
            self.customerModel.carInfo = model;
            [self fillTheData];
        }
    }];
}

- (void) showLicenceView:(BOOL) flag
{
    if(flag){
        self.baseViewVConstraint.constant = 436;//驾驶证照片
        lbAttribute.hidden = YES;
        self.licenseView.hidden = NO;
    }else{
        self.baseViewVConstraint.constant = 396;//驾驶证照片
        lbAttribute.hidden = NO;
        self.licenseView.hidden = YES;
    }
}

- (void) doBtnShowLicenseView:(UIButton *)sender
{
    [self showLicenceView:YES];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self fillTheData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSMutableAttributedString *)getAttbuteString
{
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"信息输入太频繁？您也可以上传行驶证来保存信息\n行驶证仅用于车辆投保，不作其他用途，请放心上传"];
    NSMutableParagraphStyle *
    style = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    style.lineHeightMultiple = 1.3;//行间距是多少倍
    [string addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, [string length])];
    
    [string addAttribute:NSForegroundColorAttributeName value:_COLOR(0x46, 0xa6, 0xeb) range:NSMakeRange(12,5)];
    
    return string;
}

- (BOOL) showMessage:(NSString *)msg string:(NSString *) string
{
    if(string == nil || [string length] == 0)
    {
        [Util showAlertMessage:msg];
        return YES;
    }
    
    return NO;
}

- (BOOL) resignFirstResponder
{
    BOOL flag = [super resignFirstResponder];
    
    [self.tfCert resignFirstResponder];
    [self.tfDate resignFirstResponder];
    [self.tfIdenCode resignFirstResponder];
    [self.tfModel resignFirstResponder];
    [self.tfMotorCode resignFirstResponder];
    [self.tfName resignFirstResponder];
    [self.tfNo resignFirstResponder];
    
    return flag;
}

- (void) submitWithBlock:(Completion) completion
{
    NSString *carOwnerName = self.tfName.text;
    NSString *carOwnerCard = self.tfCert.text;
//        flag = [self showMessage:@"车主身份证号不能为空" string:carOwnerCard];
//        if(flag){
//            [self.tfCert becomeFirstResponder];
//            return;
//        }
    NSString *carRegTime = self.tfDate.text;
//        flag = [self showMessage:@"登记日期不能为空" string:carRegTime];
//        if(flag){
//            [self.tfDate becomeFirstResponder];
//            return;
//        }
    NSString *carEngineNo = self.tfMotorCode.text;
    BOOL flag = [self showMessage:@"发动机号不能为空" string:carEngineNo];
    if(flag){
        [self.tfMotorCode becomeFirstResponder];
        return;
    }
    NSString *carShelfNo = self.tfIdenCode.text;
    flag = [self showMessage:@"车辆识别代号不能为空" string:carShelfNo];
    if(flag){
        [self.tfIdenCode becomeFirstResponder];
        return;
    }
    NSString *carTypeNo = self.tfModel.text;
    flag = [self showMessage:@"品牌型号不能为空" string:carTypeNo];
    if(flag){
        [self.tfModel becomeFirstResponder];
        return;
    }
    NSString *carNo = [self getCarCertString];//self.tfNo.text;
    
    NSString *newCarNoStatus = @"1";
    if(self.btnNoNo.selected){
        carNo = nil;
        newCarNoStatus = @"0";
    }
    else{
        if(carNo == nil || [carNo length] != 7)
        {
            [Util showAlertMessage:@"车牌号不正确"];
            [_tfNo becomeFirstResponder];
            return;
        }
    }
    
    NSString *customerCarId = self.customerModel.carInfo.customerCarId;
    NSString *customerId = self.customerId;
    NSString *travelCard1 = nil;
    
    NSString *carTradeStatus = @"0";
    NSString *carTradeTime = nil;
    if(_changeNameIdx == 0){
        carTradeStatus = @"1";
    }
    else if (_changeNameIdx == 1){
        carTradeStatus = @"2";
        carTradeTime = [Util getDayString:_changNameDate];
    }
    
    NSString *carInsurStatus1 = nil;
    NSString *carInsurCompId1 = nil;
    if(_perInsurCompany>=0){
        carInsurStatus1 = @"1";
        carInsurCompId1 = ((InsuranceCompanyModel*)[_insurCompanyArray objectAtIndex:_perInsurCompany]).insuranceCompanyId;
    }
    
    [NetWorkHandler requestToSaveOrUpdateCustomerCar:customerCarId customerId:customerId carNo:carNo carProvinceId:nil carCityId:nil driveProvinceId:nil driveCityId:nil carTypeNo:carTypeNo carShelfNo:carShelfNo carEngineNo:carEngineNo carOwnerName:carOwnerName carOwnerCard:carOwnerCard carOwnerPhone:nil carOwnerTel:nil carOwnerAddr:nil travelCard1:travelCard1 carRegTime:carRegTime newCarNoStatus:newCarNoStatus carTradeStatus:carTradeStatus carTradeTime:carTradeTime carInsurStatus1:carInsurStatus1 carInsurCompId1:carInsurCompId1 Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            
            CarInfoModel *model = self.customerModel.carInfo;
            if(model == nil){
                model = [[CarInfoModel alloc] init];
                self.customerModel.carInfo = model;
            }
            model.customerCarId = [content objectForKey:@"data"];
            model.customerId = customerId;
            model.carOwnerName = carOwnerName;
            model.carOwnerCard = carOwnerCard;
            model.carRegTime = _signDate;
            model.carEngineNo = carEngineNo;
            model.carShelfNo = carShelfNo;
            model.carTypeNo = carTypeNo;
            model.carNo = carNo;
            
            if(completion){
                completion(code, content);
            }
        }
    }];

}

- (void) handleRightBarButtonClicked:(id)sender
{
    [self resignFirstResponder];
    
    if(self.imgLicense.image == nil){
        [self submitWithBlock:^(int code, id content) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }else{
        [self submitWithLicense:^(int code, id content) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
    }
}

- (void) submitWithLicense:(Completion) completion
{
    [ProgressHUD show:nil];
    NSString *customerCarId = nil;
    NSString *customerId = self.customerId;
    
    NSString *carTradeStatus = @"0";
    NSString *carTradeTime = nil;
    if(_changeNameIdx == 0){
        carTradeStatus = @"1";
    }
    else if (_changeNameIdx == 1){
        carTradeStatus = @"2";
        carTradeTime = [Util getDayString:_changNameDate];
    }
    
    NSString *carInsurStatus1 = nil;
    NSString *carInsurCompId1 = nil;
    if(_perInsurCompany>=0){
        carInsurStatus1 = @"1";
        carInsurCompId1 = ((InsuranceCompanyModel*)[_insurCompanyArray objectAtIndex:_perInsurCompany]).insuranceCompanyId;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0),^{
        NSString *filePahe = [self fileupMothed];
        [NetWorkHandler requestToSaveOrUpdateCustomerCar:customerCarId customerId:customerId carNo:nil carProvinceId:nil carCityId:nil driveProvinceId:nil driveCityId:nil carTypeNo:nil carShelfNo:nil carEngineNo:nil carOwnerName:nil carOwnerCard:nil carOwnerPhone:nil carOwnerTel:nil carOwnerAddr:nil travelCard1:filePahe carRegTime:nil newCarNoStatus:nil carTradeStatus:carTradeStatus carTradeTime:carTradeTime carInsurStatus1:carInsurStatus1 carInsurCompId1:carInsurCompId1 Completion:^(int code, id content) {
            [ProgressHUD dismiss];
            [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
            if(code == 200){
                CarInfoModel *model = self.customerModel.carInfo;
                if(model == nil){
                    model = [[CarInfoModel alloc] init];
                    self.customerModel.carInfo = model;
                }
                model.customerCarId = [content objectForKey:@"data"];
                model.customerId = customerId;

                if(completion){
                    completion(code, content);
                }
            }
        }];
    });
}

-(NSString *)fileupMothed
{
    //图片
    //添加文件名
    UIImage *image = self.imgLicense.image;
    @autoreleasepool {
        NSData *imageData = UIImageJPEGRepresentation(image, 1.f);
        AVFile *file = [AVFile fileWithData:imageData];
        [file save];
        
        return file.url;
    }

    //文字内容
}

#pragma UITableViewDataSource UITableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_changeNameIdx == 1){
        self.tableVConstraint.constant = 48 * 3;
        return 3;
    }
    self.tableVConstraint.constant = 48 * 2;
    return 2;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48.f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
    CarAddInfoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
        cell = [[CarAddInfoTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
        cell.textLabel.font = _FONT(15);
        cell.textLabel.textColor = _COLOR(0x21, 0x21, 0x21);
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if(indexPath.row == 0){
        cell.lbTitle.text = @"上年度保险";
        if(_perInsurCompany != -1){
            InsuranceCompanyModel *model = [_insurCompanyArray objectAtIndex:_perInsurCompany];
            cell.lbDetail.text = model.insuranceCompanyShortName;
        }else{
            cell.lbDetail.text = @"";
        }
    }else if(indexPath.row == 1)
    {
        cell.lbTitle.text = @"是否过户";
        if(_changeNameIdx >= 0){
            DictModel *model = [_changeNameArray objectAtIndex:_changeNameIdx];
            cell.lbDetail.text = model.dictName;
        }
    }else{
        cell.lbTitle.text = @"过户日期";
        
        if(_changNameDate){
            cell.lbDetail.text = [Util getDayString:_changNameDate];
        }else
            cell.lbDetail.text = @"";
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.row == 0)
    {
        [self menuChange:nil];
    }else if (indexPath.row == 1){
        [self menuChangeName:nil];
    }else if (indexPath.row == 2){
        [self addDatePicker1:nil];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:insets];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:insets];
    }
}

- (IBAction)doButtonEditNo:(UIButton *)sender
{
    BOOL selected = sender.selected;
    if(selected){
        self.tfNo.enabled = YES;
        self.lbDateTitle.text = @"登记日期";
    }else{
        self.tfNo.enabled = NO;
        self.tfNo.text = @"";
        self.lbDateTitle.text = @"购车日期";
    }
    
    sender.selected = !selected;
    [self isModify];
}

#pragma mark- UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [Util openPhotoLibrary:self allowEdit:YES completion:^{
        }];
        
    }else if (buttonIndex == 1)
    {
        [Util openCamera:self allowEdit:YES completion:^{}];
    }
    else{
        
    }
}
#pragma mark- UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSData * imageData = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerEditedImage"],0.5);
        UIImage *image= [UIImage imageWithData:imageData];
        image = [Util fitSmallImage:image scaledToSize:imgLicenseSize];
        isCertModify = YES;
        self.imgLicense.image = image;
        [self.btnReSubmit setTitle:@"重新上传" forState:UIControlStateNormal];
    }];
    
}
#pragma ACTION
- (void) btnPhotoPressed:(UIButton*)sender{
    UIActionSheet *ac = [[UIActionSheet alloc] initWithTitle:@""
                                                    delegate:(id)self
                                           cancelButtonTitle:@"取消"
                                      destructiveButtonTitle:@"从相册选取"
                                           otherButtonTitles:@"拍照",nil];
    ac.actionSheetStyle = UIBarStyleBlackTranslucent;
    [ac showInView:self.view];
    
}

- (void) setCustomerModel:(CustomerDetailModel *)model
{
    _customerModel = model;
    if(model.carInfo != nil)
        [self loadCarInfoWithCustomerId:model.carInfo.customerCarId];
    
    [self fillTheData];
}

- (void) fillTheData
{
    CarInfoModel *model = self.customerModel.carInfo;
    self.tfName.text = self.customerModel.customerName;
    if(model){
        self.tfName.text = model.carOwnerName;
        self.tfNo.text = [self getCarCertNum:model.carNo];//model.carNo;
        if(model.newCarNoStatus == 0){
            self.btnNoNo.selected = YES;
            self.tfNo.enabled = NO;
            self.lbDateTitle.text = @"购车日期";
        }else{
            self.btnNoNo.selected = NO;
            self.tfNo.enabled = YES;
            self.lbDateTitle.text = @"登记日期";
        }
        self.tfMotorCode.text = model.carEngineNo;
        self.tfModel.text = model.carTypeNo;
        self.tfIdenCode.text = model.carShelfNo;
        self.tfDate.text = [Util getDayString:model.carRegTime];//model.carRegTime;
        self.tfCert.text = model.carOwnerCard;
        
        if(model.travelCard1 != nil){
            [self.imgLicense sd_setImageWithURL:[NSURL URLWithString:model.travelCard1]];
            [self showLicenceView:YES];
        }else{
            [self showLicenceView:NO];
        }
        
        if(model.carTradeStatus == 0){
            _changNameDate = nil;
            _changeNameIdx = -1;
        }
        else if (model.carTradeStatus == 1){
            _changNameDate = nil;
            _changeNameIdx = 0;
        }
        else{
            _changNameDate = model.carTradeTime;
            _changeNameIdx = 1;
        }
        
        if(model.carInsurStatus1 == 1){
            _perInsurCompany = [self getSelectIdxFromArray:model.carInsurCompId1];
        }
        else{
            _perInsurCompany = -1;
        }
            
        
        [self.tableview reloadData];
    }
    [self isModify];
}

- (NSInteger) getSelectIdxFromArray:(NSString *) comapyId
{
    for (int i = 0; i< [_insurCompanyArray count]; i++) {
        InsuranceCompanyModel *model = [_insurCompanyArray objectAtIndex:i];
        if([model.insuranceCompanyId isEqualToString:comapyId])
            return i;
    }
    
    return  -1;
}

//算价
- (void) doBtnCarInsurPlan:(UIButton *) sender
{
    //    http://118.123.249.87:8783/UKB.AgentNew/car_insur/car_insur_plan.html?orderId=e61a2a7d41114fe7a3bf6f96c69a1d9b
    
    [self resignFirstResponder];
    
    if(self.imgLicense.image == nil){
        [self submitWithBlock:^(int code, id content) {
            [self car_insur_plan:[content objectForKey:@"data"]];
        }];
    }else{
        [self submitWithLicense:^(int code, id content) {
            [self car_insur_plan:[content objectForKey:@"data"]];
        }];
    }

}

- (void) car_insur_plan:(NSString *) customerCarId
{
    OrderWebVC *web = [[OrderWebVC alloc] initWithNibName:@"OrderWebVC" bundle:nil];
    web.title = @"报价";
    [self.navigationController pushViewController:web animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@/car_insur/car_insur_plan.html?clientKey=%@&userId=%@&customerId=%@&customerCarId=%@", Base_Uri, [UserInfoModel shareUserInfoModel].clientKey, [UserInfoModel shareUserInfoModel].userId, self.customerModel.customerId, customerCarId];
    [web loadHtmlFromUrl:url];
}

- (IBAction)doButtonHowToWrite:(UIButton *)sender
{
    [self.tfCert resignFirstResponder];
    [self.tfDate resignFirstResponder];
    [self.tfIdenCode resignFirstResponder];
    [self.tfModel resignFirstResponder];
    [self.tfMotorCode resignFirstResponder];
    [self.tfName resignFirstResponder];
    [self.tfNo resignFirstResponder];
    NSArray *urlArray = @[@"license_img"];
    _photoBrowserView=[[PhotoBrowserView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.frame WithArray:urlArray andCurrentIndex:0];
    [[UIApplication sharedApplication].keyWindow addSubview:_photoBrowserView];
}

- (void) loadInsurCompany
{
    [NetWorkHandler requestToQueryForInsuranceCompanyList:nil insuranceType:@"1" Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            _insurCompanyArray = [InsuranceCompanyModel modelArrayFromArray:[[content objectForKey:@"data"] objectForKey:@"rows"]];
            [self fillTheData];
        }
    }];
}

- (IBAction)menuChange:(UIButton *)sender {
    
    if(_insurCompanyArray == nil){
        [self loadInsurCompany];
        return;
    }
    
    if (!_menuView) {
        NSArray *titles = @[];
        _menuView = [[InsurCompanySelectVC alloc]initWithTitles:titles];
        _menuView.menuDelegate = self;
        
    }
    
    _menuView.titleArray = _insurCompanyArray;
    _menuView.title = @"上一次投保公司";
    _menuView.selectIdx = _perInsurCompany;
    
    [_menuView show:self.view];
    
}

- (IBAction)menuChangeName:(UIButton *)sender {
    
    if (!_menu) {
        _menu = [[MenuViewController alloc]initWithTitles:_changeNameArray];
        _menu.menuDelegate = self;
        
    }
    
    _menu.selectIdx = _changeNameIdx;
    _menu.title = @"是否过户";
    
    [_menu show:self.view];
    
}

-(void)menuViewController:(MenuViewController *)menu AtIndex:(NSUInteger)index
{
    [menu hide];
    
    if(menu == _menuView){
        _perInsurCompany = index;
    }else if (menu == _menu){
        _changeNameIdx = index;
        if(index == 1)
            [self addDatePicker1:nil];
        else
            _changNameDate = nil;
    }
    
    [self.tableview reloadData];
    [self isModify];
}
-(void)menuViewControllerDidCancel:(MenuViewController *)menu
{
    [menu hide];
}

- (IBAction) addDatePicker:(id) sender
{
    if(!_datePicker){
        _datePicker = [[ZHPickView alloc] initDatePickWithDate:[NSDate date] datePickerMode:UIDatePickerModeDate isHaveNavControler:YES];
        [_datePicker show];
        _datePicker.delegate = self;
    }else{
        [_datePicker show];
    }
}

- (IBAction) addDatePicker1:(id) sender
{
    if(!_datePicker1){
        _datePicker1 = [[ZHPickView alloc] initDatePickWithDate:[NSDate date] datePickerMode:UIDatePickerModeDate isHaveNavControler:YES];
        [_datePicker1 show];
        _datePicker1.delegate = self;
    }else{
        [_datePicker1 show];
    }
}

#pragma ZHPickViewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultDate:(NSDate *)resultDate
{
    if(pickView == _datePicker){
        _signDate = resultDate;
        NSString *dateStr = [Util getDayString:resultDate];
        self.tfDate.text = dateStr;
    }else{
        _changNameDate = resultDate;
        [self.tableview reloadData];
    }
    
    [self isModify];
}

- (void)toobarCandelBtnHaveClick:(ZHPickView *)pickView
{
    if(pickView == _datePicker1){
        _changeNameIdx = 0;
        [self.tableview reloadData];
    }
}

#pragma UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField == self.tfDate){
        [self addDatePicker:nil];
        [self resignFirstResponder];
        [self isModify];
    }else{
        [_datePicker remove];
    }
    return YES;
}

- (BOOL) isModify
{
    CarInfoModel *model = self.customerModel.carInfo;
    BOOL result = NO;
    
    result = isCertModify;
    
    NSString *name = self.tfName.text;
    BOOL flag = [self checkValueChange:name text:model.carOwnerName];
    if(flag)
        result = flag;
    NSString *cert = self.tfCert.text;
    flag = [self checkValueChange:cert text:model.carOwnerCard];
    if(flag)
        result = flag;
    NSString *no = [self getCarCertString];//self.tfNo.text;
    flag = [self checkValueChange:no text:model.carNo];
    if(flag)
        result = flag;
    if(model != nil){
        if(model.newCarNoStatus == self.btnNoNo.selected){
            result = YES;
        }
    }else{
        if(self.btnNoNo.selected)
            result = YES;
    }
    NSString *date = self.tfDate.text;
    flag = [self checkValueChange:date text:[Util getDayString:model.carRegTime]];
    if(flag)
        result = flag;
    NSString *modelStr = self.tfModel.text;
    flag = [self checkValueChange:modelStr text:model.carTypeNo];
    if(flag)
        result = flag;
    NSString *idenCode = self.tfIdenCode.text;
    flag = [self checkValueChange:idenCode text:model.carShelfNo];
    if(flag)
        result = flag;
    NSString *motorCode = self.tfMotorCode.text;
    flag = [self checkValueChange:motorCode text:model.carEngineNo];
    if(flag)
        result = flag;
    
    //上年度保险
    if(model.carInsurCompId1 ==nil && _perInsurCompany >= 0){
        result = YES;
    }
    else if(_perInsurCompany >= 0 && ![model.carInsurCompId1 isEqualToString:((InsuranceCompanyModel*)[_insurCompanyArray objectAtIndex:_perInsurCompany]).insuranceCompanyId])
        result = YES;
    //是否过户
    if(model.carTradeStatus != _changeNameIdx + 1){
        result = YES;
    }
    //过户日起
    if(model.carTradeTime != nil){
        if(![[Util getDayString:model.carTradeTime] isEqualToString:[Util getDayString:_changNameDate]])
            result = YES;
    }else{
        if(_changNameDate != nil)
            result = YES;
    }
    
    if(result){
        [self SetRightBarButtonWithTitle:@"保存" color:_COLORa(0xff, 0x66, 0x19, 1) action:YES];
    }
    else{
        [self SetRightBarButtonWithTitle:@"保存" color:_COLORa(0xff, 0x66, 0x19, 0.5) action:NO];
    }
    return result;
}

//value 控件中的值
- (BOOL) checkValueChange:(NSString *) value text:(NSString *) text
{
    BOOL flag = NO;
//    if([value length] > 0){
//        if(text == nil)
//            flag = YES;
//        else if(![value isEqualToString:text])
//            flag = YES;
//    }else{
//        
//    }
    if(text == nil)
        text = @"";
    if(value != nil){
        if(![value isEqualToString:text])
            flag = YES;
    }
    
    return flag;
}

- (NSString *) getCarCertLocation:(NSString *) cert
{
    return [cert substringToIndex:1];
}

- (NSString *) getCarCertNum:(NSString *) cert
{
    return [cert substringFromIndex:1];
}

- (NSString *) getCarCertString
{
    NSString *location = _lbProvience.text;
    NSString *num = _tfNo.text;
    return [NSString stringWithFormat:@"%@%@", location, num];
}

- (IBAction)showLargerImage:(id)sender
{
    if (self.imgLicense.image != nil) {
        [SJAvatarBrowser showImage:self.imgLicense];
    }
}

@end
