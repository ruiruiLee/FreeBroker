//
//  BaseTableViewController.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/23.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "BaseTableViewController.h"
#import "define.h"

@interface BaseTableViewController ()

@end

@implementation BaseTableViewController
@synthesize tableview;
@synthesize imgWithNoData;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubViews];
    [self loadData];
}

- (void) initSubViews
{
    tableview = [[UITableView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableview.translatesAutoresizingMaskIntoConstraints = NO;
    tableview.backgroundColor = [UIColor clearColor];//_COLOR(242, 242, 242);//TableBackGroundColor;
    tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableview.separatorColor = _COLOR(0xe6, 0xe6, 0xe6);
    
    tableview.tableFooterView = [[UIView alloc] init];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 20, 0, 20);
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

#pragma UITableViewDataSource UITableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
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
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 20, 0, 20);
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:insets];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:insets];
    }
}

- (void) loadData
{
    NSLog(@"loadData");
}

- (void) showNoDatasImage:(UIImage *) image
{
    if(!self.explainBgView){
        self.explainBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 80)];
        imgWithNoData = [[UIImageView alloc] initWithImage:image];
        [self.explainBgView addSubview:imgWithNoData];
        [self.tableview addSubview:self.explainBgView];
        self.explainBgView.center = CGPointMake(ScreenWidth/2, self.tableview.frame.size.height/2);
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
