//
//  CitySelectedVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/30.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "CitySelectedVC.h"
#import "UserEditTableViewCell.h"
#import "define.h"
#import "NetWorkHandler+getCitys.h"
#import "UserInfoEditVC.h"
#import "NetWorkHandler+modifyUserInfo.h"

@interface CitySelectedVC ()
{
    NSArray *data;
}

@property (nonatomic, strong) NSArray *data;

@end

@implementation CitySelectedVC
@synthesize selectIdx;
@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择地区";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initSubViews
{
//    data = [AreaModel shareAreaModel].province;
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 580) style:UITableViewStyleGrouped];
    [self.view addSubview:self.tableview];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    self.tableview.translatesAutoresizingMaskIntoConstraints = NO;
    [self.tableview registerNib:[UINib nibWithNibName:@"UserEditTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    
    UITableView *tableview = self.tableview;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(tableview);
    
    self.vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tableview]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:self.vConstraints];
    
    self.hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableview]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:self.hConstraints];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 20, 0, 20);
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableview setSeparatorInset:insets];
    }
    if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableview setLayoutMargins:insets];
    }
}

- (void) loadData
{
    self.data = self.proviendemodel.citymodel;
    if( self.proviendemodel != nil){
        if([self.data count] == 0){
            [NetWorkHandler requestToGetCitys:self.proviendemodel.provinceId Completion:^(int code, id content) {
                [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
                if(code == 200){
                    self.data = [CityModel modelArrayFromArray:[[content objectForKey:@"data"] objectForKey:@"rows"]];
                    self.proviendemodel.citymodel = self.data;
                    [self.tableview reloadData];
                }
            }];
        }
        else
        {
            [self.tableview reloadData];
        }
    }
}

- (void)setSelectIdx:(NSInteger)_selectIdx
{
    selectIdx = _selectIdx;
//    data = [[AreaModel shareAreaModel] getCityListWithProvince:selectIdx];
    [self.tableview reloadData];
}

#pragma UITableViewDataSource UITableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 1;
    else
        return [data count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        NSString *deq = @"cell";
        UserEditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
        if(!cell){
            cell = [[UserEditTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
        }
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        UserInfoModel *model  = [UserInfoModel shareUserInfoModel];
        cell.lbTitle.text = model.liveCity;
        cell.imgv.image = nil;
        if(model.liveCity == nil)
            cell.lbDetail.text = @"请选择地区";
        else
            cell.lbDetail.text = @"已选择地区";
        
        return cell;
    }
    else{
        NSString *deq = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
            cell.textLabel.font = _FONT(15);
            cell.textLabel.textColor = _COLOR(0x21, 0x21, 0x21);
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        CityModel *model = [data objectAtIndex:indexPath.row];
        cell.textLabel.text = model.cityShortName;
        
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    CityModel *citymodel = [self.data objectAtIndex:indexPath.row];
    [self modifyAddress:citymodel];
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    view.image = ThemeImage(@"shadow");
    return view;
}

- (void) modifyAddress:(CityModel *)citymodel
{
    UserInfoModel *model = [UserInfoModel shareUserInfoModel];
    [NetWorkHandler requestToModifyuserInfo:model.userId realName:nil userName:nil phone:nil cardNumber:nil cardNumberImg1:nil cardNumberImg2:nil liveProvinceId:self.proviendemodel.provinceId liveCityId:citymodel.cityId liveAreaId:nil liveAddr:nil userSex:nil headerImg:nil Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(self){
            UserInfoModel *model = [UserInfoModel shareUserInfoModel];
            model.liveProvinceId = self.proviendemodel.provinceId;
            model.liveProvince = self.proviendemodel.provinceName;
            model.liveCityId = citymodel.cityId;
            model.liveCity = citymodel.cityShortName;
            
            NSArray *vcarray = self.navigationController.viewControllers;
            UIViewController *vc = nil;
            for (int i = 0; i < [vcarray count]; i++) {
                UIViewController *temp = [vcarray objectAtIndex:i];
                if([temp isKindOfClass:[UserInfoEditVC class]]){
                    vc = temp;
                    break;
                }
            }
            
            [self.navigationController popToViewController:vc animated:YES];
        }
    }];
}

@end
