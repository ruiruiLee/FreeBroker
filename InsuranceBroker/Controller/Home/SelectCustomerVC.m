//
//  SelectCustomerVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/18.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "SelectCustomerVC.h"
#import "CustomerTableViewCell.h"
#import "define.h"
#import "NetWorkHandler+queryForPageList.h"
#import "NetWorkHandler+queryForCustomerCarPageList.h"
#import "CTPopOutMenu.h"
#import "CarInfoModel.h"
#import "BackGroundView.h"
#import "OrderWebVC.h"

@interface SelectCustomerVC () <CTPopoutMenuDelegate, BackGroundViewDelegate>
{
    UISearchDisplayController *searchDisplayController;
    NSString *filterString;
    NSMutableArray *_searchedArray;//searchdisplay数组
    
    BackGroundView *_addview;
}

@property (nonatomic) CTPopoutMenu * popMenu;

@end

@implementation SelectCustomerVC
@synthesize searchbar;

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        filterString = @"";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择客户";
    [self setRightBarButtonWithImage:ThemeImage(@"add")];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyCustomerAdd:) name:Notify_Add_NewCustomer object:nil];
    
    [self.pulltable registerNib:[UINib nibWithNibName:@"CustomerTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
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
    [searchDisplayController.searchResultsTableView registerNib:[UINib nibWithNibName:@"CustomerTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void) notifyCustomerAdd:(NSNotification *) notify
{
    [self pullTableViewDidTriggerRefresh:self.pulltable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) handleRightBarButtonClicked:(id)sender
{
    NewCustomerVC *vc = [IBUIFactory CreateNewCustomerViewController];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.presentvc = self;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.pulltable){
        
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
        
        return [self.data count];
    }else{
        [_addview removeFromSuperview];
        return [_searchedArray count];
    }
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
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"CustomerTableViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
    }
    
    CustomerInfoModel *model = nil;
    if(tableView == self.pulltable){
        model = [self.data objectAtIndex:indexPath.row];
    }else{
        model = [_searchedArray objectAtIndex:indexPath.row];
    }
    
    cell.lbName.text = model.customerName;
    cell.lbStatus.text = model.visitType;
    cell.lbTimr.text = [Util getShowingTime:model.updatedAt];//@"今天 19:08";
    if(!model.isAgentCreate)
        cell.logoImage.hidden = NO;
    else
        cell.logoImage.hidden = YES;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    [ProgressHUD show:nil];
    CustomerInfoModel *model = [self.data objectAtIndex:indexPath.row];
    [self loadCarInfo:model.customerId Completion:^(int code, id content) {
        [ProgressHUD dismiss];
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            NSArray *array = [CarInfoModel modelArrayFromArray:[[content objectForKey:@"data"] objectForKey:@"rows"]];
            if([array count] > 0){
//                self.popMenu = [[CTPopoutMenu alloc]initWithTitle:@"选择报价的车牌号" message:@"" items:array];
//                self.popMenu.delegate = self;
//                self.popMenu.menuStyle = MenuStyleList;
//                [self.popMenu showMenuInParentViewController:self withCenter:self.view.center];
                CarInfoModel *car = [array objectAtIndex:0];
                OrderWebVC *web = [[OrderWebVC alloc] initWithNibName:@"OrderWebVC" bundle:nil];
                web.title = @"报价";
                [self.navigationController pushViewController:web animated:YES];
                NSString *url = [NSString stringWithFormat:@"%@/car_insur/car_insur_plan.html?clientKey=%@&userId=%@&customerId=%@&customerCarId=%@", Base_Uri, [UserInfoModel shareUserInfoModel].clientKey, [UserInfoModel shareUserInfoModel].userId, model.customerId, car.customerCarId];
                [web loadHtmlFromUrl:url];

            }
            else{
                CustomerDetailVC *detail = [IBUIFactory CreateCustomerDetailViewController];
                [self.navigationController pushViewController:detail animated:YES];
                detail.customerinfoModel = model;
                [detail performSelector:@selector(loadDetailWithCustomerId:) withObject:model.customerId afterDelay:0.2];
            }
        }
    }];
}

//- (NSArray *) getItemByArray:(NSArray *) array
//{
//    NSMutableArray *items = [[NSMutableArray alloc] init];
//    for (int i =0; i<[array count]; i++) {
//        CarInfoModel *model = [array objectAtIndex:i];
//        CTPopoutMenuItem * item = [[CTPopoutMenuItem alloc]initWithTitle:model.carNo image:[UIImage imageNamed:[NSString stringWithFormat:@"pic%d",i]]];
//        [items addObject:item];
//    }
//    
//    return items;
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

- (void) loadCarInfo:(NSString *) customerId Completion:(Completion) completion
{
    NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:filters value:@"and" key:@"groupOp"];
    NSMutableArray *rules = [[NSMutableArray alloc] init];
    [rules addObject:[self getRulesByField:@"customerId" op:@"eq" data:customerId]];
    [Util setValueForKeyWithDic:filters value:rules key:@"rules"];
    
    [NetWorkHandler requestToQueryForCustomerCarPageList:0 limit:LIMIT sord:@"desc" filters:filters Completion:completion];
}

#pragma BackGroundViewDelegate
- (void) notifyToAddNewCustomer:(BackGroundView *) view
{
    [self handleRightBarButtonClicked:nil];
}

@end
