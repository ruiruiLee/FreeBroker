//
//  WorkMainVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/18.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "WorkMainVC.h"
#import "define.h"
#import "DeatilTextTableviewCell.h"
#import "OrderManagerVC.h"
#import "MyTeamsVC.h"
#import "SelectCustomerVC.h"
#import "UIButton+WebCache.h"

@interface WorkMainVC ()
{
    UIButton *btnBanner;
}


@end

@implementation WorkMainVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"工作";
    [self setLeftBarButtonWithImage:nil];
    
    self.tableview.separatorColor = _COLOR(0xe6, 0xe6, 0xe6);
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableview registerNib:[UINib nibWithNibName:@"DeatilTextTableviewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    NewUserModel *model = appdelegate.workBanner;
    btnBanner = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [Util getHeightByWidth:375 height:90 nwidth:ScreenWidth])];
    if(model.imgUrl == nil) {
        btnBanner.frame = CGRectMake(0, 0, 0, 0);
    }else{
        [btnBanner addTarget:self action:@selector(doBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        [btnBanner sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] forState:UIControlStateNormal placeholderImage:Normal_Image];
        if(!model.isRedirect){
            btnBanner.userInteractionEnabled = NO;
        }
    }
    self.tableview.tableHeaderView = btnBanner;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableview setSeparatorInset:insets];
    }
    if ([self.tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableview setLayoutMargins:insets];
    }
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void) doBtnClicked:(UIButton *)sender
{
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    NewUserModel *model = appdelegate.workBanner;
    if(model.isRedirect){
        WebViewController *web = [IBUIFactory CreateWebViewController];
        web.title = model.title;
        [self.navigationController pushViewController:web animated:YES];
        if(model.url){
            [web loadHtmlFromUrl:model.url];
        }else{
            NSString *url = [NSString stringWithFormat:@"%@%@%@", SERVER_ADDRESS, @"/news/view/", model.nid];
            [web loadHtmlFromUrl:url];
        }
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
        return 5;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
    DeatilTextTableviewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
        cell = [[DeatilTextTableviewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:deq];
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        cell.textLabel.font = _FONT(15);
//        cell.textLabel.textColor = _COLOR(0x21, 0x21, 0x21);
//        cell.detailTextLabel.font = _FONT(12);
//        cell.detailTextLabel.textColor = _COLOR(0xcc, 0xcc, 0xcc);
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if(indexPath.section == 0){
        [self setCellContent:cell imgPath:@"auto" title:@"车险算价" detail:@"西装？考勤？NO,NO,NO——还你自由！"];
    }
    else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
            {
                [self setCellContent:cell imgPath:@"team" title:@"我的团队" detail:@"赶紧号召盟友三千，加入战队，攻城拔寨"];
            }
                break;
            case 1:
            {
                [self setCellContent:cell imgPath:@"order" title:@"保单管理" detail:@"不知不觉又保了个单"];
            }
                break;
            case 2:
            {
                [self setCellContent:cell imgPath:@"income" title:@"收益统计" detail:@"如果这会引发心脏不适，请小心点击"];
            }
                break;
            case 3:
            {
                [self setCellContent:cell imgPath:@"sales" title:@"销售统计" detail:@"今天你又打败了全国99%的...这么直接，真的好吗？"];
            }
                break;
            case 4:
            {
                [self setCellContent:cell imgPath:@"visit" title:@"客户拜访统计" detail:@"虽然客户是上帝，但说实话他应该庆幸认识我真好"];
            }
                break;
                
            default:
                break;
        }
    }
    
    return cell;
}

- (void) setCellContent:(DeatilTextTableviewCell *)cell imgPath:(NSString *) path title:(NSString *)title detail:(NSString *) detail
{
    cell.photoImgV.image = ThemeImage(path);
    cell.lbTitle.text = title;
    cell.lbDetailTitle.text = detail;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.section == 0){
//        [self setCellContent:cell imgPath:@"auto" title:@"车险经纪" detail:@"非职业？西装？考勤？NO,NO,NO——还你自由！"];
        SelectCustomerVC *vc = [[SelectCustomerVC alloc] initWithNibName:nil bundle:nil];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else if (indexPath.section == 1){
        switch (indexPath.row) {
            case 0:
            {
                MyTeamsVC *vc = [[MyTeamsVC alloc] initWithNibName:nil bundle:nil];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 1:
            {
                OrderManagerVC *vc = [[OrderManagerVC alloc] initWithNibName:nil bundle:nil];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 2:
            {
                IncomeStatisticsVC *vc = [IBUIFactory CreateIncomeStatisticsViewController];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 3:
            {
                SalesStatisticsVC *vc = [IBUIFactory CreateSalesStatisticsViewController];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
            case 4:
            {
                CustomerCallStatisticsVC *vc = [IBUIFactory CreateCustomerCallStatisticsViewController];
                vc.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:vc animated:YES];
            }
                break;
                
            default:
                break;
        }
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

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15.f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    view.image = ThemeImage(@"shadow");
    return view;
}

@end
