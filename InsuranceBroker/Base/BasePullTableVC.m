//
//  BasePullTableVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/17.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "BasePullTableVC.h"
#import "define.h"

@interface BasePullTableVC ()

@end

@implementation BasePullTableVC
@synthesize pulltable;
@synthesize imgWithNoData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.total = INT_MAX;
    
    _data = [[NSMutableArray alloc] init];
    
    [self initSubViews];
    
    [self refresh2Loaddata];
}

- (void) initSubViews
{
    pulltable = [[PullTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 580)];
    [self.view addSubview:pulltable];
    pulltable.delegate = self;
    pulltable.dataSource = self;
    pulltable.pullDelegate = self;
    pulltable.separatorStyle = UITableViewCellSeparatorStyleNone;
    pulltable.translatesAutoresizingMaskIntoConstraints = NO;
    pulltable.backgroundColor = [UIColor clearColor];
    
    pulltable.tableFooterView = [[UIView alloc] init];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 16, 0, 16);
    self.pulltable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.pulltable.separatorColor = _COLOR(0xe6, 0xe6, 0xe6);
    if ([pulltable respondsToSelector:@selector(setSeparatorInset:)]) {
        [pulltable setSeparatorInset:insets];
    }
    if ([pulltable respondsToSelector:@selector(setLayoutMargins:)]) {
        [pulltable setLayoutMargins:insets];
    }
    
    //弹出下拉刷新控件刷新数据
    pulltable.pullTableIsRefreshing = YES;
//    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(pulltable);
    
    self.vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[pulltable]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:self.vConstraints];
    
    self.hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[pulltable]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:self.hConstraints];
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
    return [_data count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44.f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 16, 0, 16);
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:insets];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:insets];
    }
}

#pragma PullTableViewDelegate
- (void)pullTableViewDidTriggerRefresh:(PullTableView*)pullTableView
{
    [self refresh2Loaddata];
    
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3];
}
- (void)pullTableViewDidTriggerLoadMore:(PullTableView*)pullTableView
{
    [self pullLoadMore];
}

- (void) refreshTable
{
    self.pulltable.pullLastRefreshDate = [NSDate date];
    self.pulltable.pullTableIsRefreshing = NO;
}

- (void) loadMoreDataToTable
{
    self.pulltable.pullTableIsLoadingMore = NO;
}

- (void) refresh2Loaddata
{
    NSLog(@"refresh2Loaddata");
    self.pageNum = 0;
    [self loadDataInPages:self.pageNum];
}

- (void) pullLoadMore
{
    NSLog(@"pullLoadMore");
    self.pageNum = [self.data count];
    if(self.pageNum >= self.total){
        [self performSelector:@selector(loadMoreDataToTable) withObject:nil afterDelay:1];
    }else{
        [self loadDataInPages:self.pageNum];
    }
}


/**
 重载此函数获取数据
 */
- (void) loadDataInPages:(NSInteger)page
{
    
}

- (void) showNoDatasImage:(UIImage *) image
{
    if(!self.explainBgView){
        self.explainBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 80)];
        imgWithNoData = [[UIImageView alloc] initWithImage:image];
        [self.explainBgView addSubview:imgWithNoData];
        [self.pulltable addSubview:self.explainBgView];
        self.explainBgView.center = CGPointMake(ScreenWidth/2, self.pulltable.frame.size.height/2);
    }else{
        self.explainBgView.center = CGPointMake(ScreenWidth/2, self.pulltable.frame.size.height/2);
    }
}

- (void) hidNoDatasImage
{
    [self.explainBgView removeFromSuperview];
    [imgWithNoData removeFromSuperview];
    self.explainBgView = nil;
    self.imgWithNoData = nil;
}

@end
