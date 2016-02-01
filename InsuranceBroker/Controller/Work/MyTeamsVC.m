//
//  MyTeamsVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/31.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "MyTeamsVC.h"
#import "define.h"
#import "CustomerTableViewCell.h"
#import "PotentialPlayersVC.h"
#import "NetWorkHandler+queryForPageList.h"
#import "BrokerInfoModel.h"
#import "NetWorkHandler+queryUserTaskList.h"
#import "TasksModel.h"
#import "InviteFriendsVC.h"
#import "SelectCustomerVC.h"
#import "UIImageView+WebCache.h"

@interface MyTeamsVC ()
{
    UILabel *lbAmount;
    //renwu1
    UILabel *lbTasks1;
    UIButton *btnTasks1;
    UILabel *lbtask1Title;
    //renwu2
    UILabel *lbTasks2;
    UIButton *btnTasks2;
    UILabel *lbtask2Title;
    
    NSArray *_taskArray;
}

@end

@implementation MyTeamsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"我的团队";
    
    UIButton *btnDetail = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    [btnDetail setTitle:@"潜在队员" forState:UIControlStateNormal];
    btnDetail.layer.cornerRadius = 10;
    btnDetail.layer.borderWidth = 0.5;
    btnDetail.layer.borderColor = _COLOR(0xff, 0x66, 0x19).CGColor;
    [btnDetail setTitleColor:_COLOR(0xff, 0x66, 0x19) forState:UIControlStateNormal];
    btnDetail.titleLabel.font = _FONT(10);
    [self setRightBarButtonWithButton:btnDetail];
    
    UserInfoModel *user = [UserInfoModel shareUserInfoModel];
     CGFloat h = [Util getHeightByWidth:3 height:1 nwidth:ScreenWidth];
    UIView *headerview = nil;
    UIImageView *footview = nil;
    if(!user.leader){
        headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 155 + h)];
        UIImageView *topimg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, h)];
        topimg.image = ThemeImage(@"top_banner");
        [headerview addSubview:topimg];
        
        UIView *buttomview = [[UIView alloc] initWithFrame:CGRectMake(0, h, ScreenWidth, 115)];
        [headerview addSubview:buttomview];
        buttomview.backgroundColor = _COLOR(0x40, 0xb7, 0xf5);
        
        [self addTasksWithBg:headerview title:@"任务1:招募5名新队员" content:@"还差2名" rect:CGRectMake(0, h + 10, ScreenWidth, 30) idx:0];
        [self addTasksWithBg:headerview title:@"任务2:保单销售成交1单" content:@"还差1单" rect:CGRectMake(0, h + 60, ScreenWidth, 30) idx:1];
        
        footview = [[UIImageView alloc] initWithFrame:CGRectMake(0, h + 115, ScreenWidth, 40)];
        [headerview addSubview:footview];
        footview.image = ThemeImage(@"shadow");
        footview.userInteractionEnabled = YES;
        [self loadTasks];
        
    }else{
        headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, h)];
        UIButton *topimg = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, h)];
//        topimg.image = ThemeImage(@"top_banner-1");
        [topimg setImage:ThemeImage(@"top_banner-1") forState:UIControlStateNormal];
        [headerview addSubview:topimg];
        [topimg addTarget:self action:@selector(doBtnInviteFriend:) forControlEvents:UIControlEventTouchUpInside];
        
        footview = [[UIImageView alloc] initWithFrame:CGRectMake(0, h, ScreenWidth, 40)];
        [headerview addSubview:footview];
        footview.image = ThemeImage(@"shadow");
        footview.userInteractionEnabled = YES;
    }
    
    UILabel *lbTitle = [ViewFactory CreateLabelViewWithFont:_FONT(15) TextColor:_COLOR(0x21, 0x21, 0x21)];
    [footview addSubview:lbTitle];
    lbTitle.text = @"我的队员";
    
    UIButton *btnAbout = [[UIButton alloc] initWithFrame:CGRectZero];
    [footview addSubview:btnAbout];
    btnAbout.titleLabel.font = _FONT(10);
    [btnAbout setTitleColor:_COLOR(0x68, 0x92, 0xad) forState:UIControlStateNormal];
    [btnAbout setImage:ThemeImage(@"team_faq") forState:UIControlStateNormal];
    btnAbout.translatesAutoresizingMaskIntoConstraints = NO;
    [btnAbout addTarget:self action:@selector(doBtnAboutTeam:) forControlEvents:UIControlEventTouchUpInside];
    
    lbAmount = [ViewFactory CreateLabelViewWithFont:_FONT(12) TextColor:_COLOR(0xcc, 0xcc, 0xcc)];
    [footview addSubview:lbAmount];
    lbAmount.textAlignment = NSTextAlignmentRight;
    lbAmount.text = @"共3人";
    
    NSDictionary *views = NSDictionaryOfVariableBindings(lbTitle, lbAmount, btnAbout);
    [footview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[lbTitle]-6-[btnAbout]->=10-[lbAmount]-20-|" options:0 metrics:nil views:views]];
    [footview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[lbTitle]-0-|" options:0 metrics:nil views:views]];
    [footview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[btnAbout]-0-|" options:0 metrics:nil views:views]];
    [footview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[lbAmount]-0-|" options:0 metrics:nil views:views]];
    
    
    self.pulltable.tableHeaderView = headerview;
    [self.pulltable registerNib:[UINib nibWithNibName:@"CustomerTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    self.pulltable.backgroundColor = [UIColor clearColor];
    self.pulltable.tableFooterView = [[UIView alloc] init];
}

- (void) doBtnInviteFriend:(UIButton *)sender
{
    if([self login]){
        InviteFriendsVC *vc = [[InviteFriendsVC alloc] initWithNibName:nil bundle:nil];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void) addTasksWithBg:(UIView *)bgview title:(NSString *) title content:(NSString *) content rect: (CGRect) rect idx:(NSInteger) idx
{
    UILabel *lbTitle = [ViewFactory CreateLabelViewWithFont:_FONT(12) TextColor:_COLOR(0xff, 0xff, 0xff)];
    [bgview addSubview:lbTitle];
    lbTitle.text = title;
    lbTitle.translatesAutoresizingMaskIntoConstraints = YES;
    lbTitle.frame = CGRectMake(20, rect.origin.y, 140, rect.size.height);
    
    UIButton *btn = [[UIButton alloc] init];
    [bgview addSubview:btn];
    btn.layer.cornerRadius = 3;
    btn.frame = CGRectMake(ScreenWidth - 95, rect.origin.y, 75, rect.size.height);
    btn.backgroundColor = [UIColor whiteColor];
    btn.titleLabel.font = _FONT(12);
    btn.hidden = YES;
    
    UILabel *lbContent = [ViewFactory CreateLabelViewWithFont:_FONT(12) TextColor:_COLOR(0xff, 0xff, 0xff)];
    [bgview addSubview:lbContent];
    lbContent.textAlignment = NSTextAlignmentRight;
    lbContent.text = content;
    lbContent.translatesAutoresizingMaskIntoConstraints = YES;
    lbContent.frame = CGRectMake(ScreenWidth - 95 - 90, rect.origin.y, 70, rect.size.height-10);
    if(idx == 0){
        lbTasks1 = lbContent;
        btnTasks1 = btn;
        lbtask1Title = lbTitle;
        [btn addTarget:self action:@selector(doBtnShare:) forControlEvents:UIControlEventTouchUpInside];
    }
    else{
        lbTasks2 = lbContent;
        btnTasks2 = btn;
        lbtask2Title = lbTitle;
        [btn addTarget:self action:@selector(doBtnOrdered:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void) loadTasks
{
    [NetWorkHandler requestToQueryUserTaskList:[UserInfoModel shareUserInfoModel].userId Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            _taskArray = [TasksModel modelArrayFromArray:[[content objectForKey:@"data"] objectForKey:@"rows"]];
            [self initTaskData];
        }
    }];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void) doBtnAboutTeam:(id) sender
{
    WebViewController *web = [IBUIFactory CreateWebViewController];
    web.title = @"关于团队";
    [self.navigationController pushViewController:web animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@%@%@", SERVER_ADDRESS, @"/news/view/", ABOUT_TEAM];
    [web loadHtmlFromUrl:url];
}

//添加任务
- (void) initTaskData
{
    if([_taskArray count] >= 2){
        TasksModel *model = [_taskArray objectAtIndex:0];
        lbtask1Title.text = [NSString stringWithFormat:@"任务1:招募%d名新队员", (int)model.taskLimit];
        lbTasks1.attributedText = [self attstringWithString:[NSString stringWithFormat:@"还差%d名", (int)( model.taskFinish)] substr:[NSString stringWithFormat:@"%d", (int)( model.taskFinish)] font:_FONT(24) color:_COLOR(0xff, 0xee, 0x00)];
        btnTasks1.hidden = NO;
        if( model.taskFinish <= 0){
            [btnTasks1 setTitle:@"已完成" forState:UIControlStateNormal];
            [btnTasks1 setTitleColor:_COLOR(0xe6, 0xe6, 0xe6) forState:UIControlStateNormal];
            btnTasks1.backgroundColor = _COLOR(0x99, 0x99, 0x99);
            btnTasks1.userInteractionEnabled = NO;
        }else{
            [btnTasks1 setTitle:@"立即招募" forState:UIControlStateNormal];
            [btnTasks1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btnTasks1.backgroundColor = _COLOR(0xff, 0x66, 0x19);
            btnTasks1.userInteractionEnabled = YES;
        }
        
        TasksModel *model2 = [_taskArray objectAtIndex:1];
        lbtask2Title.text = [NSString stringWithFormat:@"任务2:保单销售成交%d单", (int)model2.taskLimit];
        lbTasks2.attributedText = [self attstringWithString:[NSString stringWithFormat:@"还差%d单", (int)( model2.taskFinish)] substr:[NSString stringWithFormat:@"%d", (int)( model2.taskFinish)] font:_FONT(24) color:_COLOR(0xff, 0xee, 0x00)];
        btnTasks2.hidden = NO;
        if(model2.taskFinish <= 0){
            [btnTasks2 setTitle:@"已完成" forState:UIControlStateNormal];
            [btnTasks2 setTitleColor:_COLOR(0xe6, 0xe6, 0xe6) forState:UIControlStateNormal];
            btnTasks2.backgroundColor = _COLOR(0x99, 0x99, 0x99);
            btnTasks2.userInteractionEnabled = NO;
        }else{
            [btnTasks2 setTitle:@"立即下单" forState:UIControlStateNormal];
            [btnTasks2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btnTasks2.backgroundColor = _COLOR(0xff, 0x66, 0x19);
            btnTasks2.userInteractionEnabled = YES;
        }
    }
}

- (NSMutableAttributedString *) attstringWithString:(NSString *) string substr:(NSString *) substr font:(UIFont *) font color:(UIColor *)color
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSRange range = [string rangeOfString:substr];
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
    [attributedString addAttribute:NSFontAttributeName value:font range:range];
    
    return attributedString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) handleRightBarButtonClicked:(id)sender
{
    PotentialPlayersVC *vc = [[PotentialPlayersVC alloc] initWithNibName:nil bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) loadDataInPages:(NSInteger)page
{
    NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:filters value:@"and" key:@"groupOp"];
    NSMutableArray *rules = [[NSMutableArray alloc] init];
    UserInfoModel *user = [UserInfoModel shareUserInfoModel];
//    [rules addObject:[self getRulesByField:@"userId" op:@"eq" data:user.userId]];
    [rules addObject:[self getRulesByField:@"parentUserId" op:@"eq" data:user.userId]];
    [Util setValueForKeyWithDic:filters value:rules key:@"rules"];
    
    [NetWorkHandler requestUserQueryForPageList:page limit:LIMIT sord:@"desc" sidx:@"S_StatisticsMonth.monthTotalIn" filters:filters Completion:^(int code, id content) {
        [self refreshTable];
        [self loadMoreDataToTable];
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            if(page == 0){
                [self.data removeAllObjects];
            }
            [self.data addObjectsFromArray:[BrokerInfoModel modelArrayFromArray:[[content objectForKey:@"data"] objectForKey:@"rows"]]];
            self.total = [[[content objectForKey:@"data"] objectForKey:@"total"] integerValue];
            lbAmount.text = [NSString stringWithFormat:@"共%d人", self.total];
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

#pragma UITableViewDataSource

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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    BrokerInfoModel *model = [self.data objectAtIndex:indexPath.row];
    
    cell.timerWidth.constant = 0;
    
    UIImage *image = ThemeImage(@"list_user_head");
    if(model.userSex == 2)
    {
        image = ThemeImage(@"list_user_famale");
    }
//    if(model.sex == 2)
//        image = ThemeImage(@"list_user_famale");
//    cell.photoImage.image = image;
    [cell.photoImage sd_setImageWithURL:[NSURL URLWithString:model.headerImg] placeholderImage:image];
    cell.logoImage.hidden = NO;
    if(indexPath.row == 0)
        cell.logoImage.image = ThemeImage(@"award_1");
    else if(indexPath.row == 1)
        cell.logoImage.image = ThemeImage(@"award_02");
    else if (indexPath.row == 2)
        cell.logoImage.image = ThemeImage(@"award_03");
    else
        cell.logoImage.hidden = YES;
    cell.lbTimr.hidden = YES;
    cell.lbName.text = model.userName;
    cell.lbStatus.text = [NSString stringWithFormat:@"上月收益：%@元", model.monthOrderEarn];
    cell.lbStatus.textColor = _COLOR(0xcc, 0xcc, 0xcc);
    cell.lbStatus.font = _FONT(12);
    cell.width.constant = 16;
    cell.height.constant = 16;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void) doBtnShare:(UIButton *)sender
{
    InviteFriendsVC *vc = [[InviteFriendsVC alloc] initWithNibName:nil bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) doBtnOrdered:(UIButton *)sender
{
    SelectCustomerVC *vc = [[SelectCustomerVC alloc] initWithNibName:nil bundle:nil];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) showNoDatasImage:(UIImage *) image
{
    if(!self.explainBgView){
        self.explainBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 80)];
        self.imgWithNoData = [[UIImageView alloc] initWithImage:image];
        [self.explainBgView addSubview:self.imgWithNoData];
        [self.pulltable addSubview:self.explainBgView];
        self.explainBgView.center = CGPointMake(ScreenWidth/2, self.pulltable.frame.size.height*5/7);
    }else{
        self.explainBgView.center = CGPointMake(ScreenWidth/2, self.pulltable.frame.size.height*5/7);
    }
}

@end
