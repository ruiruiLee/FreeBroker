//
//  UserServicePushVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/22.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "UserServicePushVC.h"
#import "CustomerTableViewCell.h"
#import "define.h"
#import "NetWorkHandler+queryForPageList.h"
#import "CustomerInfoModel.h"
#import "NetWorkHandler+updateCustomerBindStatus.h"
#import "AppDelegate.h"
#import "UIButton+WebCache.h"

@interface UserServicePushVC ()
{
    UIButton *btnInfotips;
}

@end

@implementation UserServicePushVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"系统推送客户";
    [self.pulltable registerNib:[UINib nibWithNibName:@"CustomerTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
//    NSString *title = @"系统通过大数据为您筛选推送优质客户\n您未接收的客户，系统将在10天内自动收回";
    btnInfotips = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, [Util getHeightByWidth:3 height:1 nwidth:ScreenWidth])];
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    NewUserModel *model = appdelegate.customerBanner;
    if( model == nil || model.imgUrl == nil){
        btnInfotips.frame = CGRectMake(0, 0, ScreenWidth, 0);
    }
    else{
        [btnInfotips sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] forState:UIControlStateNormal];
//        if(!model.isRedirect)
        btnInfotips.userInteractionEnabled = NO;
        [btnInfotips addTarget:self action:@selector(doBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.pulltable.tableHeaderView = btnInfotips;
}

- (void) doBtnClicked:(UIButton *)sender
{
    AppDelegate *appdelegate = [UIApplication sharedApplication].delegate;
    NewUserModel *model = appdelegate.customerBanner;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadDataInPages:(NSInteger)page
{
    NSInteger offset = page;
    NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:filters value:@"and" key:@"groupOp"];
    NSMutableArray *rules = [[NSMutableArray alloc] init];
    UserInfoModel *user = [UserInfoModel shareUserInfoModel];
    [rules addObject:[self getRulesByField:@"userId" op:@"eq" data:user.userId]];
    [rules addObject:[self getRulesByField:@"bindType" op:@"eq" data:@"2"]];
    [rules addObject:[self getRulesByField:@"bindStatus" op:@"eq" data:@"0"]];
    [Util setValueForKeyWithDic:filters value:rules key:@"rules"];
    
    [NetWorkHandler requestQueryForPageList:offset limit:LIMIT sord:@"desc" filters:filters Completion:^(int code, id content) {
        [self refreshTable];
        [self loadMoreDataToTable];
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            if(page == 0)
                [self.data removeAllObjects];
//            [self appendData:[[content objectForKey:@"data"] objectForKey:@"rows"]];
//            self.total = [[[content objectForKey:@"data"] objectForKey:@"total"] integerValue];
            NSError *error = nil;
            NSArray *array = [MTLJSONAdapter modelsOfClass:CustomerInfoModel.class fromJSONArray:[[content objectForKey:@"data"] objectForKey:@"rows"] error:&error];
            [self.data addObjectsFromArray:array];
            self.total = [[[content objectForKey:@"data"] objectForKey:@"total"] integerValue];
            [AppContext sharedAppContext].pushCustomerNum = self.total;
            [[AppContext sharedAppContext] saveData];
            [self.pulltable reloadData];
        }
    }];
}

- (void) viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
}

- (NSDictionary *) getRulesByField:(NSString *) field op:(NSString *) op data:(NSString *) data
{
    NSMutableDictionary *rule = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:rule value:field key:@"field"];
    [Util setValueForKeyWithDic:rule value:op key:@"op"];
    [Util setValueForKeyWithDic:rule value:data key:@"data"];
    
    return rule;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.data count] == 0){
        [self showNoDatasImage:ThemeImage(@"no_data")];
    }
    else{
        [self hidNoDatasImage];
    }
    return [self.data count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
    CustomerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
        cell = [[CustomerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.btnApply.hidden = NO;
    cell.btnApply.tag = indexPath.row;
    [cell.btnApply addTarget:self action:@selector(doBtnAcceptClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    CustomerInfoModel *model = [self.data objectAtIndex:indexPath.row];
    
    cell.lbName.text = model.customerName;
    
    NSMutableString *label = [[NSMutableString alloc] init];
    for (int i = 0; i < [model.customerLabel count]; i++) {
        [label appendString:[model.customerLabel objectAtIndex:i]];
        if(i < [model.customerLabel count] - 1){
            [label appendString:@","];
        }
    }
    
    cell.lbStatus.text = label;
    cell.lbTimr.text = [Util getShowingTime:model.createdAt];

    return cell;
}

#pragma ACTION
- (void) doBtnAcceptClicked:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    CustomerInfoModel *model = [self.data objectAtIndex:tag];
    [NetWorkHandler requestToUpdateCustomerBindStatus:model.customerId userId:[UserInfoModel shareUserInfoModel].userId Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            [[NSNotificationCenter defaultCenter] postNotificationName:Notify_Insert_Customer object:model];
            [AppContext sharedAppContext].pushCustomerNum --;
            [[AppContext sharedAppContext] saveData];
            [self.data removeObject:model];
            [self.pulltable reloadData];
        }
    }];
}

@end
