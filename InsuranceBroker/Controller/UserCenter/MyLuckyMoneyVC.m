//
//  MyLuckyMoneyVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/22.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "MyLuckyMoneyVC.h"
#import "LucyMoneyTableCell.h"
#import "define.h"
#import "NetWorkHandler+queryRedPackList.h"
#import "RedPackModel.h"
#import "UIImageView+WebCache.h"
#import "NetWorkHandler+getRedPack.h"
#import "RedPackInfoTips.h"
#import "RedPackTasksInfoTips.h"

@interface MyLuckyMoneyVC ()

@end

@implementation MyLuckyMoneyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.pulltable.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.pulltable.separatorColor = _COLOR(0xe6, 0xe6, 0xe6);
    [self.pulltable registerNib:[UINib nibWithNibName:@"LucyMoneyTableCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    UIView *foot = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    UIView *left = [[UIView alloc] initWithFrame:CGRectZero];
    left.translatesAutoresizingMaskIntoConstraints = NO;
    [foot addSubview:left];
    UIImageView *logo = [[UIImageView alloc] initWithImage:ThemeImage(@"smile")];
    [foot addSubview:logo];
    logo.translatesAutoresizingMaskIntoConstraints = NO;
    UILabel *lb = [ViewFactory CreateLabelViewWithFont:_FONT(12) TextColor:_COLOR(0xcc, 0xcc, 0xcc)];
    [foot addSubview:lb];
    lb.text = @"更多红包奖励陆续推出中，敬请期待";
    UIView *right = [[UIView alloc] initWithFrame:CGRectZero];
    right.translatesAutoresizingMaskIntoConstraints = NO;
    [foot addSubview:right];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(left, logo, lb, right);
    [foot addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[left]-0-[logo]-0-[lb]-0-[right]-0-|" options:0 metrics:nil views:views]];
    [foot addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[left]-0-|" options:0 metrics:nil views:views]];
    [foot addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[lb]-0-|" options:0 metrics:nil views:views]];
    [foot addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[right]-0-|" options:0 metrics:nil views:views]];
    [foot addConstraint:[NSLayoutConstraint constraintWithItem:left attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:right attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
    [foot addConstraint:[NSLayoutConstraint constraintWithItem:logo attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:lb attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
    self.pulltable.tableFooterView = foot;
    
    [AppContext sharedAppContext].isRedPack = NO;
    [[AppContext sharedAppContext] saveData];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadDataInPages:(NSInteger)page
{
    NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:filters value:@"and" key:@"groupOp"];
    NSMutableArray *rules = [[NSMutableArray alloc] init];
    UserInfoModel *user = [UserInfoModel shareUserInfoModel];
    [rules addObject:[self getRulesByField:@"userId" op:@"eq" data:user.userId]];
    [Util setValueForKeyWithDic:filters value:rules key:@"rules"];
    
    [NetWorkHandler requestToQueryRedPackList:page limit:LIMIT sidx:@"seqNo" sord:@"asc" userId:[UserInfoModel shareUserInfoModel].userId filters:filters Completion:^(int code, id content) {
        [self refreshTable];
        [self loadMoreDataToTable];
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            if(page == 0)
                [self.data removeAllObjects];
            [self.data addObjectsFromArray:[RedPackModel modelArrayFromArray:[[content objectForKey:@"data"] objectForKey:@"rows"]]];
            self.total =  [[[content objectForKey:@"data"] objectForKey:@"total"] integerValue];
            [self.pulltable reloadData];
        }
    }];
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
        UIView *footer = self.pulltable.tableFooterView;
        footer.hidden = YES;
    }
    else{
        [self hidNoDatasImage];
        UIView *footer = self.pulltable.tableFooterView;
        footer.hidden = NO;
    }
    return [self.data count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 103.f;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
    LucyMoneyTableCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
        cell = [[LucyMoneyTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell.btnReceive addTarget:self action:@selector(doBtnReceive:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnReceive.tag = 100+indexPath.row;
    
    RedPackModel *model = [self.data objectAtIndex:indexPath.row];
    cell.lbTitle.text = model.redPackTitle;
    cell.lbExplain.text = model.redPackRuleMemo;
    cell.lbAmount.text = [NSString stringWithFormat:@"%d", (int) model.redPackValue];
    if(model.redPackUserStatus == 0){
        [cell.btnReceive setTitle:@"领取" forState:UIControlStateNormal];
        cell.btnReceive.backgroundColor = _COLOR(0xff, 0x66, 0x19);
        cell.btnReceive.userInteractionEnabled = YES;
    }
    else{
        [cell.btnReceive setTitle:@"已领取" forState:UIControlStateNormal];
        cell.btnReceive.backgroundColor = _COLOR(0xcb, 0xcb, 0xcb);
        cell.btnReceive.userInteractionEnabled = NO;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) doBtnReceive:(UIButton *)sender
{
    RedPackModel *model = [self.data objectAtIndex:sender.tag - 100];
    [NetWorkHandler requestToGetRedPack:model.redPackId userId:[UserInfoModel shareUserInfoModel].userId Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code){
            NSInteger redPackUserId = [[content objectForKey:@"data"] integerValue];
            if(redPackUserId == 1){
                RedPackInfoTips *tips = [[RedPackInfoTips alloc] init];
                model.redPackUserStatus = 1;
                [tips show];
            }else{
                RedPackTasksInfoTips *tips = [[RedPackTasksInfoTips alloc] initWithTaskName:model.redPackRuleMemo];
                [tips show];
            }
            [self.pulltable reloadData];
        }
    }];
}

@end
