//
//  AddFollowUpVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/25.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "AddFollowUpVC.h"
#import "define.h"
#import "MenuViewController.h"
#import "NetWorkHandler.h"
#import "DictModel.h"
#import "ZHPickView.h"
#import "NetWorkHandler+saveOrUpdateCustomerVisits.h"

@interface AddFollowUpVC () <MenuDelegate, ZHPickViewDelegate, UITextViewDelegate>
{
    NSArray *_visitProgress;
    NSArray *_visitType;
    
    NSInteger _selectVisitProgressIdx;
    NSInteger _selectvisitTypeIdx;
    NSDate *_visitDate;
    
    ZHPickView *_datePicker;
}

@property (nonatomic, strong) MenuViewController *menuView;
@property (nonatomic, strong) NSArray *visitProgress;
@property (nonatomic, strong) NSArray *visitType;

@end

@implementation AddFollowUpVC

- (void) handleLeftBarButtonClicked:(id)sender
{
    [self.tfAdd resignFirstResponder];
    [self.tfStatus resignFirstResponder];
    [self.tfTIme resignFirstResponder];
    [self.tfview resignFirstResponder];
    [self.tfWay resignFirstResponder];
    
    if(_datePicker){
        [_datePicker remove];
    }
    
    BOOL flag = [self isHasModify];
    if(flag){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"确认放弃保存填写资料吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"新增跟进记录";
    [self SetRightBarButtonWithTitle:@"保存" color:_COLORa(0xff, 0x66, 0x19, 0.5) action:NO];
    
    _selectVisitProgressIdx = -1;
    _selectvisitTypeIdx = -1;
    
    self.viewHConstraint.constant = ScreenWidth;
    
    self.tfStatus.placeholder = @"请填写跟进情况";
    self.tfWay.placeholder = @"请填写跟进方式";
    self.tfTIme.placeholder = @"请填写跟进时间";
    self.tfAdd.placeholder = @"请填写地点";
    self.tfview.placeholder = @"请填写跟进记录内容";
    self.tfAdd.PlaceholderLabel.textAlignment = NSTextAlignmentRight;
    self.tfview.delegate = self;
    self.tfAdd.delegate = self;
    
    self.tfTIme.text = [Util getTimeString:[NSDate date]];
    self.tfAdd.text = LcationInstance.currentDetailAdrress;
    
    [self textViewDidChange:self.tfAdd];
    
    [self loadVisitDictionary];
    
}

- (void) valueChanged:(UITextField*) obj
{
    [self isHasModify];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) handleRightBarButtonClicked:(id)sender
{
    if(_selectVisitProgressIdx == -1){
        [Util showAlertMessage:@"请选择跟进情况"];
        return;
    }
    if(_selectvisitTypeIdx == -1)
    {
        [Util showAlertMessage:@"请选择跟进方式"];
        return;
    }
    
    DictModel *model = [_visitType objectAtIndex:_selectvisitTypeIdx];
    NSString *visitType = model.dictName;
    NSString *visitTypeId = model.dictId;
    model = [_visitProgress objectAtIndex:_selectVisitProgressIdx];
    NSString *visitProgress = model.dictName;
    NSString *visitProgressId = model.dictId;
    
    NSString *addr = self.tfAdd.text;
    NSString *visitTime = self.tfTIme.text;
    NSString *visitMemo = self.tfview.text;
    
    [NetWorkHandler requestToSaveOrUpdateCustomerVisits:self.customerId userId:[UserInfoModel shareUserInfoModel].userId visitTime:visitTime visitAddr:addr visitType:visitType visitTypeId:visitTypeId visitProgress:visitProgress visitProgressId:visitProgressId visitLon:nil visitLat:nil visitStatus:1 visitMemo:visitMemo visitId:nil Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            [self.navigationController popViewControllerAnimated:YES];
            
            VisitInfoModel *model = [[VisitInfoModel alloc] init];
            model.visitAddr = addr;
            model.visitId = [content objectForKey:@"data"];
            model.visitMemo = visitMemo;
            model.visitProgress = visitProgress;
            model.visitProgressId = visitProgressId;
            model.visitTime = _visitDate;//[VisitInfoModel dateFromString:visitTime];
            model.visitType = visitType;
            model.visitTypeId = visitTypeId;
            model.userName = self.customerModel.customerName;
            
            [self.customerModel.detailModel.visitAttay insertObject:model atIndex:0];
            self.customerModel.detailModel.visitTotal += 1;
            self.customerModel.visitType = visitProgress;
        }
    }];
}

//- (void) viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//}


- (IBAction)menuChange:(UIButton *)sender {
    if (!_menuView) {
        NSArray *titles = @[];
        _menuView = [[MenuViewController alloc]initWithTitles:titles];
        _menuView.menuDelegate = self;
        
    }
    if(sender.tag == 1001){
        _menuView.selectIdx = _selectVisitProgressIdx;
        _menuView.titleArray = self.visitProgress;
        _menuView.tag = 100;
        _menuView.title = @"跟进情况";
    }
    else{
        _menuView.selectIdx = _selectvisitTypeIdx;
        _menuView.titleArray = self.visitType;
        _menuView.tag = 101;
        _menuView.title = @"跟进方式";
    }
    [_menuView show:self.view];
    
}

- (IBAction) addFollowDate:(id) sender
{
    if(!_datePicker){
        _datePicker = [[ZHPickView alloc] initDatePickWithDate:[NSDate date] datePickerMode:UIDatePickerModeDateAndTime isHaveNavControler:YES];
        [_datePicker show];
        _datePicker.delegate = self;
    }else{
        [_datePicker show];
    }
}

-(void)menuViewController:(MenuViewController *)menu AtIndex:(NSUInteger)index
{
    [menu hide];
    if(menu.tag == 100){
        _selectVisitProgressIdx = index;
        DictModel *model = [_visitProgress objectAtIndex:index];
        self.tfStatus.text = model.dictName;
    }
    else{
        _selectvisitTypeIdx = index;
        DictModel *model = [_visitType objectAtIndex:index];
        self.tfWay.text = model.dictName;
    }
    [self isHasModify];
}
-(void)menuViewControllerDidCancel:(MenuViewController *)menu
{
    [menu hide];
}

- (void) loadVisitDictionary
{
    NSArray *array = @[@"visitType", @"visitProgress"];
    NSString *method = @"/web/common/getDictCustom.xhtml?dictType=['visitType','visitProgress']";
    method = [NSString stringWithFormat:method, [NetWorkHandler objectToJson:array]];
    NetWorkHandler *handle = [NetWorkHandler shareNetWorkHandler];
    __weak AddFollowUpVC *weakself = self;
    [handle getWithMethod:method BaseUrl:Base_Uri Params:nil Completion:^(int code, id content) {
        [weakself handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            NSArray *array = [DictModel modelArrayFromArray:[[content objectForKey:@"data"] objectForKey:@"rows"]];
            weakself.visitProgress = [weakself buildVisitProgress:array];
            weakself.visitType = [weakself buildVisitType:array];
        }
    }];
}

- (NSArray *) buildVisitProgress:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i ++) {
        DictModel *model = [array objectAtIndex:i];
        if([model.dictType isEqualToString:@"visitProgress"])
            [result addObject:model];
    }
    
    return result;
}

- (NSArray *) buildVisitType:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [array count]; i ++) {
        DictModel *model = [array objectAtIndex:i];
        if([model.dictType isEqualToString:@"visitType"])
            [result addObject:model];
    }
    
    return result;
}

#pragma ZHPickViewDelegate

-(void)toobarDonBtnHaveClick:(ZHPickView *)pickView resultDate:(NSDate *)resultDate
{
    _visitDate = resultDate;
    NSString *dateStr = [Util getTimeString:resultDate];
    self.tfTIme.text = dateStr;
    [self isHasModify];
}

- (void) setVisitModel:(VisitInfoModel *)model
{
    _visitModel = model;
    self.view.userInteractionEnabled = NO;
    self.tfview.text = model.visitMemo;
    self.tfAdd.text = model.visitAddr;
    self.tfStatus.text = model.visitProgress;
    self.tfTIme.text = [Util getTimeString:model.visitTime];
    self.tfWay.text = model.visitType;
    [self SetRightBarButtonWithTitle:@"保存" color:_COLORa(0xff, 0x66, 0x19, 0.5) action:NO];
    self.title = @"查看跟进记录";
    [self textViewDidChange:self.tfAdd];
}

- (BOOL) isHasModify
{
    BOOL result = NO;
    
    if(_selectvisitTypeIdx != -1 || _selectVisitProgressIdx != -1)
    {
        result = YES;
    }
    
    NSString *visitMemo = self.tfview.text;
    if([visitMemo length] > 0 && ![visitMemo isEqualToString:self.visitModel.visitMemo])
        result = YES;
    
    if(_visitDate != nil)
        result = YES;
    NSString *address = self.tfAdd.text;
    if([address length] > 0 && ![address isEqualToString:self.visitModel.visitAddr])
        result = YES;
    
    if(result){
        [self SetRightBarButtonWithTitle:@"保存" color:_COLORa(0xff, 0x66, 0x19, 1) action:YES];
    }else{
        [self SetRightBarButtonWithTitle:@"保存" color:_COLORa(0xff, 0x66, 0x19, 0.5) action:NO];
    }
    
    return result;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if(self.tfAdd == textView){
        CGSize size = [textView.text sizeWithFont:textView.font constrainedToSize:CGSizeMake(textView.frame.size.width, INT_MAX)];
        if(size.height > 36)
            size.height = 36;
        if(size.height < 10)
            size.height = 18;
        self.addVConstraint.constant = size.height + 16;
    }
    [self isHasModify];
}

@end
