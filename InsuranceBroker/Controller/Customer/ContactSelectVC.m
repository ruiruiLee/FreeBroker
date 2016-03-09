//
//  ContactSelectVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/23.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "ContactSelectVC.h"
#import "define.h"
#import "CustomerTableViewCell.h"
#import "CustomerInfoModel.h"
#import "NetWorkHandler+queryForPageList.h"
#import "ObjectButton.h"

@interface ContactSelectVC ()
{
    UIScrollView *_scrollview;
    UIView *_scrollBgView;
    
    UISearchDisplayController *searchDisplayController;
    NSString *filterString;
    
    NSMutableArray *_selectArray;
    NSMutableArray *_searchedArray;//searchdisplay数组
    
    NSMutableArray *_selectViewArray;
    
    NSLayoutConstraint *__scrollHConstraint;
}

@end

@implementation ContactSelectVC
@synthesize searchbar;
@synthesize delegate;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        filterString = @"";
        _selectArray = [[NSMutableArray alloc] init];
        _selectViewArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择联系人";
    
    self.resultData = [[NSMutableArray alloc] init];
    
    [self SetRightBarButtonWithTitle:@"确定" color:_COLORa(0xff, 0x66, 0x19, 1) action:YES];
    
    [self.pulltable registerNib:[UINib nibWithNibName:@"CustomerTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    searchbar.placeholder = @"搜索";
    [searchbar sizeToFit];
    searchbar.showsCancelButton = YES;
    self.pulltable.tableHeaderView = searchbar;
//    searchbar.delegate = self;
    
    searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchbar contentsController:self];
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    searchDisplayController.delegate = self;
    [searchDisplayController.searchResultsTableView registerNib:[UINib nibWithNibName:@"CustomerTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
}

- (void) initSubViews
{
    self.pulltable = [[PullTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 580)];
    PullTableView *pulltable = self.pulltable;
    [self.view addSubview:pulltable];
    pulltable.delegate = self;
    pulltable.dataSource = self;
    pulltable.pullDelegate = self;
    pulltable.separatorStyle = UITableViewCellSeparatorStyleNone;
    pulltable.translatesAutoresizingMaskIntoConstraints = NO;
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
    
    _scrollview = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:_scrollview];
    _scrollview.translatesAutoresizingMaskIntoConstraints = NO;
    
    _scrollBgView = [[UIView alloc] initWithFrame:CGRectZero];
    [_scrollview addSubview:_scrollBgView];
    _scrollBgView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //弹出下拉刷新控件刷新数据
    pulltable.pullTableIsRefreshing = YES;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(pulltable, _scrollview, _scrollBgView);
    
    self.vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[pulltable]-0-[_scrollview(85)]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:self.vConstraints];
    self.hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[pulltable]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:self.hConstraints];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_scrollview]-0-|" options:0 metrics:nil views:views]];
    
    [_scrollview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[_scrollBgView]-0-|" options:0 metrics:nil views:views]];
    [_scrollview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[_scrollBgView(85)]-0-|" options:0 metrics:nil views:views]];
    __scrollHConstraint = [NSLayoutConstraint constraintWithItem:_scrollBgView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0];
    [_scrollview addConstraint:__scrollHConstraint];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) handleLeftBarButtonClicked:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) handleRightBarButtonClicked:(id)sender
{
    if(delegate && [delegate respondsToSelector:@selector(NotifyItemChanged:ChangedItems:isDelOrAdd:)]){
        [delegate NotifyItemChanged:self ChangedItems:self.resultData isDelOrAdd:self.type];
    }
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma UITableViewDataSource UITableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.pulltable){
        if([self.data count] == 0){
            [self showNoDatasImage:ThemeImage(@"no_data")];
        }
        else{
            [self hidNoDatasImage];
        }
        return [self.data count];
    }else
        return [_searchedArray count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell1";
    CustomerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
//        cell = [[CustomerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"CustomerTableViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
    }
    UIView *view = cell.accessoryView;
    
    if(view == nil || ![view isKindOfClass:[UIButton class]]){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        ObjectButton *btn = [[ObjectButton alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
        [btn setImage:ThemeImage(@"unselect") forState:UIControlStateNormal];
        [btn setImage:ThemeImage(@"select") forState:UIControlStateSelected];
        cell.accessoryView = btn;
        [btn addTarget:self action:@selector(doBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    CustomerInfoModel *model = nil;
    if(tableView == self.pulltable){
        model = [self.data objectAtIndex:indexPath.row];
    }else{
        model = [_searchedArray objectAtIndex:indexPath.row];
    }
//    CustomerInfoModel *model = [self.data objectAtIndex:indexPath.row];
    ObjectButton *btn = (ObjectButton*)cell.accessoryView;
    btn.object = model;
    cell.lbName.text = model.customerName;
    cell.lbStatus.text = model.visitType;
    cell.lbTimr.hidden = YES;
    if(!model.isAgentCreate)
        cell.logoImage.hidden = NO;
    else
        cell.logoImage.hidden = YES;
    
    BOOL rawData = [self isRawData:model];
    if(rawData){
        btn.userInteractionEnabled = NO;
        [btn setImage:ThemeImage(@"select_gray") forState:UIControlStateNormal];
    }else{
        btn.userInteractionEnabled = YES;
        [btn setImage:ThemeImage(@"select") forState:UIControlStateSelected];
        [btn setImage:ThemeImage(@"unselect") forState:UIControlStateNormal];
        
        if([self isSelectedData:model]){
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    CustomerTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    ObjectButton *btn = (ObjectButton *)cell.accessoryView;
    [self doBtnClicked:btn];
}

- (void) doBtnClicked:(ObjectButton *)sender
{
    BOOL selected = sender.selected;
    sender.selected = !selected;
    if(selected){
        [self.resultData removeObject:sender.object];
    }else{
        [self.resultData addObject:sender.object];
    }
    
    [self resetSelectItems];
}

- (void) resetSelectItems
{
    for (int i = 0; i < [_selectViewArray count]; i++) {
        UIView *view = [_selectViewArray objectAtIndex:i];
        [view removeFromSuperview];
    }
    [_selectViewArray removeAllObjects];
    
    CGFloat ox = 10;
    for (int i = 0; i < [self.resultData count]; i++) {
        CustomerInfoModel *model = [self.resultData objectAtIndex:i];
        
        TopImageButton *btn = [[TopImageButton alloc] initWithFrame:CGRectMake(ox, 5, 55, 75)];
        [btn setImage:ThemeImage(@"user_head") forState:UIControlStateNormal];
        [btn setTitle:model.customerName forState:UIControlStateNormal];
        [btn setTitleColor:_COLOR(0x21, 0x21, 0x21) forState:UIControlStateNormal];
        btn.titleLabel.font = _FONT(14);
        btn.userInteractionEnabled = NO;
//        btn.object = model;
        [_scrollBgView addSubview:btn];
        [_selectViewArray addObject:btn];
//        [btn addTarget:self action:@selector(doBtnViewItemInfo:) forControlEvents:UIControlEventTouchUpInside];
        
        ox += 75;
    }
    
    __scrollHConstraint.constant = ox - 10;
}

//- (void) doBtnViewItemInfo:(ObjectButton *) sender
//{
//    CustomerInfoModel *model = sender.object;
//    CustomerDetailVC *vc = [IBUIFactory CreateCustomerDetailViewController];
//    [self.navigationController pushViewController:vc animated:YES];
//    [vc performSelector:@selector(loadDetailWithCustomerId:) withObject:model.customerId afterDelay:0.2];
//}

- (NSMutableArray *) getItemsByKey:(NSString *) key
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [self.data count]; i++) {
        CustomerInfoModel *model = [self.data objectAtIndex:i];
        
        if([model.customerName rangeOfString:key].length > 0){
            [result addObject:model];
        }
        
    }
    
    return result;
}

//UISearchDisplayController
- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    _searchedArray = [self getItemsByKey:searchString];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    return YES;
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller{
    /*
     Bob: Because the searchResultsTableView will be released and allocated automatically, so each time we start to begin search, we set its delegate here.
     */
    [searchDisplayController.searchResultsTableView setDelegate:self];
    
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller{
    
    [searchbar resignFirstResponder];
    [self.pulltable reloadData];
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
//    searchbar.text = @"";
//    filterString = @"";
//    self.pageNum = 0;
//    [self loadDataInPages:self.pageNum];
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

//匹配是否选中

- (BOOL) isRawData:(CustomerInfoModel *)customer
{
    for (int i = 0; i < [self.rawData count]; i++) {
        CustomerInfoModel *model = [self.rawData objectAtIndex:i];
        if([model.customerId isEqualToString:customer.customerId])
            return YES;
    }
    
    return NO;
}

- (BOOL) isSelectedData:(CustomerInfoModel *) model
{
    for (int i = 0; i < [self.resultData count]; i++) {
        CustomerInfoModel *customer = [self.resultData objectAtIndex:i];
        if([customer.customerId isEqualToString:model.customerId])
            return YES;
    }
    
    return NO;
}

- (void) showNoDatasImage:(UIImage *) image
{
    if(!self.explainBgView){
        self.explainBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 80)];
        self.imgWithNoData = [[UIImageView alloc] initWithImage:image];
        [self.explainBgView addSubview:self.imgWithNoData];
        [self.pulltable addSubview:self.explainBgView];
        self.explainBgView.center = CGPointMake(ScreenWidth/2, self.pulltable.frame.size.height/2 + 42);
    }else{
        self.explainBgView.center = CGPointMake(ScreenWidth/2, self.pulltable.frame.size.height/2 + 42);
    }
}

@end
