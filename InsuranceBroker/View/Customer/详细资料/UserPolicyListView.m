//
//  UserPolicyListView.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/25.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "UserPolicyListView.h"
#import "PolicyInfoTableViewCell.h"
#import "define.h"
#import "FooterView.h"
#import "InsurInfoModel.h"
#import "UIImageView+WebCache.h"
#import "NetWorkHandler+deleteInsuranceOrder.h"

@implementation UserPolicyListView
@synthesize footer;

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self.tableview registerNib:[UINib nibWithNibName:@"PolicyInfoTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.lbTitle.text = @"客户保单信息";
        [self.btnEdit setImage:ThemeImage(@"refresh") forState:UIControlStateNormal];
        
        footer = [[FooterView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        self.tableview.tableFooterView = footer;
        footer.delegate = self;
    }
    
    return self;
}

- (void) doEditButtonClicked:(UIButton *)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(NotifyToRefresh:)]){
        [self startAnimation];
        [self.delegate NotifyToRefresh:self];
    }
}

#pragma UITableViewDataSource UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
    PolicyInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
//        cell = [[PolicyInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"PolicyInfoTableViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
    }
    
    InsurInfoModel *model = [self.data objectAtIndex:indexPath.row];
    cell.lbNo.text = model.insuranceOrderNo;
    NSString *carNo = model.carNo;
    if(carNo == nil)
        carNo = @"";
    cell.lbName.text = [NSString stringWithFormat:@"%@  %@", model.customerName, carNo];
    cell.lbPlate.text = @"";
    cell.lbContent.text = model.planTypeName;//[Util getStringByPlanType:model.planType];
    cell.lbUpdateTime.text = [Util getTimeString:model.createdAt];
    cell.lbStatus.attributedText = [self getAttributedString:model.orderOfferStatusMsg orderOfferNums:model.orderOfferNums orderOfferStatus:model.orderOfferStatus orderOfferPayPrice:model.orderOfferPayPrice orderOfferStatusStr:model.orderOfferStatusStr];
    [self setPolicyStatusWithCell:cell orderOfferStatus:model.orderOfferStatus orderOfferStatusStr:model.orderOfferStatusStr orderOfferPrintStatus:model.orderOfferPrintStatus];
    [cell.logoImgV sd_setImageWithURL:[NSURL URLWithString:model.productLogo] placeholderImage:ThemeImage(@"chexian")];
    
    return cell;
}

//orderOfferStatusMsg = "\U8bc1\U4ef6\U4fe1\U606f\U6709\U8bef";
//orderOfferStatusStr = "\U62a5\U4ef7\U5931\U8d25";

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(NotifyHandlePolicyClicked:idx:)]){
        [self.delegate NotifyHandlePolicyClicked:self idx:indexPath.row];
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"commitEditingStyle");
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        InsurInfoModel *model = [self.data objectAtIndex:indexPath.row];
        if(self.delegate && [self.delegate respondsToSelector:@selector(NotifyHandleItemDelegateClicked:model:)]){
            [self.delegate NotifyHandleItemDelegateClicked:self model:model];
        }
            // Delete the row from the data source.
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

//编辑删除按钮的文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}

//这个方法用来告诉表格 某一行是否可以移动
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete; //每行左边会出现红的删除按钮
}

- (void) deleteItemWithOrderId:(NSString *) orderId Completion:(Completion)completion
{
    [NetWorkHandler requestToDeleteInsuranceOrder:orderId userId:[UserInfoModel shareUserInfoModel].userId Completion:completion];
}

- (void) NotifyToLoadMore:(FooterView *) view
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(NotifyToLoadMorePloicy:)])
        [self.delegate NotifyToLoadMorePloicy:self];
}

- (void) endLoadMore
{
    FooterView *view = (FooterView*)self.tableview.tableFooterView;
    [view endLoading];
}

- (void) setPolicyStatusWithCell:(PolicyInfoTableViewCell *) cell orderOfferStatus:(NSInteger) orderOfferStatus orderOfferStatusStr:(NSString*) orderOfferStatusStr orderOfferPrintStatus:(NSInteger) orderOfferPrintStatus
{
    LeftImgButton *btn = cell.btnStatus;
    NSString *title = @"";
    UIImage *image = nil;
    if(orderOfferStatus == 1){
//        title = @"报价中";
        image = ThemeImage(@"price_loading");
    }
    else if(orderOfferStatus == 2){
//        title = @"报价失败";
        image = ThemeImage(@"error");
    }
    else if (orderOfferStatus == 3){
//        title = @"报价完成";
        image = ThemeImage(@"price_done");
    }
    else if (orderOfferStatus == 4){
        if(orderOfferPrintStatus == 2){
//            title = @"出单配送";
            image = ThemeImage(@"deliver");
        }else{
//            title = @"等待出单";
            image = ThemeImage(@"Issuing");
        }
    }
    else if (orderOfferStatus == 5){
//        title = @"出单配送";
        image = ThemeImage(@"deliver");
    }
    else if (orderOfferStatus == 6){
        if(orderOfferPrintStatus == 2){
//            title = @"出单配送";
            image = ThemeImage(@"deliver");
        }else{
//            title = @"等待出单";
            image = ThemeImage(@"Issuing");
        }
    }
    else if (orderOfferStatus == 7){
//        title = @"付款失败";
        image = ThemeImage(@"error");
    }
    else if (orderOfferStatus == 8){
//        title = @"交易成功";
        image = ThemeImage(@"order_done");
    }
    else if (orderOfferStatus == 9){
//        title = @"保单过期";
        image = ThemeImage(@"error");
    }else{
        image = ThemeImage(@"error");
    }
    
    title = orderOfferStatusStr;
    
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
        string = desc;
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

@end
