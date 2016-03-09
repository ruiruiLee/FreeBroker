//
//  CustomerFollowUpInfoView.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/25.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "CustomerFollowUpInfoView.h"
#import "CustomerFollowUpTableCell.h"
#import "define.h"
#import "VisitInfoModel.h"

@implementation CustomerFollowUpInfoView
@synthesize footer;

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self.tableview registerNib:[UINib nibWithNibName:@"CustomerFollowUpTableCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        self.lbTitle.text = @"客户跟进信息";
        [self.btnEdit setImage:ThemeImage(@"add_icon") forState:UIControlStateNormal];
        
        footer = [[FooterView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        self.tableview.tableFooterView = footer;
        footer.delegate = self;
    }
    
    return self;
}

- (void) doEditButtonClicked:(UIButton *)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(NotifyAddFollowUpInfo:)]){
        [self.delegate NotifyAddFollowUpInfo:self];
    }
}

#pragma UITableViewDataSource UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.data count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 96;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
    CustomerFollowUpTableCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
//        cell = [[CustomerFollowUpTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"CustomerFollowUpTableCell" owner:nil options:nil];
        cell = [nibs lastObject];
    }
    VisitInfoModel *model = [self.data objectAtIndex:indexPath.row];
    cell.lbAddress.text = model.visitAddr;
    cell.lbContent.text = model.visitMemo;
    cell.lbSchedule.text = [NSString stringWithFormat:@"%@-%@", model.visitType, model.visitProgress];
    cell.lbTime.text = [Util getShowingTime:model.visitTime];
    
    if([model.visitTypeId isEqualToString:@"1"]){
        cell.logoImgV.image = ThemeImage(@"phone_talk");
    }
    else if ([model.visitTypeId isEqualToString:@"2"]){
        cell.logoImgV.image = ThemeImage(@"face_talk");
    }
    else if ([model.visitTypeId isEqualToString:@"3"]){
        cell.logoImgV.image = ThemeImage(@"wechat_talk");
    }
    else if ([model.visitTypeId isEqualToString:@"4"]){
        cell.logoImgV.image = ThemeImage(@"qq_talk");
    }
    else if ([model.visitTypeId isEqualToString:@"5"]){
        cell.logoImgV.image = ThemeImage(@"message_talk");
    }
    else if ([model.visitTypeId isEqualToString:@"6"]){
        cell.logoImgV.image = ThemeImage(@"mail_talk");
    }
    else if ([model.visitTypeId isEqualToString:@"7"]){
        cell.logoImgV.image = ThemeImage(@"others_talk");
    }
    
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(self.delegate && [self.delegate respondsToSelector:@selector(NotifyHandleFollowUpClicked:idx:)]){
        [self.delegate NotifyHandleFollowUpClicked:self idx:indexPath.row];
    }
}

- (void) NotifyToLoadMore:(FooterView *) view
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(NotifyToLoadMoreFollowUp:)])
        [self.delegate NotifyToLoadMoreFollowUp:self];
}

- (void) endLoadMore
{
    FooterView *view = (FooterView*)self.tableview.tableFooterView;
    [view endLoading];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"commitEditingStyle");
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if (self.data.count>0 ){

        VisitInfoModel *model = [self.data objectAtIndex:indexPath.row];
            if(self.delegate && [self.delegate respondsToSelector:@selector(NotifyHandleItemDelegateClicked:model:)]){
                [self.delegate NotifyHandleItemDelegateClicked:self model:model];
            }
        // Delete the row from the data source.
        }
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

@end
