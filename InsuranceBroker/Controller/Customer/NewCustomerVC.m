//
//  NewCustomerVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/20.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "NewCustomerVC.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>
#import <ContactsUI/ContactsUI.h>
#import "define.h"
#import "NetWorkHandler+saveOrUpdateCustomer.h"

@interface NewCustomerVC ()<CNContactPickerDelegate, ABPeoplePickerNavigationControllerDelegate>

@property (nonatomic)CNContactPickerViewController *picker;
@property (nonatomic)ABPeoplePickerNavigationController *picker1;

@end

@implementation NewCustomerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (float)getIOSVersion
{
    return [[[UIDevice currentDevice] systemVersion] floatValue];
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
    if(![Util isMobileNumber:mobile]){
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
                                                          self.data = [[CustomerDetailModel alloc] init];
                                                          self.data.customerId = [content objectForKey:@"data"];
                                                          self.data.customerName = name;
                                                          self.data.customerPhone = mobile;
                                                          [[NSNotificationCenter defaultCenter] postNotificationName:Notify_Add_NewCustomer object:nil];
                                                      }else{
                                                          self.data.customerName = name;
                                                          self.data.customerPhone = mobile;
                                                          
                                                          [[NSNotificationCenter defaultCenter] postNotificationName:Notify_Reload_CustomerDetail object:nil];
                                                      }
                                                      [self.navigationController popViewControllerAnimated:NO];
                                                      AutoInsuranceInfoEditVC *vc = [IBUIFactory CreateAutoInsuranceInfoEditViewController];
                                                      [self.presentvc.navigationController pushViewController:vc animated:YES];
                                                      vc.customerModel = self.data;
                                                      vc.customerId = self.data.customerId;
//                                                      [detail performSelector:@selector(loadDetailWithCustomerId:) withObject:[content objectForKey:@"data"] afterDelay:0.2];
                                                  }
                                              }];
}

- (IBAction)doBtnAddressBook:(id)sender
{
    if([self getIOSVersion] >= 9.0){
        if(!self.picker){
            self.picker = [[CNContactPickerViewController alloc] init];
            // place the delegate of the picker to the controll
            self.picker.modalPresentationStyle = UIModalPresentationCurrentContext;
            self.picker.modalInPopover = YES;
            self.picker.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            self.picker.delegate = self;
            // self is the 2nd viewController in the original navigation stack
        }
        
        //显示一个viewcontroller
        [self presentViewController:self.picker animated:YES completion:nil];
        
        //关闭viewcontroller
        //- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion
    }else{
        if(!self.picker1){
            self.picker1 = [[ABPeoplePickerNavigationController alloc] init];
            self.picker1.modalPresentationStyle = UIModalPresentationCurrentContext;
            self.picker1.modalInPopover = YES;
            self.picker1.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            self.picker1.peoplePickerDelegate = self;
            // self is the 2nd viewController in the original navigation stack
        }
        
        //显示一个viewcontroller
        [self presentViewController:self.picker1 animated:YES completion:nil];
    }
}

/*
 Discussion
 该方法在用户选择通讯录一级列表的某一项时被调用,通过person可以获得选中联系人的所有信息,但当选中的联系人有多个号码,而我们又希望用户可以明确的指定一个号码时(如拨打电话),返回YES允许通讯录进入联系人详情界面:
 */
- (BOOL)peoplePickerNavigationController: (ABPeoplePickerNavigationController *)peoplePicker
      shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    NSString *name = (__bridge NSString*)ABRecordCopyCompositeName(person);
    //获取联系人电话
    ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSMutableArray *phones = [[NSMutableArray alloc] init];
    for (int i = 0; i < ABMultiValueGetCount(phoneMulti); i++)
    {
        NSString *aPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phoneMulti, i);
        NSString *aLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(phoneMulti, i);
        if([aLabel isEqualToString:@"_$!<Mobile>!$_"])
        {
            [phones addObject:aPhone];
        }
    }
    
    self.tfName.text = name;
    if([phones count] > 0)
        self.tfMobile.text = [NSString stringWithFormat:@"%@", [[phones objectAtIndex:0] stringByReplacingOccurrencesOfString:@"-" withString:@""]];
    
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    
    [self isHasModify];
    //虽然使用了ARC模式，但是Core Foundation框架 (CoreFoundation.framework) PS：CF开头的任然需要手动控制内存（CFRELESE）
    return YES;
}

- (void)peoplePickerNavigationController:(ABPeoplePickerNavigationController*)peoplePicker didSelectPerson:(ABRecordRef)person
{
    NSString *name = (__bridge NSString*)ABRecordCopyCompositeName(person);
    //获取联系人电话
    ABMutableMultiValueRef phoneMulti = ABRecordCopyValue(person, kABPersonPhoneProperty);
    NSMutableArray *phones = [[NSMutableArray alloc] init];
    for (int i = 0; i < ABMultiValueGetCount(phoneMulti); i++)
    {
        NSString *aPhone = (__bridge NSString*)ABMultiValueCopyValueAtIndex(phoneMulti, i);
        NSString *aLabel = (__bridge NSString*)ABMultiValueCopyLabelAtIndex(phoneMulti, i);
        if([aLabel isEqualToString:@"_$!<Mobile>!$_"])
        {
            [phones addObject:aPhone];
        }
    }
    
    self.tfName.text = name;
    if([phones count] > 0)
        self.tfMobile.text = [NSString stringWithFormat:@"%@", [[phones objectAtIndex:0] stringByReplacingOccurrencesOfString:@"-" withString:@""]];
    
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    
    [self isHasModify];
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIView *custom = [[UIView alloc] initWithFrame:CGRectMake(0.0f,0.0f,0.0f,0.0f)];
    UIBarButtonItem *btn = [[UIBarButtonItem alloc] initWithCustomView:custom];
    [viewController.navigationItem setRightBarButtonItem:btn animated:NO];
}

- (void)contactPickerDidCancel:(CNContactPickerViewController *)picker
{
    [self.picker dismissViewControllerAnimated:YES completion:nil];
}

/*!
 * @abstract Singular delegate methods.
 * @discussion These delegate methods will be invoked when the user selects a single contact or property.
 */
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContact:(CNContact *)contact;

{
    NSArray *phoneNumbers = [contact phoneNumbers];
    NSString *firstname = contact.givenName;
    NSString *lastname = contact.familyName;
    if(firstname == nil)
        firstname = @"";
    if(lastname == nil)
        lastname = @"";
    self.tfName.text = [NSString stringWithFormat:@"%@%@", firstname, lastname];
    if([phoneNumbers count] > 0){
        CNLabeledValue *value = [phoneNumbers objectAtIndex:0];
        CNPhoneNumber *number = value.value;
        self.tfMobile.text = [number.stringValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    [self isHasModify];
}
- (void)contactPicker:(CNContactPickerViewController *)picker didSelectContactProperty:(CNContactProperty *)contactProperty
{
}



@end
