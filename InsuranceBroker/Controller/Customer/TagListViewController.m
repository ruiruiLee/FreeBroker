//
//  TagListViewController.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/23.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "TagListViewController.h"
#import "define.h"
#import "TagListViewCell.h"
#import "NetWorkHandler+queryForLabelPageList.h"
#import "TagObjectModel.h"

@interface TagListViewController ()

@property (nonatomic, copy) NSArray *data;
@property (nonatomic, copy) NSArray *serviceArray;
@property (nonatomic, copy) NSArray *myArray;

@end

@implementation TagListViewController

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"所有标签";
    [self SetRightBarButtonWithTitle:@"新建" color:_COLOR(0xff, 0x66, 0x19) action:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refrushTagList:) name:Notify_Refrush_TagList object:nil];
    
    [self.tableview registerNib:[UINib nibWithNibName:@"TagListViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tableview setSeparatorColor:_COLOR(0xe6, 0xe6, 0xe6)];
    self.tableview.backgroundColor = [UIColor clearColor];
//    if([[TagObjectModel shareTagList] count] == 0){
        [self loadData];
//    }else{
//        self.data = [TagObjectModel shareTagList];
//    }
}

- (void) refrushTagList:(NSNotification *) notify
{
    [self loadData];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.data = [TagObjectModel shareTagList];
    [self.tableview reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) handleRightBarButtonClicked:(id)sender
{
    EditTagVC *vc = [IBUIFactory CreateEditTagViewController];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) loadData
{
    [NetWorkHandler requestToQueryForLabelPageList:1 Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            NSError *error = nil;
            self.data = [MTLJSONAdapter modelsOfClass:TagObjectModel.class fromJSONArray:[[content objectForKey:@"data"] objectForKey:@"rows"] error:&error];
            [[TagObjectModel shareTagList] removeAllObjects];
            [[TagObjectModel shareTagList] addObjectsFromArray:self.data];
            [self.tableview reloadData];
        }
    }];
}

#pragma UITableViewDataSource UITableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return [self.serviceArray count];
    }
    else{
        return [self.myArray count];
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54.f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
    TagListViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
//        cell = [[TagListViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"TagListViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
    }
    if(indexPath.section == 0){
        TagObjectModel *model = [self.serviceArray objectAtIndex:indexPath.row];
        cell.lbName.text = model.labelName;
        cell.lbAmount.text = [NSString stringWithFormat:@"（%@）", model.labelCustomerNums];
    }
    else{
        TagObjectModel *model = [self.myArray objectAtIndex:indexPath.row];
        cell.lbName.text = model.labelName;
        cell.lbAmount.text = [NSString stringWithFormat:@"（%@）", model.labelCustomerNums];
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    EditTagVC *vc = [IBUIFactory CreateEditTagViewController];
    [self.navigationController pushViewController:vc animated:YES];
    if(indexPath.section == 0){
        vc.labelModel = [self.serviceArray objectAtIndex:indexPath.row];
    }
    else{
        vc.labelModel = [self.myArray objectAtIndex:indexPath.row];
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 30)];
    view.image = ThemeImage(@"shadow");
    
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(20, 8, ScreenWidth - 40, 20)];
    [view addSubview:lb];
    lb.backgroundColor = [UIColor clearColor];
    lb.font = _FONT(12);
    lb.textColor = _COLOR(0x75, 0x75, 0x75);
    if(section == 0)
        lb.text = @"系统标签";
    else
        lb.text = @"自定义标签";
    
    return view;
}

- (NSArray *) getServiceStaticLabel:(NSArray *) root
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < [root count]; i++) {
        TagObjectModel *model = [root objectAtIndex:i];
        if(model.labelType == 1)
            [array addObject:model];
    }
    
    return array;
}

- (NSArray *) getUserLabel:(NSArray *) root
{
    NSString *userId = [UserInfoModel shareUserInfoModel].userId;
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i < [root count]; i++) {
        TagObjectModel *model = [root objectAtIndex:i];
        if(model.labelType == 2 && [userId isEqualToString:model.userId])
            [array addObject:model];
    }
    
    return array;
}

- (void) setData:(NSArray *)array
{
    _data = [array copy];
    self.myArray = [self getUserLabel:array];
    self.serviceArray = [self getServiceStaticLabel:array];
    
}

@end
