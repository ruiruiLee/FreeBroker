//
//  CustomerMainVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/18.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "CustomerMainVC.h"
#import "CustomerTableViewCell.h"
#import "CustomerTagTableCell.h"
#import "define.h"
#import "UserServicePushVC.h"
#import "NetWorkHandler+queryForPageList.h"
#import "CustomerInfoModel.h"
#import "BackGroundView.h"

@interface CustomerMainVC ()<BackGroundViewDelegate>
{
    UISearchBar *searchbar;
    NSString *filterString;
    
    BackGroundView *_addview;
}

@end

@implementation CustomerMainVC

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    AppContext *context = [AppContext sharedAppContext];
    [context removeObserver:self forKeyPath:@"pushCustomerNum"];
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        filterString = @"";
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    AppContext *context = [AppContext sharedAppContext];
    [context addObserver:self forKeyPath:@"pushCustomerNum" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];
    
    self.title = @"客户";
    
    [self setLeftBarButtonWithImage:nil];
    [self setRightBarButtonWithImage:ThemeImage(@"add")];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyCustomerAdd:) name:Notify_Add_NewCustomer object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyToInsertPushCustomer:) name:Notify_Insert_Customer object:nil];
    
    searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    searchbar.placeholder = @"搜索";
    searchbar.showsCancelButton = YES;
    self.pulltable.tableHeaderView = searchbar;
    searchbar.returnKeyType = UIReturnKeySearch;
    searchbar.delegate = self;
    
    [self.pulltable registerNib:[UINib nibWithNibName:@"CustomerTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.pulltable registerNib:[UINib nibWithNibName:@"CustomerTagTableCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    [self.pulltable setSeparatorColor:_COLOR(0xe6, 0xe6, 0xe6)];
    self.pulltable.backgroundColor = [UIColor clearColor];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [self.pulltable reloadData];
}

- (void) notifyToInsertPushCustomer:(NSNotification *)notify
{
    id model = (CustomerInfoModel*)notify.object;
    [self.data insertObject:model atIndex:0];
    [self.pulltable reloadData];
}

- (void) notifyCustomerAdd:(NSNotification *) notify
{
    [self pullTableViewDidTriggerRefresh:self.pulltable];
}

- (void) initSubViews
{
    self.pulltable = [[PullTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 580) style:UITableViewStyleGrouped];
    [self.view addSubview:self.pulltable];
    self.pulltable.delegate = self;
    self.pulltable.dataSource = self;
    self.pulltable.pullDelegate = self;
    self.pulltable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.pulltable.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.pulltable.tableFooterView = [[UIView alloc] init];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 20, 0, 20);
    self.pulltable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.pulltable.separatorColor = _COLOR(0xe6, 0xe6, 0xe6);
    if ([self.pulltable respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.pulltable setSeparatorInset:insets];
    }
    if ([self.pulltable respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.pulltable setLayoutMargins:insets];
    }
    
    //弹出下拉刷新控件刷新数据
    self.pulltable.pullTableIsRefreshing = YES;
    //    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3];
    
    PullTableView *pulltable = self.pulltable;
    NSDictionary *views = NSDictionaryOfVariableBindings(pulltable);
    
    self.vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[pulltable]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:self.vConstraints];
    
    self.hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[pulltable]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:self.hConstraints];
}

//- (void) viewDidLayoutSubviews
//{
//    [super viewDidLayoutSubviews];
//}

- (void) handleRightBarButtonClicked:(id)sender
{
    NewCustomerVC *vc = [IBUIFactory CreateNewCustomerViewController];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.presentvc = self;
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.pulltable reloadData];
}

#pragma UITableViewDataSource UITableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.data count] == 0){
        if(!_addview){
            _addview = [[BackGroundView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT * 2 / 5, ScreenWidth, 100)];
            _addview.delegate = self;
        }else{
            [_addview removeFromSuperview];
        }
        [self.pulltable addSubview:_addview];
    }
    else{
        [_addview removeFromSuperview];
    }
    if(section == 0){
        return 2;
    }
    else{
        return [self.data count];
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1){
        NSString *deq = @"cell1";
        CustomerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
        if(!cell){
            NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"CustomerTableViewCell" owner:nil options:nil];
            cell = [nibs lastObject];
        }
        
        CustomerInfoModel *model = [self.data objectAtIndex:indexPath.row];
        cell.lbName.text = model.customerName;
        cell.lbStatus.text = model.visitType;
        if(model.visitType == nil)
            cell.lbStatus.text = @"";
        cell.lbTimr.text = [Util getShowingTime:model.updatedAt];//@"今天 19:08";
        if(!model.isAgentCreate)
        {
            cell.logoImage.hidden = NO;
        }else{
            cell.logoImage.hidden = YES;
        }
        return cell;
    }else{
        NSString *deq = @"cell2";
        CustomerTagTableCell *cell = [self.pulltable dequeueReusableCellWithIdentifier:deq];
        if(!cell){
            NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"CustomerTagTableCell" owner:nil options:nil];
            cell = [nibs lastObject];
        }
        
        UIImage *image = nil;
        if(indexPath.row == 0){
            image = ThemeImage(@"push_style_customer");
            cell.lbTitle.text = @"系统推送客户";
            cell.lbCount.hidden = NO;
            AppContext *context = [AppContext sharedAppContext];
            cell.lbCount.text = [NSString stringWithFormat:@"%d", context.pushCustomerNum];
            if(context.pushCustomerNum == 0)
                cell.lbCount.hidden = YES;
            else
                cell.lbCount.hidden = NO;
        }
        else{
            image = ThemeImage(@"tag");
            cell.lbTitle.text = @"标签";
            cell.lbCount.hidden = YES;
        }
        cell.photoImage.image = image;
        
        return cell;
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            UserServicePushVC *vc = [[UserServicePushVC alloc] init];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            TagListViewController *vc = [IBUIFactory CreateTagListViewController];
            vc.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else{
        CustomerDetailVC *vc = [IBUIFactory CreateCustomerDetailViewController];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        CustomerInfoModel *model = [self.data objectAtIndex:indexPath.row];
        vc.customerinfoModel = model;
        [vc performSelector:@selector(loadDetailWithCustomerId:) withObject:model.customerId afterDelay:0.2];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    view.image = ThemeImage(@"shadow");
    return view;

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

#pragma UISearchBarDelegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchbar resignFirstResponder];
    filterString = searchbar.text;
    self.pageNum = 0;
    [self loadDataInPages:self.pageNum];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchbar resignFirstResponder];
    searchbar.text = @"";
    filterString = @"";
    self.pageNum = 0;
    [self loadDataInPages:self.pageNum];
}

- (void) loadDataInPages:(NSInteger)page
{
    NSInteger offset = page;
    NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:filters value:@"and" key:@"groupOp"];
    NSMutableArray *rules = [[NSMutableArray alloc] init];
    [rules addObject:[self getRulesByField:@"customerName" op:@"cn" data:filterString]];
    [rules addObject:[self getRulesByField:@"customerPhone" op:@"cn" data:filterString]];
    UserInfoModel *user = [UserInfoModel shareUserInfoModel];
    [rules addObject:[self getRulesByField:@"userId" op:@"eq" data:user.userId]];
    [rules addObject:[self getRulesByField:@"bindStatus" op:@"eq" data:@"1"]];
    [Util setValueForKeyWithDic:filters value:rules key:@"rules"];
    
    [NetWorkHandler requestQueryForPageList:offset limit:LIMIT sord:@"desc" filters:filters Completion:^(int code, id content) {
        [self refreshTable];
        [self loadMoreDataToTable];
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            [self appendData:[[content objectForKey:@"data"] objectForKey:@"rows"]];
            self.total = [[[content objectForKey:@"data"] objectForKey:@"total"] integerValue];
        }
    }];
}

- (void) appendData:(NSArray *) list
{
    if(self.pageNum == 0)
        [self.data removeAllObjects];
    NSError *error = nil;
    NSArray *array = [MTLJSONAdapter modelsOfClass:CustomerInfoModel.class fromJSONArray:list error:&error];
    [self.data addObjectsFromArray:array];
    [self.pulltable reloadData];
}

- (NSDictionary *) getRulesByField:(NSString *) field op:(NSString *) op data:(NSString *) data
{
    NSMutableDictionary *rule = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:rule value:field key:@"field"];
    [Util setValueForKeyWithDic:rule value:op key:@"op"];
    [Util setValueForKeyWithDic:rule value:data key:@"data"];
    
    return rule;
}

#pragma BackGroundViewDelegate
- (void) notifyToAddNewCustomer:(BackGroundView *) view
{
    [self handleRightBarButtonClicked:nil];
}

@end
