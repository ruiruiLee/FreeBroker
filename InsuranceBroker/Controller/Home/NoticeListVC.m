//
//  NoticeListVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/29.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "NoticeListVC.h"
#import "define.h"
#import "NoticeListTableViewCell.h"
#import "NoticeDetailListVC.h"
#import "NetWorkHandler+announcement.h"
#import "AnnouncementModel.h"
#import "UIImageView+WebCache.h"

@interface NoticeListVC ()

@end

@implementation NoticeListVC

- (void) dealloc
{
    AppContext *context = [AppContext sharedAppContext];
    [context removeObserver:self forKeyPath:@"isHasNotice"];
    [context removeObserver:self forKeyPath:@"isHasNewPolicy"];
    [context removeObserver:self forKeyPath:@"isHasTradingMsg"];
    [context removeObserver:self forKeyPath:@"isHasIncentivePolicy"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息公告";
}

- (void) initSubViews
{
    AppContext *context = [AppContext sharedAppContext];
    [context addObserver:self forKeyPath:@"isHasNotice" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    [context addObserver:self forKeyPath:@"isHasNewPolicy" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    [context addObserver:self forKeyPath:@"isHasTradingMsg" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    [context addObserver:self forKeyPath:@"isHasIncentivePolicy" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
    self.tableview = [[UITableView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.tableview];
    UITableView *tableview = self.tableview;
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableview.translatesAutoresizingMaskIntoConstraints = NO;
    tableview.backgroundColor = [UIColor clearColor];
    tableview.separatorColor = _COLOR(0xe6, 0xe6, 0xe6);
    [tableview registerNib:[UINib nibWithNibName:@"NoticeListTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableview setSeparatorInset:insets];
    }
    if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableview setLayoutMargins:insets];
    }
    
    NSDictionary *views = NSDictionaryOfVariableBindings(tableview);
    
    self.hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableview]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:self.hConstraints];
    self.vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tableview]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:self.vConstraints];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadData
{
    UserInfoModel *model = [UserInfoModel shareUserInfoModel];
    [NetWorkHandler requestToAnnouncement:model.userId completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            self.data = [AnnouncementModel modelArrayFromArray:[[content objectForKey:@"data"] objectForKey:@"rows"]];
            [self.tableview reloadData];
        }
    }];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self.tableview reloadData];
}

#pragma UITableViewDataSource UITableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66.f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
    NoticeListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
        cell = [[NoticeListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
    }
    
    AnnouncementModel *model = [self.data objectAtIndex:indexPath.row];
    [cell.photoLogo sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:Normal_Image];
    cell.lbTitle.text = model.title;
    cell.lbContent.text = model.lastNewsContent;
    cell.lbTime.text = [Util getShowingTime:model.lastNewsDt];
    AppContext *context = [AppContext sharedAppContext];
    switch (indexPath.row) {
        case 0:
        {
            if(context.isHasNotice){
                cell.photoLogo.badgeView.badgeValue = 1;
            }else
                cell.photoLogo.badgeView.badgeValue = 0;
        }
            break;
        case 1:
        {
            if(context.isHasNewPolicy){
                cell.photoLogo.badgeView.badgeValue = 1;
            }else
                cell.photoLogo.badgeView.badgeValue = 0;
        }
            break;
        case 2:
        {
            if(context.isHasTradingMsg){
                cell.photoLogo.badgeView.badgeValue = 1;
            }else
                cell.photoLogo.badgeView.badgeValue = 0;
        }
            break;
        case 3:
        {
            if(context.isHasIncentivePolicy){
                cell.photoLogo.badgeView.badgeValue = 1;
            }else
                cell.photoLogo.badgeView.badgeValue = 0;
        }
            break;
        default:
            break;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    AppContext *context = [AppContext sharedAppContext];
    switch (indexPath.row) {
        case 0:
        {
            context.isHasNotice = 0;
        }
            break;
        case 1:
        {
            context.isHasNewPolicy = 0;
        }
            break;
        case 2:
        {
            context.isHasTradingMsg = 0;
        }
            break;
        case 3:
        {
            context.isHasIncentivePolicy = 0;
        }
            break;
        default:
            break;
    }
    
    [context saveData];
    
    AnnouncementModel *model = [self.data objectAtIndex:indexPath.row];
    NoticeDetailListVC *vc = [[NoticeDetailListVC alloc] initWithNibName:nil bundle:nil];
    vc.title = model.title;
    vc.category = model.category;
    [self.navigationController pushViewController:vc animated:YES];
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

@end
