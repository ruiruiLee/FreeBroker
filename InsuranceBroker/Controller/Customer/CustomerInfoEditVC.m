//
//  CustomerInfoEditVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/23.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "CustomerInfoEditVC.h"
#import "define.h"
#import "NetWorkHandler+queryForLabelPageList.h"
#import "NetWorkHandler+saveOrUpdateCustomer.h"
#import "TagObjectModel.h"

@interface CustomerInfoEditVC ()

@property (nonatomic, strong) NSArray *tagList;

@end

@implementation CustomerInfoEditVC

- (void) handleLeftBarButtonClicked:(id)sender
{
    [self.tfName resignFirstResponder];
    [self.tfMobile resignFirstResponder];
    
    BOOL flag = [self isHasModify];
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
    // Do any additional setup after loading the view.
    self.title = @"详细资料";
    [self SetRightBarButtonWithTitle:@"保存" color:_COLORa(0xff, 0x66, 0x19, 0.5) action:NO];
    
    [self.tfMobile addTarget:self action:@selector(textChangeAction:) forControlEvents:UIControlEventEditingChanged];
    [self.tfName addTarget:self action:@selector(textChangeAction:) forControlEvents:UIControlEventEditingChanged];
    [self.onwerTag.textfield.textfield addTarget:self action:@selector(textChangeAction:) forControlEvents:UIControlEventEditingChanged];
    
    self.viewHConstraint.constant = ScreenWidth;
    NSArray *array = nil;
    if(self.data){
        self.tfName.text = self.data.customerName;
        self.tfMobile.text = self.data.customerPhone;
        array = [self tagModelArrayFromIdAndName];
    }
    self.tagView.delegate = self;
    
    [self.onwerTag setDataArray:array];
    self.onwerTag.delegate = self;
    
    if([[TagObjectModel shareTagList] count] == 0){
        [self loadData];
    }else{
        self.tagList = [TagObjectModel shareTagList];
        [self.tagView setDataArray:self.tagList];
        [self.tagView setOwnerArray:[self tagModelArrayFromIdAndName]];
    }
}

- (NSArray *) tagModelArrayFromIdAndName
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [self.data.customerLabelId count]; i++) {
        TagObjectModel *model = [[TagObjectModel alloc] init];
        model.labelName = [self.data.customerLabel objectAtIndex:i];
        model.labelId = [self.data.customerLabelId objectAtIndex:i];
        [array addObject:model];
    }
    
    return array;
}

- (BOOL) isHasModify
{
    BOOL back = NO;
    
    NSString *name = self.tfName.text;
    
    if( [name length] > 0 && (self.data == nil || (![name isEqualToString:self.data.customerName] && self.data != nil))){
        back = YES;
    }
    NSString *mobile = self.tfMobile.text;
    if( [mobile length] > 0 && (self.data == nil || (![mobile isEqualToString:self.data.customerPhone] && self.data != nil))){
        back = YES;
    }
    
//    if(self.data != nil){
        NSMutableArray *result = [[NSMutableArray alloc] init];
        
        NSArray *array = [self.onwerTag getSelectedLabelName];
        NSString *labelName = [self.onwerTag getEditLabelName];
        [result addObjectsFromArray:array];
        
        if(labelName != nil && [labelName length] > 0){
            for (int i = 0; i < [array count]; i++) {
                TagObjectModel *model = [array objectAtIndex:i];
                if(![model.labelName isEqualToString:labelName]){
                    back = YES;
                    break;
                }
            }
        }
        
        NSArray *oArray = [self tagModelArrayFromIdAndName];
        
        for (int i = 0; i < [array count]; i++) {
            BOOL flag = NO;
             TagObjectModel *model = [array objectAtIndex:i];
            for (int j = 0; j < [oArray count]; j++) {
                TagObjectModel *model1 = [oArray objectAtIndex:j];
                if([model1.labelName isEqualToString:model.labelName]){
                    flag = YES;
                    break;
                }
            }
            if(!flag)
                back = YES;
        }
        
        for (int i = 0; i < [oArray count]; i++) {
            BOOL flag = NO;
            TagObjectModel *model = [oArray objectAtIndex:i];
            for (int j = 0; j < [array count]; j++) {
                TagObjectModel *model1 = [array objectAtIndex:j];
                if([model1.labelName isEqualToString:model.labelName]){
                    flag = YES;
                    break;
                }
            }
            if(!flag)
                back = YES;
        }
//    }
    
    if(back){
        [self SetRightBarButtonWithTitle:@"保存" color:_COLORa(0xff, 0x66, 0x19, 1) action:YES];
    }else{
        [self SetRightBarButtonWithTitle:@"保存" color:_COLORa(0xff, 0x66, 0x19, 0.5) action:NO];
    }
    return back;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) NotifyTagListViewHeightChangeTo:(NSInteger) height TagList:(TagListView*) view
{
    self.tagVConstraint.constant = height;
}

- (void) NotifySelectTag:(NSArray *) labelArray
{
    [self.onwerTag setDataArray:labelArray];
}

- (void) NotifyOwnerTagViewHeightChange:(NSInteger) height tagView:(OnwerTagView *) view
{
    self.myTagVConstraint.constant = height;
    [self isHasModify];
}

- (void) NotifyOwnerTagSelectedChanged:(NSArray *) labelArray
{
    [self.tagView setOwnerArray:labelArray];
}

- (void) setData:(CustomerDetailModel *)model
{
    _data = model;
}

- (void) loadData
{
    [NetWorkHandler requestToQueryForLabelPageList:1 Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            NSError *error = nil;
            self.tagList = [MTLJSONAdapter modelsOfClass:TagObjectModel.class fromJSONArray:[[content objectForKey:@"data"] objectForKey:@"rows"] error:&error];
            [[TagObjectModel shareTagList] addObjectsFromArray:self.tagList];
            [self.tagView setDataArray:self.tagList];
            [self.tagView setOwnerArray:[self tagModelArrayFromIdAndName]];
        }
    }];
}

- (void) handleRightBarButtonClicked:(id)sender
{
    //上传修改内容
    [self updateOrAddLabelInfo];
    
}

- (void) updateOrAddLabelInfo
{
    //更新标签
    NSString *name = self.tfName.text;
    if([name length] == 0){
        [Util showAlertMessage:@"请输入客户姓名"];
        return;
    }

    NSString *mobile = self.tfMobile.text;
    mobile = [self formatPhoneNum:mobile];
    if(![Util isMobilePhoeNumber:mobile] && ![Util checkPhoneNumInput:mobile]){
        [Util showAlertMessage:@"客户联系电话格式不正确"];
        return;
    }

    
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    NSArray *array = [self.onwerTag getSelectedLabelName];
    NSString *labelName = [self.onwerTag getEditLabelName];
    [result addObjectsFromArray:array];
    
    if(labelName != nil && [labelName length] > 0){
        BOOL flag = NO;
        for (int i = 0; i < [array count]; i++) {
            TagObjectModel *model = [array objectAtIndex:i];
            if([model.labelName isEqualToString:labelName]){
                flag = YES;
                break;
            }
        }
        if(flag){
            
        }else{
            NSArray *array = [TagObjectModel shareTagList];
            for (int i = 0; i < [array count]; i++) {
                TagObjectModel *model = [array objectAtIndex:i];
                if([model.labelName isEqualToString:labelName]){
                    flag = YES;
                    [result addObject:model];
                    break;
                }
            }
            if(!flag){
                TagObjectModel *model = [[TagObjectModel alloc] init];
                model.labelName = labelName;
                [result addObject:model];
                [[TagObjectModel shareTagList] removeAllObjects];
            }
        }
    }

    NSMutableArray *customerLabel = [[NSMutableArray alloc] init];
    NSMutableArray *customerLabelId = [[NSMutableArray alloc] init];
    NSMutableArray *label = [[NSMutableArray alloc] init];
    NSMutableArray *labelId = [[NSMutableArray alloc] init];

    for (int i = 0; i < [result count]; i++) {
        TagObjectModel *model = [result objectAtIndex:i];
        if(model.labelId == nil){
            [customerLabel addObject:model.labelName];
        }else{
            [customerLabelId addObject:model.labelId];
        }
        [label addObject:model.labelName];
        if(model.labelId)
            [labelId addObject:model.labelId];
    }
    
    NSString *userId = [UserInfoModel shareUserInfoModel].userId;
    BOOL isAgentCreate = 1;//本人创建为1
    if(self.data){
        isAgentCreate = self.data.isAgentCreate;
        userId = self.data.userId;
    }
    
    [NetWorkHandler requestToSaveOrUpdateCustomerWithUID:userId
                                           isAgentCreate:isAgentCreate
                                              customerId:self.data.customerId
                                            customerName:name
                                           customerPhone:mobile
                                             customerTel:self.data.customerTel
                                                 headImg:self.data.headImg
                                              cardNumber:self.data.cardNumber
                                          cardNumberImg1:self.data.cardNumberImg1
                                          cardNumberImg2:self.data.cardNumberImg2
                                          cardProvinceId:self.data.cardProvinceId
                                              cardCityId:self.data.cardCityId
                                              cardAreaId:self.data.cardAreaId
                                             cardVerifiy:self.data.cardVerifiy
                                                cardAddr:self.data.cardAddr
                                             verifiyTime:[CustomerDetailModel stringFromDate:self.data.verifiyTime]
                                          liveProvinceId:self.data.liveProvinceId
                                              liveCityId:self.data.liveCityId
                                              liveAreaId:self.data.liveAreaId
                                                liveAddr:self.data.liveAddr
                                          customerStatus:self.data.customerStatus
                                            drivingCard1:self.data.drivingCard1
                                            drivingCard2:self.data.drivingCard2
                                           customerLabel:customerLabel
                                         customerLabelId:customerLabelId
                                              Completion:^(int code, id content) {
                                                  
                                                  [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
                                                  if(code == 200){
                                                      if(self.data == nil){
                                                          [[NSNotificationCenter defaultCenter] postNotificationName:Notify_Add_NewCustomer object:nil];
                                                      }else{
                                                          self.data.customerName = name;
                                                          self.data.customerPhone = mobile;
                                                          
                                                          [[NSNotificationCenter defaultCenter] postNotificationName:Notify_Reload_CustomerDetail object:nil];
                                                          [[NSNotificationCenter defaultCenter] postNotificationName:Notify_Refrush_TagList object:nil];
                                                      }
                                                      [self.navigationController popViewControllerAnimated:YES];
                                                  }
    }];
}

- (void) textChangeAction:(id) sender {
    [self isHasModify];
}

- (NSString *) formatPhoneNum:(NSString *) phoneNum
{
    NSString *mobile = [phoneNum stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobile = [mobile stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobile = [mobile stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobile = [mobile stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobile = [Util formatPhoneNum:mobile];
    
    return mobile;
}

@end
