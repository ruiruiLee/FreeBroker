//
//  AreaSelectedVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/30.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "AreaSelectedVC.h"
#import "define.h"
#import "UserEditTableViewCell.h"
#import "ProviendeModel.h"
#import "CitySelectedVC.h"
#import "NetWorkHandler+getProvinces.h"

@interface AreaSelectedVC ()
{
    NSArray *data;
}

@property (nonatomic, strong) NSArray *data;

@end

@implementation AreaSelectedVC
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
//    self.data = [ProviendeModel shareProviendeModelArray:^(int code, id content) {
//        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
//        self.data = [ProviendeModel shareProviendeModelArray:nil];
//        [self.tableview reloadData];
//        
//    }];
//    
//    [self.tableview reloadData];
    self.data = [ProviendeModel shareProviendeModelArray];
    if([self.data count] == 0){
        [NetWorkHandler requestToGetProvinces:^(int code, id content) {
            [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
            if(code == 200){
                NSArray *provience = [ProviendeModel modelArrayFromArray:[[content objectForKey:@"data"] objectForKey:@"rows"]];
                self.data = provience;
                [self.tableview reloadData];
                [[ProviendeModel shareProviendeModelArray] removeAllObjects];
                [[ProviendeModel shareProviendeModelArray] addObjectsFromArray:provience];
            }
        }];
    }
    else{
        [self.tableview reloadData];
    }
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
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UserInfoModel *model  = [UserInfoModel shareUserInfoModel];
        cell.lbTitle.text = model.liveProvince;
        cell.imgv.image = nil;
        if(model.liveProvince == nil)
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
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        ProviendeModel *model = [self.data objectAtIndex:indexPath.row];
        cell.textLabel.text = model.provinceName;
        
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.section == 1){
        ProviendeModel *model = [self.data objectAtIndex:indexPath.row];
        CitySelectedVC *vc = [[CitySelectedVC alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        vc.selectIdx = indexPath.row;
        vc.proviendemodel = model;
    }else{
        CitySelectedVC *vc = [[CitySelectedVC alloc] initWithNibName:nil bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
        vc.selectIdx = indexPath.row;
        ProviendeModel *model = [[ProviendeModel alloc] init];
        model.provinceId = [UserInfoModel shareUserInfoModel].liveProvinceId;
        model.provinceName = [UserInfoModel shareUserInfoModel].liveProvince;
        vc.proviendemodel = model;
    }
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

@end
