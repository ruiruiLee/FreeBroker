//
//  UserInfoEditVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/22.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "UserInfoEditVC.h"
#import "define.h"
#import "UserEditTableViewCell.h"
#import "HMPopUpView.h"
#import "AreaSelectedVC.h"
#import <AVOSCloud/AVOSCloud.h>
#import "UIImageView+WebCache.h"
#import "NetWorkHandler+modifyUserInfo.h"

@interface UserInfoEditVC ()<HMPopUpViewDelegate>

@end

@implementation UserInfoEditVC
@synthesize tableview;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人资料";
    // Do any additional setup after loading the view from its nib.
    
    self.tableview.tableFooterView = [[UIView alloc] init];
    [self.tableview registerNib:[UINib nibWithNibName:@"UserEditTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableview.separatorColor = _COLOR(0xe6, 0xe6, 0xe6);
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableview setSeparatorInset:insets];
    }
    if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableview setLayoutMargins:insets];
    }
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma UITableViewDataSource UITableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
        return 70;
    else
        return 50.f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
    UserEditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
        cell = [[UserEditTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.imgHConstraint.constant = 16;
    cell.imgVConstraint.constant = 16;
    
    UserInfoModel *model = [UserInfoModel shareUserInfoModel];
    
    switch (indexPath.row) {
        case 0:
        {
            UIImage *image = ThemeImage(@"head_male_edit");
            if(model.sex == 2)
                image = ThemeImage(@"head_famale_edit");
            [self setCellData:cell title:@"头像" image:image content:@""];
            [cell.imgv sd_setImageWithURL:[NSURL URLWithString:model.headerImg] placeholderImage:image];
            cell.imgv.layer.cornerRadius = 25;
            cell.imgv.layer.borderWidth = 1;
            cell.imgHConstraint.constant = image.size.width;
            cell.imgVConstraint.constant = image.size.height;
            UIColor *color = _COLORa(0xe6, 0xe6, 0xe6, 0.9);//_COLORa((0xe6, 0xe6, 0xe6, 0.9);
            cell.imgv.layer.borderColor = color.CGColor;
        }
            break;
        case 1:
        {
            [self setCellData:cell title:@"昵称" image:nil content:model.nickname];
        }
            break;
        case 2:
        {
            [self setCellData:cell title:@"手机号" image:nil content:model.phone];
        }
            break;
        case 3:
        {
            [self setCellData:cell title:@"二维码名片" image:ThemeImage(@"QR_code_edit") content:nil];
            cell.imgv.layer.cornerRadius = 0;
            cell.imgv.layer.borderWidth = 0;
            cell.imgv.layer.borderColor = [UIColor whiteColor].CGColor;
        }
            break;
        case 4:
        {
            [self setCellData:cell title:@"性别" image:nil content:[Util getSexStringWithSex:model.sex]];
        }
            break;
        case 5:
        {
            [self setCellData:cell title:@"所在地区" image:nil content:[Util getAddrWithProvience:model.liveProvince city:model.liveCity]];
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (void) setCellData:(UserEditTableViewCell *) cell title:(NSString *)title image:(UIImage *)image content:(NSString *) content
{
    cell.lbTitle.text = title;
    cell.lbDetail.text = content;
    cell.imgv.image = image;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    switch (indexPath.row) {
        case 0:
        {
//            [self setCellData:cell title:@"头像" image:ThemeImage(@"head_male_edit") content:@""];
            [self btnPhotoPressed:nil];
        }
            break;
        case 1:
        {
            HMPopUpView *hmPopUp = [[HMPopUpView alloc] initWithTitle:@"修改昵称" okButtonTitle:@"确定" cancelButtonTitle:@"取消" delegate:self];
            hmPopUp.transitionType = HMPopUpTransitionTypePopFromBottom;
            hmPopUp.dismissType = HMPopUpDismissTypeFadeOutTop;
            [hmPopUp showInView:self.view];
            hmPopUp.txtField.text = [UserInfoModel shareUserInfoModel].nickname;
        }
            break;
        case 2:
        {
            ModifyPhoneNumVC *vc = [IBUIFactory CreateModifyPhoneNumViewController];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 3:
        {
            QRCodeVC *vc = [IBUIFactory CreateQRCodeViewController];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 4:
        {
//            [self setCellData:cell title:@"性别" image:nil content:@"男"];
            UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"选择性别" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"男" otherButtonTitles:@"女", nil];
            [action showInView:self.view];
            action.tag = 1000;
        }
            break;
        case 5:
        {
//            [self setCellData:cell title:@"所在地区" image:nil content:@"成都"];
            AreaSelectedVC *vc = [[AreaSelectedVC alloc] initWithNibName:nil bundle:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        default:
            break;
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

#pragma HMPopUpViewDelegate
- (void) popUpView:(HMPopUpView *)view accepted:(BOOL)accept inputText:(NSString *)text

{
    if(!accept)
        return;
    UserEditTableViewCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    cell.lbDetail.text = text;
    
    UserInfoModel *model = [UserInfoModel shareUserInfoModel];
    if(text != nil && [text length] > 0)
        [NetWorkHandler requestToModifyuserInfo:model.userId realName:nil userName:text phone:nil cardNumber:nil cardNumberImg1:nil cardNumberImg2:nil liveProvinceId:nil liveCityId:nil liveAreaId:nil liveAddr:nil userSex:nil headerImg:nil Completion:^(int code, id content) {
            [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
            if(code == 200){
                [UserInfoModel shareUserInfoModel].nickname = text;
            }
        }];
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
    else{
        UserInfoModel *model = [UserInfoModel shareUserInfoModel];
//        if (buttonIndex == 0) {
//            model.sex = 1;
//            
//        }else if (buttonIndex == 1)
//        {
//            model.sex = 2;
//        }
//        else{
//            
//        }
        [NetWorkHandler requestToModifyuserInfo:model.userId realName:nil userName:nil phone:nil cardNumber:nil cardNumberImg1:nil cardNumberImg2:nil liveProvinceId:nil liveCityId:nil liveAreaId:nil liveAddr:nil userSex:[NSString stringWithFormat:@"%d", buttonIndex + 1] headerImg:nil Completion:^(int code, id content) {
            [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
            if(code == 200){
                model.sex = buttonIndex + 1;
                [self.tableview reloadData];
            }
        }];
    }
}
#pragma mark- UIImagePickerControllerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSData * imageData = UIImageJPEGRepresentation([info objectForKey:@"UIImagePickerControllerEditedImage"],0.5);
        UIImage *image= [UIImage imageWithData:imageData];
        image = [Util fitSmallImage:image scaledToSize:CGSizeMake(180, 180)];
        UserEditTableViewCell *cell = [self.tableview cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
//        cell.imgv.image = image;
        AVFile *file = [AVFile fileWithName:@"head.jpg" data:imageData];
        [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            [file saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                UserInfoModel *model = [UserInfoModel shareUserInfoModel];
                [NetWorkHandler requestToModifyuserInfo:model.userId realName:nil userName:nil phone:nil cardNumber:nil cardNumberImg1:nil cardNumberImg2:nil liveProvinceId:nil liveCityId:nil liveAreaId:nil liveAddr:nil userSex:nil headerImg:file.url Completion:^(int code, id content) {
                    [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
                    if(code == 200){
                        cell.imgv.image = image;
                        model.headerImg = file.url;
                    }
                }];
            }];
            
        }];
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
    
}

@end
