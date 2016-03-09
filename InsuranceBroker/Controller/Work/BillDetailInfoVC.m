//
//  BillDetailInfoVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/3/1.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BillDetailInfoVC.h"
#import "define.h"
#import "BIllDetailTableViewCell.h"
#import "NetWorkHandler+queryUserBillDetail.h"

@interface BillDetailInfoVC ()

@end

@implementation BillDetailInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"账单详情";
    
    [self initHeaderView];
    self.tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"BIllDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableview setSeparatorInset:insets];
    }
    if ([self.tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableview setLayoutMargins:insets];
    }
    
    [self initData];
}

- (void) initHeaderView
{
    self.headView = [[GradientView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 120)];
    
    self.lbTotalAmount = [ViewFactory CreateLabelViewWithFont:_FONT(40) TextColor:_COLOR(255, 255, 255)];
    self.lbTotalAmount.textAlignment = NSTextAlignmentCenter;
    self.lbTotalAmount.frame = CGRectMake(0, 0, ScreenWidth, 120);
    self.lbTotalAmount.translatesAutoresizingMaskIntoConstraints = YES;
    [self.headView addSubview:self.lbTotalAmount];
    
    self.tableview.tableHeaderView = self.headView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.headView setGradientColor:_COLOR(0xff, 0x8c, 0x19) end:_COLOR(0xff, 0x66, 0x19)];
}

- (void) loadData
{
    if(!self.billInfo.isLoadDetail){
        [NetWorkHandler requestToQueryUserBillDetail:self.billInfo.billId Completion:^(int code, id content) {
            [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
            if(code == 200){
                [self.billInfo setContentFromDictionary:[content objectForKey:@"data"]];
                [self initData];
                self.billInfo.isLoadDetail = YES;
                [self.tableview reloadData];
            }
        }];
    }
}

- (void) initData
{
    
}

- (void) addObjectToArray:(NSMutableArray *) array object:(NSString *) object
{
    if(object == nil){
        [array addObject:@""];
    }else
        [array addObject:object];
}

- (void) setDataForWithdraw
{
    NSArray *title = @[@"提现帐户",@"提现进度",@"创建时间"];
    NSMutableArray *content = [[NSMutableArray alloc] init];
    [self addObjectToArray:content object:self.billInfo.memo];
    [self addObjectToArray:content object:self.billInfo.auditStatus];
    [self addObjectToArray:content object:[Util getTimeString:self.billInfo.createdAt]];
    self.titleArray = title;
    self.contentArray = content;
}

- (void) setDataFromSub
{
    NSArray *title = @[@"收益信息",@"成交时间"];
//    NSArray *content = @[self.billInfo.memo, [Util getTimeString:self.billInfo.createdAt]];
    NSMutableArray *content = [[NSMutableArray alloc] init];
    [self addObjectToArray:content object:self.billInfo.memo];
    [self addObjectToArray:content object:[Util getTimeString:self.billInfo.createdAt]];
    self.titleArray = title;
    self.contentArray = content;
}

- (void) setDataFromOrder
{
    NSArray *title = @[@"收益信息",@"创建时间", @"佣金比例", @"客户优惠"];
    NSMutableArray *content = [[NSMutableArray alloc] init];
    [self addObjectToArray:content object:self.billInfo.memo];
    [self addObjectToArray:content object:[Util getTimeString:self.billInfo.createdAt]];
    [self addObjectToArray:content object:[NSString stringWithFormat:@"%d%@", (int)self.billInfo.productMaxRatio, @"%"]];
    [self addObjectToArray:content object:[NSString stringWithFormat:@"%d%@", (int)self.billInfo.planUkbRatio, @"%"]];
    self.titleArray = title;
    self.contentArray = content;
}

- (void) setDataFromLucky
{
    NSArray *title = @[@"收益信息", @"创建时间"];
//    NSArray *content = @[self.billInfo.memo, [Util getTimeString:self.billInfo.createdAt]];
    NSMutableArray *content = [[NSMutableArray alloc] init];
    [self addObjectToArray:content object:self.billInfo.memo];
    [self addObjectToArray:content object:[Util getTimeString:self.billInfo.createdAt]];
    self.titleArray = title;
    self.contentArray = content;
}

#pragma data
- (void) setTitleArray:(NSArray *)array
{
    _titleArray = array;
    [self.tableview reloadData];
}

- (void) setContentArray:(NSArray *)array
{
    _contentArray = array;
    [self.tableview reloadData];
}

#pragma datasource
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.titleArray count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
    BIllDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"BIllDetailTableViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lbTitle.text = [self.titleArray objectAtIndex:indexPath.row];
    if([self.contentArray count] > indexPath.row)
        cell.lbDetail.text = [self.contentArray objectAtIndex:indexPath.row];
    
    return cell;
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
