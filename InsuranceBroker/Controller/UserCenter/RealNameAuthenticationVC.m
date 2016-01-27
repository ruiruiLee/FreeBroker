//
//  RealNameAuthenticationVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/29.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "RealNameAuthenticationVC.h"
#import "define.h"
#import <AVOSCloud/AVOSCloud.h>
#import "UIButton+WebCache.h"
#import "NetWorkHandler+modifyUserInfo.h"

@interface RealNameAuthenticationVC ()
{
    NSString *cert1path;
    NSString *cert2path;
}

@end

@implementation RealNameAuthenticationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"实名认证";
    
    UserInfoModel *model = [UserInfoModel shareUserInfoModel];
    
    self.tfName.text = model.realName;
    self.tfCertNo.text = model.cardNumber;
    [self.btnCert1 sd_setImageWithURL:[NSURL URLWithString:model.cardNumberImg1] forState:UIControlStateNormal placeholderImage:ThemeImage(@"add_cert")];
    [self.btnCert2 sd_setImageWithURL:[NSURL URLWithString:model.cardNumberImg2] forState:UIControlStateNormal placeholderImage:ThemeImage(@"add_cert")];
    
    if(model.cardNumberImg1 != nil || ![model.cardNumberImg1 isKindOfClass:[NSNull class]]){
        [self.btnCert1 sd_setImageWithURL:[NSURL URLWithString:model.cardNumberImg1] forState:UIControlStateSelected placeholderImage:ThemeImage(@"add_cert")];
        self.btnCert1.selected = YES;
    }
    if(model.cardNumberImg2 != nil || ![model.cardNumberImg2 isKindOfClass:[NSNull class]]){
        [self.btnCert2 sd_setImageWithURL:[NSURL URLWithString:model.cardNumberImg2] forState:UIControlStateSelected placeholderImage:ThemeImage(@"add_cert")];
        self.btnCert2.selected = YES;
    }
    
    self.viewHConstraint.constant = ScreenWidth;
    
    self.btnSubmit.layer.cornerRadius = 5;
    self.lbWarning.attributedText = [Util getWarningString:@"*实名认证信息需与绑定银行卡持卡人身份一致，否则将无法提现"];
    [self.btnCert1 addTarget:self action:@selector(btnPhotoPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnCert2 addTarget:self action:@selector(btnPhotoPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.btnCert1.tag = 1002;
    self.btnCert2.tag = 1003;
    
    [self.btnSubmit addTarget:self action:@selector(doBtnSubmit:) forControlEvents:UIControlEventTouchUpInside];
    self.lbErrorInfo.hidden = YES;
    self.submitVConstraint.constant = 42;
    if(model.cardVerifiy == 1){
        self.btnSubmit.hidden = YES;
        self.tfName.userInteractionEnabled = NO;
        self.tfCertNo.userInteractionEnabled = NO;
        self.btnCert1.userInteractionEnabled = NO;
        self.btnCert2.userInteractionEnabled = NO;
        self.submitVConstraint.constant = 0;
        self.submitOffsetVConstraint.constant = 0;
    }
    else if (model.cardVerifiy == 2){
        self.lbErrorInfo.hidden = NO;
        self.lbErrorInfo.text = model.cardVerifiyMsg;
    }
    else if (model.cardVerifiy == 3){
        self.btnSubmit.hidden = YES;
        self.tfName.userInteractionEnabled = NO;
        self.tfCertNo.userInteractionEnabled = NO;
        self.btnCert1.userInteractionEnabled = NO;
        self.btnCert2.userInteractionEnabled = NO;
        self.submitVConstraint.constant = 0;
        self.submitOffsetVConstraint.constant = 0;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void) doBtnSubmit:(UIButton *)sender
{
    NSString *realName = self.tfName.text;
    if(realName == nil || [realName length] <= 1)
    {
        [Util showAlertMessage:@"名字不正确，请重新输入"];
        [self.tfName becomeFirstResponder];
        return;
    }
    NSString *cardNumber = self.tfCertNo.text;
    
    if(![Util validateIdentityCard:cardNumber]){
        [Util showAlertMessage:@"身份证号码不正确，请重新输入"];
        [self.tfCertNo becomeFirstResponder];
        return;
    }
    
    if(!self.btnCert1.selected)
    {
        [Util showAlertMessage:@"请上传身份证正面照片验证"];
        return;
    }
    
    if(!self.btnCert2.selected)
    {
        [Util showAlertMessage:@"请上传身份证背面照片验证"];
        return;
    }
            //添加文件名
    @autoreleasepool {
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
            // cert1
            UIImage *image = [self.btnCert1 imageForState:UIControlStateSelected];
            AVFile *file = [AVFile fileWithName:@"cert1.jpg" data:UIImagePNGRepresentation(image)];
            [file save];
//            [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    cert1path = file.url;
//            }];
        });
        dispatch_group_async(group, dispatch_get_global_queue(0,0), ^{
            // cert2
            UIImage *image = [self.btnCert1 imageForState:UIControlStateSelected];
            AVFile *file = [AVFile fileWithName:@"cert2.jpg" data:UIImagePNGRepresentation(image)];
            [file save];
//            [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
//                [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    cert2path = file.url;
//                }];
//                
//            }];
        });
        dispatch_group_notify(group, dispatch_get_global_queue(0,0), ^{
            // 汇总结果
            UserInfoModel *model = [UserInfoModel shareUserInfoModel];
            [NetWorkHandler requestToModifyuserInfo:model.userId realName:realName userName:nil phone:nil cardNumber:cardNumber cardNumberImg1:cert1path cardNumberImg2:cert2path liveProvinceId:nil liveCityId:nil liveAreaId:nil liveAddr:nil userSex:nil headerImg:nil Completion:^(int code, id content) {
                [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
                if(code == 200){
                    [Util showAlertMessage:@"资料上传成功，等客服人员处理"];
                    model.cardVerifiy = 1;
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];

        });
         }
}

#pragma mark- UIActionSheetDelegate

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(actionSheet.tag == 1001){
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
}
#pragma mark- UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSData * imageData = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerEditedImage"],0.5);
        UIImage *image= [UIImage imageWithData:imageData];
        image = [Util fitSmallImage:image scaledToSize:CGSizeMake(180, 180)];
        if(currentcertType == enumCertType1){
            [self.btnCert1 sd_setImageWithURL:nil forState:UIControlStateSelected placeholderImage:image];
            self.btnCert1.selected = YES;
        }
        else{
            [self.btnCert2 sd_setImageWithURL:nil forState:UIControlStateSelected placeholderImage:image];
            self.btnCert2.selected = YES;
        }
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
    ac.tag = 1001;
    if(sender.tag == 1002){
        currentcertType = enumCertType1;
    }
    else{
        currentcertType = enumCertType2;
    }
}

@end
