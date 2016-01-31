//
//  BaseStrategyView.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/13.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseStrategyView.h"
#import "define.h"
#import "AgentStrategyTableViewCell.h"
#import "NetWorkHandler+news.h"
#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
#import "NewsModel.h"
#import "UIImageView+WebCache.h"
#import <AVOSCloud/AVOSCloud.h>
#import "KGStatusBar.h"
@implementation BaseStrategyView
@synthesize pulltable;


- (id) initWithFrame:(CGRect)frame Strategy:(NSString *) Strategy
{
    self = [super initWithFrame:frame];
    if(self){
        self.total = INT_MAX;
        _category = Strategy;
        
        _data = [[NSMutableArray alloc] init];
        
        [self initSubViews];
        
        [self refresh2Loaddata];
    }
    
    return self;
}

- (void) initSubViews
{
    pulltable = [[PullTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 580)];
    [self addSubview:pulltable];
    pulltable.delegate = self;
    pulltable.dataSource = self;
    pulltable.pullDelegate = self;
    pulltable.separatorStyle = UITableViewCellSeparatorStyleNone;
    pulltable.translatesAutoresizingMaskIntoConstraints = NO;
     [self.pulltable registerNib:[UINib nibWithNibName:@"AgentStrategyTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    pulltable.backgroundColor = [UIColor clearColor];
    pulltable.tableFooterView = [[UIView alloc] init];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 20, 0, 20);
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
    [self addConstraints:self.vConstraints];
    
    self.hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[pulltable]-0-|" options:0 metrics:nil views:views];
    [self addConstraints:self.hConstraints];
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
    return 94.f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
     AgentStrategyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
        cell = [[AgentStrategyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
    }
    
    NewsModel *model = [self.data objectAtIndex:indexPath.row];
    [cell.photoImgV sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] placeholderImage:Normal_Image];
    cell.lbTitle.text = model.title;
    cell.lbContent.text = model.content;
    cell.lbTime.text = [Util getShowingTime:model.createdAt];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NewsModel *model = [self.data objectAtIndex:indexPath.row];
    if(model.isRedirect){
        WebViewController *web = [IBUIFactory CreateWebViewController];
        web.title = model.title;
        web.type = enumShareTypeShare;
        if(model.imgUrl)
            web.shareImgArray = [NSArray arrayWithObject:model.imgUrl];
        web.shareTitle = model.title;
        web.shareContent = model.content;
        [self.parentvc.navigationController pushViewController:web animated:YES];
//        [web loadHtmlFromUrl:model.url];
        if(model.url == nil){
            [web loadHtmlFromUrlWithUserId:[NSString stringWithFormat:@"%@%@%@", SERVER_ADDRESS, @"/news/view/", model.nid]];
        }else{
            [web loadHtmlFromUrlWithUserId:model.url];
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 20, 0, 20);
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
    [NetWorkHandler requestToNews:self.category userId:[UserInfoModel shareUserInfoModel].userId offset:page limit:LIMIT completion:^(int code, id content) {
        [self refreshTable];
        [self loadMoreDataToTable];
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            if(page == 0)
                [self.data removeAllObjects];
            
            [self.data addObjectsFromArray:[NewsModel modelArrayFromArray:[[content objectForKey:@"data"] objectForKey:@"rows"]]];
            self.total = [[[content objectForKey:@"data"] objectForKey:@"total"] integerValue];
            [self.pulltable reloadData];
        }
    }];
}

#pragma 登录
- (BOOL) login
{
    UserInfoModel *user = [UserInfoModel shareUserInfoModel];
    if(!user.isLogin){
        if([WXApi isWXAppInstalled]){
            WXLoginVC *vc  = [IBUIFactory CreateWXLoginViewController];
            UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:vc];
            [self.parentvc.navigationController presentViewController:naVC animated:YES completion:nil];
        }
        else{
            loginViewController *vc = [IBUIFactory CreateLoginViewController];
            UINavigationController *naVC = [[UINavigationController alloc] initWithRootViewController:vc];
            [self.parentvc.navigationController presentViewController:naVC animated:NO completion:nil];
        }
        return NO;
    }else{
        return YES;
    }
}

//处理返回数据
- (BOOL) handleResponseWithCode:(NSInteger) code msg:(NSString *)msg
{
    BOOL result = YES;
    if(code != 200){
        if (code == 504){
            UserInfoModel *user = [UserInfoModel shareUserInfoModel];
            user.isLogin = NO;
            AVInstallation *currentInstallation = [AVInstallation currentInstallation];
            [currentInstallation removeObject:@"ykbbrokerLoginUser" forKey:@"channels"];
            [currentInstallation removeObject:[UserInfoModel shareUserInfoModel].userId forKey:@"channels"];
            [currentInstallation saveInBackground];
            [self login];
        }
        else if(code<0)
            [KGStatusBar showErrorWithStatus:@"无法连接网络，请稍后再试！"];
        else
            [KGStatusBar showErrorWithStatus:msg];
        result = NO;
    }
    return result;
}

@end
