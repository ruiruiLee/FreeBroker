//
//  EditTagVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/22.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "EditTagVC.h"
#import "define.h"
#import "ContactSelectVC.h"
#import "NetWorkHandler+saveOrUpdateLabel.h"
#import "NetWorkHandler+saveOrUpdateCustomerLabel.h"
#import "NetWorkHandler+queryForPageList.h"
#import "CustomerInfoModel.h"
#import "NetWorkHandler+saveOrUpdateLabelCustomer.h"


@interface EditTagVC ()<ContactSelectVCDelegate>

@property (nonatomic, strong) NSArray *data;

@property (nonatomic, strong) NSMutableArray *modifyArray;

@end

@implementation EditTagVC

- (void) handleLeftBarButtonClicked:(id)sender
{
    [self.tfTagName resignFirstResponder];
    
    BOOL flag = [self watchCustomerChanged];
    if(flag){
        if([self getIOSVersion] < 8.0){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"警告" message:@"确认放弃保存填写资料吗？" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
            [alert show];
        }
        else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"警告" message:@"确认放弃保存填写资料吗？" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.navigationController popViewControllerAnimated:YES];
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:okAction];
            [alertController addAction:cancelAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
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
    
    self.title = @"编辑标签";
    [self SetRightBarButtonWithTitle:@"保存" color:_COLORa(0xff, 0x66, 0x19, 0.5) action:NO];
    
    self.modifyArray = [[NSMutableArray alloc] init];
    
    self.tfTagName.layer.borderColor = [UIColor clearColor].CGColor;
    self.btnDelTag.layer.cornerRadius = 8;
    self.tfTagName.textColor = _COLOR(0x75, 0x75, 0x75);
    self.tfTagName.font = _FONT(15);
    self.tfTagName.placeholder = @"标签名称";
    [self.tfTagName addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventEditingChanged];
    self.tfTagName.text = self.labelModel.labelName;
//    self.tfTagName.delegate = self;
//    [self.tfTagName addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    [self performSelector:@selector(resetConstraints) withObject:nil afterDelay:0.1];
    self.editView.delegate = self;
    [self.btnDelTag addTarget:self action:@selector(doBtnDelLabel:) forControlEvents:UIControlEventTouchUpInside];
    
    self.bgHConstraint.constant = ScreenWidth;
    self.conVConstraint.constant = 330;
    
    if(self.labelModel == nil)
        self.btnDelTag.hidden = YES;
    
    if (self.labelModel.labelType == 1) {
        self.btnDelTag.hidden = YES;
        self.tfTagName.userInteractionEnabled = NO;
    }
}

- (void) resetConstraints
{
    [self NotifyEditFrameChanged:[self.modifyArray count] + 2];
}

- (void) showRightBarButton
{
    [self SetRightBarButtonWithTitle:@"保存" color:_COLORa(0xff, 0x66, 0x19, 1) action:YES];
}

- (void) hidRightBarButton
{
    [self SetRightBarButtonWithTitle:@"保存" color:_COLORa(0xff, 0x66, 0x19, 0.5) action:NO];
}

- (void) setData:(NSArray *)data
{
    _data = data;
    [self.modifyArray removeAllObjects];
    [self.modifyArray addObjectsFromArray:data];
    [self.editView setUserArray:self.modifyArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self setData:self.data];
    [self.editView setUserArray:self.modifyArray];
}

- (void) valueChanged:(UITextField*) obj
{
    [self watchCustomerChanged];
}

//DVO/DVC
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    NSString *new = [change objectForKey:@"new"];
//    if(new != nil && [new length] > 0)
//    {
//        [self SetRightBarButtonWithTitle:@"保存" color:_COLORa(0xff, 0x66, 0x19, 1) action:YES];
//    }
//}

- (void) handleRightBarButtonClicked:(id)sender
{
    [self.tfTagName resignFirstResponder];
    NSString *labelName = [self.tfTagName text];
    if(labelName == nil || [labelName length] == 0){
        [Util showAlertMessage:@"标签名称不能为空"];
        [self.tfTagName becomeFirstResponder];
        return;
    }
    
    NSString *labelId = nil;
    if(self.labelModel != nil)
        labelId = self.labelModel.labelId;
    
    NSArray *addarray = [self getAddArray];
    NSArray *delarray = [self getDelArray];
    
    if([addarray count] == 0)
        addarray = nil;
    if([delarray count] == 0)
        delarray = nil;
    
    UserInfoModel *user = [UserInfoModel shareUserInfoModel];
    
    [NetWorkHandler requestToSaveOrUpdateLabelCustomer:[self getIdArrayWithArray:addarray] deleteCustomerId:[self getIdArrayWithArray:delarray] labelId:labelId labelName:labelName userId:user.userId Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            if(self.labelModel != nil){
                self.labelModel.labelName = labelName;
                self.labelModel.labelCustomerNums = [NSString stringWithFormat:@"%lu", (unsigned long)[self.modifyArray count]];
            }else{
                TagObjectModel *model = [[TagObjectModel alloc] init];
                model.labelId = [content objectForKey:@"data"];
                model.labelName = labelName;
                model.labelType = 2;
                model.userId = [UserInfoModel shareUserInfoModel].userId;
                model.labelCustomerNums = [NSString stringWithFormat:@"%lu", (unsigned long)[self.modifyArray count]];
                [[TagObjectModel shareTagList] addObject:model];
                _labelModel = model;
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    //系统标签只能增减客户
    //自定义标签可修改标签名和增减客户
}

- (NSArray *) getIdArrayWithArray:(NSArray *)array
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for (int i = 0; i < [array count]; i++) {
        CustomerInfoModel *model = [array objectAtIndex:i];
        [result addObject:model.customerId];
    }
    
    return result;
}

- (NSArray *) getDelArray
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [self.data count]; i++) {
        CustomerInfoModel *model = [self.data objectAtIndex:i];
        BOOL flag = NO;
        for (int j = 0; j < [self.modifyArray count]; j++) {
            CustomerInfoModel *customer = [self.modifyArray objectAtIndex:j];
            if([customer.customerId isEqualToString:model.customerId]){
                flag = YES;
                break;
            }
        }
        
        if(!flag){
            [result addObject:model];
        }
    }
    
    return result;
}

- (NSArray *) getAddArray
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [self.modifyArray count]; i++) {
        CustomerInfoModel *model = [self.modifyArray objectAtIndex:i];
        BOOL flag = NO;
        for (int j = 0; j < [self.data count]; j++) {
            CustomerInfoModel *customer = [self.data objectAtIndex:j];
            if([customer.customerId isEqualToString:model.customerId]){
                flag = YES;
                break;
            }
        }
        
        if(!flag){
            [result addObject:model];
        }
    }
    
    return result;
}

- (void) doBtnDelLabel:(id) sender
{
    [self.tfTagName resignFirstResponder];
    [NetWorkHandler requestToSaveOrUpdateLabel:nil labelId:self.labelModel.labelId labelStatus:-1 labelName:nil labelType:nil Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            [[TagObjectModel shareTagList] removeObject:self.labelModel];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

- (void) setLabelModel:(TagObjectModel *)model
{
    _labelModel = model;
    self.tfTagName.text = _labelModel.labelName;
    if (self.labelModel.labelType == 1) {
        self.btnDelTag.hidden = YES;
        self.tfTagName.userInteractionEnabled = NO;
    }
    [self loadDetail];
}

- (void) loadDetail
{
    if([self.labelModel.labelCustomerNums integerValue] == 0){
        [self.editView setUserArray:self.data];
        return;
    }
    NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:filters value:@"and" key:@"groupOp"];
    NSMutableArray *rules = [[NSMutableArray alloc] init];
    [rules addObject:[self getRulesByField:@"labelId" op:@"eq" data:self.labelModel.labelId]];
    [rules addObject:[self getRulesByField:@"userId" op:@"eq" data:[UserInfoModel shareUserInfoModel].userId]];
    [Util setValueForKeyWithDic:filters value:rules key:@"rules"];
    
    [NetWorkHandler requestQueryForPageList:0 limit:[self.labelModel.labelCustomerNums integerValue] sord:@"desc" filters:filters Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            [self appendData:[[content objectForKey:@"data"] objectForKey:@"rows"]];
        }
    }];
}

- (void) appendData:(NSArray *) list
{
    NSError *error = nil;
    NSArray *array = [MTLJSONAdapter modelsOfClass:CustomerInfoModel.class fromJSONArray:list error:&error];
    self.data = array;
}

- (NSDictionary *) getRulesByField:(NSString *) field op:(NSString *) op data:(NSString *) data
{
    NSMutableDictionary *rule = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:rule value:field key:@"field"];
    [Util setValueForKeyWithDic:rule value:op key:@"op"];
    [Util setValueForKeyWithDic:rule value:data key:@"data"];
    
    return rule;
}

#pragma CustomerPanEditViewDelegate

- (void) NotifyEditFrameChanged:(NSInteger) userCount
{
    NSInteger count = userCount / 4;
    if((userCount % 4) > 0)
        count ++;
    
    self.conVConstraint.constant = count * 85 + 100 - 36;
    self.bgVConstraint.constant = count * 85 + 100 + 15 + 68 + 15 + 30 + 30 + 44 - 36;
}

- (void) NotifyEditContact:(BOOL) isAdd
{
    ContactSelectVC *vc = [[ContactSelectVC alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    [vc setRawData:self.modifyArray];
    vc.delegate = self;
    [self.navigationController presentViewController:nav animated:YES completion:nil];
}

- (void) NotifyToDelObject:(CustomerInfoModel *) model
{
    [self removeObjectFromArray:model];
    //待处理
    [self watchCustomerChanged];
}

- (void) NotifyToViewDetail:(CustomerInfoModel *) model
{
    CustomerDetailVC *vc = [IBUIFactory CreateCustomerDetailViewController];
    [self.navigationController pushViewController:vc animated:YES];
    vc.customerinfoModel = model;
    [vc performSelector:@selector(loadDetailWithCustomerId:) withObject:model.customerId afterDelay:0.2];
}

//
- (void) removeObjectFromArray:(CustomerInfoModel *) model
{
    for (int i = 0; i < [self.modifyArray count]; i++) {
        CustomerInfoModel *customer = [self.modifyArray objectAtIndex:i];
        if([customer.customerId isEqualToString:model.customerId])
        {
            [self.modifyArray removeObject:customer];
        }
    }
}

- (void) NotifyItemChanged:(ContactSelectVC *) selectVC ChangedItems:(NSArray *) items isDelOrAdd:(BOOL) isDelOrAdd
{
    [self.modifyArray addObjectsFromArray:items];
    [self.editView setUserArray:self.modifyArray];
    [self watchCustomerChanged];
}

- (BOOL) watchCustomerChanged
{
    BOOL result = NO;
    NSArray *array = [self getDelArray];
    NSArray *array1 = [self getAddArray];
    
    NSString *str = self.tfTagName.text;
    
    if(self.labelModel != nil){
        if(([array count]> 0) || [array1 count] > 0 || (str != nil && [str length] > 0 && ![str isEqualToString:self.labelModel.labelName])){
            [self showRightBarButton];
            result = YES;
        }else{
            [self hidRightBarButton];
            result = NO;
        }
    }else{
        if(str != nil && [str length] > 0){
            [self showRightBarButton];
            result = YES;
        }else{
            [self hidRightBarButton];
            result = NO;
        }
    }
    
    return result;
}

@end
