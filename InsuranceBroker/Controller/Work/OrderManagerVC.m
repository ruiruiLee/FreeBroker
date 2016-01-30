//
//  OrderManagerVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/28.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "OrderManagerVC.h"
#import "OrderManagerTableViewCell.h"
#import "NetWorkHandler+queryForCustomerInsurPageList.h"
#import "define.h"
#import "InsurInfoModel.h"
#import "WebViewController.h"
#import "UIImageView+WebCache.h"

@interface OrderManagerVC () <UISearchBarDelegate>
{
    NSArray *insurArray;
    
//    UISearchBar *searchbar;
//    NSString *filterString;
}

@end

@implementation OrderManagerVC
@synthesize searchbar;
@synthesize filterString;

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
    
    self.title = @"保单管理";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initSubViews
{
    self.pulltable = [[PullTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 580) style:UITableViewStyleGrouped];
    [self.view addSubview:self.pulltable];
    self.pulltable.delegate = self;
    self.pulltable.dataSource = self;
    self.pulltable.pullDelegate = self;
    self.pulltable.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.pulltable.translatesAutoresizingMaskIntoConstraints = NO;
    [self.pulltable registerNib:[UINib nibWithNibName:@"OrderManagerTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    //弹出下拉刷新控件刷新数据
    self.pulltable.pullTableIsRefreshing = YES;
    [self performSelector:@selector(refreshTable) withObject:nil afterDelay:3];
    
    PullTableView *pulltable = self.pulltable;
    
    searchbar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 40)];
    searchbar.placeholder = @"搜索";
    searchbar.showsCancelButton = YES;
    self.pulltable.tableHeaderView = searchbar;
    searchbar.returnKeyType = UIReturnKeySearch;
    searchbar.delegate = self;
    searchbar.text = filterString;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(pulltable);
    
    self.vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[pulltable]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:self.vConstraints];
    
    self.hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[pulltable]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:self.hConstraints];
}

- (void) loadDataInPages:(NSInteger)page
{
    NSInteger offset = page;
    NSMutableDictionary *filters = [[NSMutableDictionary alloc] init];
    [Util setValueForKeyWithDic:filters value:@"and" key:@"groupOp"];
    NSMutableArray *rules = [[NSMutableArray alloc] init];
    UserInfoModel *user = [UserInfoModel shareUserInfoModel];
    [rules addObject:[self getRulesByField:@"insuranceType" op:@"eq" data:@"1"]];
    [rules addObject:[self getRulesByField:@"userId" op:@"eq" data:user.userId]];
    [rules addObject:[self getRulesByField:@"customerName" op:@"cn" data:filterString]];
    [rules addObject:[self getRulesByField:@"customerPhone" op:@"cn" data:filterString]];
    [rules addObject:[self getRulesByField:@"carNo" op:@"cn" data:filterString]];
    [rules addObject:[self getRulesByField:@"insuranceOrderNo" op:@"cn" data:filterString]];
    [Util setValueForKeyWithDic:filters value:rules key:@"rules"];
    
    [NetWorkHandler requestToQueryForCustomerInsurPageList:@"1"
                                                    offset:offset
                                                     limit:LIMIT
                                                      sord:@"desc"
                                                   filters:filters
                                                Completion:^(int code, id content) {
                                                    [self refreshTable];
                                                    [self loadMoreDataToTable];
                                                    [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
                                                    if(code == 200){
                                                        NSArray *array = [[content objectForKey:@"data"] objectForKey:@"rows"];
                                                        if(page == 0)
                                                            [self.data removeAllObjects];
                                                        [self.data addObjectsFromArray:[InsurInfoModel modelArrayFromArray:array]];
                                                        self.total = [[[content objectForKey:@"data"] objectForKey:@"total"] integerValue];
                                                        [self initData];
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

#pragma UITableViewDataSource UITableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if([insurArray count] == 0){
        [self showNoDatasImage:ThemeImage(@"no_data")];
    }
    else{
        [self hidNoDatasImage];
    }
    return [insurArray count];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array = [insurArray objectAtIndex:section];
    return [array count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
    OrderManagerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
        cell = [[OrderManagerTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
    }
    
    NSArray *array = [insurArray objectAtIndex:indexPath.section];
    InsurInfoModel *model = [array objectAtIndex:indexPath.row];
    
    cell.lbNo.text = model.insuranceOrderNo;
    cell.lbName.text = model.customerName;
    cell.lbPlate.text = model.carNo;
    cell.lbContent.text = model.planTypeName;//[Util getStringByPlanType:model.planType];
    [cell.phoneNum setTitle:model.customerPhone forState:UIControlStateNormal];
    cell.lbStatus.attributedText = [self getAttributedString:model.orderOfferStatusMsg orderOfferNums:model.orderOfferNums orderOfferStatus:model.orderOfferStatus orderOfferPayPrice:model.orderOfferPayPrice orderOfferStatusStr:(NSString *) model.orderOfferStatusMsg];
    [self setPolicyStatusWithCell:cell orderOfferStatus:model.orderOfferStatus orderOfferStatusStr:model.orderOfferStatusStr];
    [cell.logoImgV sd_setImageWithURL:[NSURL URLWithString:model.productLogo] placeholderImage:ThemeImage(@"chexian")];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSArray *array = [insurArray objectAtIndex:indexPath.section];
    InsurInfoModel *model = [array objectAtIndex:indexPath.row];
    NSInteger orderOfferStatus = model.orderOfferStatus;
    
    if(orderOfferStatus == 1 || orderOfferStatus == 2 || orderOfferStatus == 9){
        //        title = @"报价中";
        WebViewController *web = [IBUIFactory CreateWebViewController];
        web.title = @"报价详情";
        [self.navigationController pushViewController:web animated:YES];
        NSString *url = [NSString stringWithFormat:@"%@/car_insur/car_insur_detail.html?insuranceType=%@&orderId=%@", Base_Uri, @"1", model.insuranceOrderUuid];
        [web loadHtmlFromUrl:url];
    }
    else if (orderOfferStatus == 4 || orderOfferStatus == 5 || orderOfferStatus == 6 || orderOfferStatus == 7 || orderOfferStatus == 8){
        //        title = @"出单配送";
        OrderDetailWebVC *web = [IBUIFactory CreateOrderDetailWebVC];
        web.title = @"报价详情";
        web.type = enumShareTypeShare;
        if(model.productLogo){
            web.shareImgArray = [NSArray arrayWithObject:model.productLogo];
        }
        UserInfoModel *user = [UserInfoModel shareUserInfoModel];
        web.shareTitle = [NSString stringWithFormat:@"我是%@，我是优快保自由经纪人。这是为您定制的投保方案报价，请查阅。电话%@", user.realName, user.phone];
        [self.navigationController pushViewController:web animated:YES];
        if(model.planOfferId != nil){
            NSString *url = [NSString stringWithFormat:@"%@/car_insur/car_insur_detail.html?insuranceType=%@&orderId=%@&planOfferId=%@", Base_Uri, @"1", model.insuranceOrderUuid, model.planOfferId];
            [web initShareUrl:model.insuranceOrderUuid insuranceType:@"1" planOfferId:model.planOfferId];
            [web loadHtmlFromUrl:url];
        }else{
            NSString *url = [NSString stringWithFormat:@"%@/car_insur/car_insur_detail.html?insuranceType=%@&orderId=%@", Base_Uri, @"1", model.insuranceOrderUuid];
            [web initShareUrl:model.insuranceOrderUuid insuranceType:@"1" planOfferId:model.planOfferId];
            [web loadHtmlFromUrl:url];
        }
        
    }
    else if (orderOfferStatus == 3){
        OfferDetailsVC *vc = [IBUIFactory CreateOfferDetailsViewController];
        vc.orderId = model.insuranceOrderUuid;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 31;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 31)];
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 31)];
    [view addSubview:imgv];
    UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, ScreenWidth, 20)];
    [view addSubview:lb];
    lb.backgroundColor = [UIColor clearColor];
    lb.font = _FONT(12);
    lb.textColor = _COLOR(0xcc, 0xcc, 0xcc);
    lb.textAlignment = NSTextAlignmentCenter;
    InsurInfoModel *model = [[insurArray objectAtIndex:section] objectAtIndex:0];
    lb.text = [Util getDayString:model.createdAt];
    
    return view;
}

- (void) initData
{
    NSMutableArray *result = [[NSMutableArray alloc] init];
    int i = 0;
    while (i < [self.data count]) {
        InsurInfoModel *model = [self.data objectAtIndex:i];
        if((i - 1) < 0){
            NSMutableArray *array = [[NSMutableArray alloc] init];
            [array addObject:model];
            [result addObject:array];
        }
        else{
            InsurInfoModel *model1 = [self.data objectAtIndex:i-1];
            if([[Util getDayString:model.createdAt] isEqualToString:[Util getDayString:model1.createdAt]]){
                NSMutableArray *array = [result lastObject];
                [array addObject:model];
            }else{
                NSMutableArray *array = [[NSMutableArray alloc] init];
                [array addObject:model];
                [result addObject:array];
            }
        }
        
        
        i++;
    }
    
    insurArray = result;
    [self.pulltable reloadData];
}

- (void) setPolicyStatusWithCell:(OrderManagerTableViewCell *) cell orderOfferStatus:(NSInteger) orderOfferStatus orderOfferStatusStr:(NSString *) orderOfferStatusStr
{
    LeftImgButton *btn = cell.btnStatus;
    NSString *title = @"";
    UIImage *image = nil;
    if(orderOfferStatus == 1){
        title = @"报价中";
        image = ThemeImage(@"price_loading");
    }
    else if(orderOfferStatus == 2){
        title = @"报价失败";
        image = ThemeImage(@"error");
    }
    else if (orderOfferStatus == 3){
        title = @"报价完成";
        image = ThemeImage(@"price_done");
    }
    else if (orderOfferStatus == 4){
        title = @"出单配送";
        image = ThemeImage(@"deliver");
    }
    else if (orderOfferStatus == 5){
        title = @"出单配送";
        image = ThemeImage(@"deliver");
    }
    else if (orderOfferStatus == 6){
        title = @"出单配送";
        image = ThemeImage(@"deliver");
    }
    else if (orderOfferStatus == 7){
        title = @"付款失败";
        image = ThemeImage(@"error");
    }
    else if (orderOfferStatus == 8){
        title = @"交易成功";
        image = ThemeImage(@"Order_done");
    }
    else if (orderOfferStatus == 9){
        title = @"保单过期";
        image = ThemeImage(@"error");
    }else{
        title = orderOfferStatusStr;
        image = ThemeImage(@"error");
    }
    
    [btn setImage:image forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
}

//":"1"; //订单报价状态；1等待报价，2报价失败(读取失败原因,StatusId,StatusMsg），3报价完成，4出单配送-未付款（货到付款），5出单配送-付款中，6出单配送-已付款，7付款失败，8交易成功，9已过期，10禁止流程操作当扫表状态为1或2的时候，进行报价
/*
 desc : statusmsg
 orderOfferNums : 几分报价
 */
- (NSMutableAttributedString *) getAttributedString:(NSString *)desc orderOfferNums:(NSInteger) orderOfferNums orderOfferStatus:(NSInteger) orderOfferStatus orderOfferPayPrice:(float) orderOfferPayPrice orderOfferStatusStr:(NSString *) orderOfferStatusStr
{
    NSString *string = @"";
    if(orderOfferStatus == 2){
        string = desc;
        return [self attstringWithString:string range:NSMakeRange(0, [string length]) font:_FONT(12) color:_COLOR(0xf4, 0x43, 0x36)];
    }
    else if (orderOfferStatus == 3){
        string = [NSString stringWithFormat:@"共有%d份报价", orderOfferNums];
        return [self attstringWithString:string range:NSMakeRange(2, 1) font:_FONT(15) color:_COLOR(0xff, 0x66, 0x19)];
    }
    else if (orderOfferStatus == 4){
        string = @"未付款";
        return [self attstringWithString:string range:NSMakeRange(0, [string length]) font:_FONT(12) color:_COLOR(0xf4, 0x43, 0x36)];
    }
    else if (orderOfferStatus == 5){
        string = @"付款中";
        return [self attstringWithString:string range:NSMakeRange(0, [string length]) font:_FONT(12) color:_COLOR(0x75, 0x75, 0x75)];
    }
    else if (orderOfferStatus == 6){
        string = @"已付款";
        return [self attstringWithString:string range:NSMakeRange(0, [string length]) font:_FONT(12) color:_COLOR(0x29, 0xcc, 0x5f)];
    }
    else if (orderOfferStatus == 7){
        string = @"付款失败";
        return [self attstringWithString:string range:NSMakeRange(0, [string length]) font:_FONT(12) color:_COLOR(0xf4, 0x43, 0x36)];
    }
    else if (orderOfferStatus == 8){
        string = [NSString stringWithFormat:@"实付:¥%.2f", orderOfferPayPrice];
        return [self attstringWithString:string range:NSMakeRange(3, [string length] - 3) font:_FONT(18) color:_COLOR(0xf4, 0x43, 0x36)];
    }
    else if (orderOfferStatus == 9){
        string = @"保单过期";
        return [self attstringWithString:string range:NSMakeRange(0, [string length]) font:_FONT(12) color:_COLOR(0xf4, 0x43, 0x36)];
    }else{
        string = orderOfferStatusStr;
        if(string == nil)
            string = @"";
        return [self attstringWithString:string range:NSMakeRange(0, [string length]) font:_FONT(12) color:_COLOR(0xf4, 0x43, 0x36)];
    }
    
    return nil;
}

- (NSMutableAttributedString *) attstringWithString:(NSString *) string range:(NSRange) range font:(UIFont *) font color:(UIColor *)color
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:color range:range];
    [attributedString addAttribute:NSFontAttributeName value:font range:range];
    
    return attributedString;
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
    searchbar.text = @"";
    filterString = @"";
    self.pageNum = 0;
    [self loadDataInPages:self.pageNum];
}

@end
