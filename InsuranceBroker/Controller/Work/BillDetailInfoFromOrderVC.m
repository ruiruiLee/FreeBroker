//
//  BillDetailInfoFromOrderVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/3/2.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BillDetailInfoFromOrderVC.h"
#import "BIllDetailTableViewCell.h"
#import "define.h"

@implementation BillDetailInfoFromOrderVC

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (void) initData
{
    [self setDataFromOrder];
    self.lbTotalAmount.text = [NSString stringWithFormat:@"+%@",self.billInfo.billMoney];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
    BIllDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"BIllDetailTableViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
    }
    if(indexPath.row == 0){
        cell.selectionStyle = UITableViewCellSelectionStyleDefault;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else{
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.lbTitle.text = [self.titleArray objectAtIndex:indexPath.row];
    if([self.contentArray count] > indexPath.row)
        cell.lbDetail.text = [self.contentArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
        //        title = @"报价中";
    WebViewController *web = [IBUIFactory CreateWebViewController];
    web.title = @"报价详情";
    [self.navigationController pushViewController:web animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@/car_insur/car_insur_detail.html?insuranceType=%@&orderId=%@", Base_Uri, @"1", self.billInfo.insuranceOrderUuid];
    [web loadHtmlFromUrl:url];

}

@end
