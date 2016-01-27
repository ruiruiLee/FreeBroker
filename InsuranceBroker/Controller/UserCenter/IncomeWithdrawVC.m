//
//  IncomeWithdrawVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/3.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "IncomeWithdrawVC.h"
#import "define.h"
#import "NetWorkHandler+queryUserBackCardList.h"
#import "BankCardModel.h"
#import "UIImageView+WebCache.h"
#import "NetWorkHandler+applyForEarn.h"
#import "NetWorkHandler+queryUserNowAdvanceMoney.h"

@interface IncomeWithdrawVC ()
{
    NSInteger _selectbank;
    
    CGFloat _advanceMoney;//可提现余额
}

@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation IncomeWithdrawVC

- (void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void) notifyToReloadBankList:(NSNotification *) notify
{
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"收益提现";
    _selectbank = -1;
    _advanceMoney = 0;
    
    self.data = [[NSMutableArray alloc] init];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifyToReloadBankList:) name:Notify_Add_BankCard object:nil];
    
    UIButton *btnDetail = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 20)];
    [btnDetail setTitle:@"提现说明" forState:UIControlStateNormal];
    btnDetail.layer.cornerRadius = 10;
    btnDetail.layer.borderWidth = 0.5;
    btnDetail.layer.borderColor = _COLOR(0xff, 0x66, 0x19).CGColor;
    [btnDetail setTitleColor:_COLOR(0xff, 0x66, 0x19) forState:UIControlStateNormal];
    btnDetail.titleLabel.font = _FONT(10);
    [self setRightBarButtonWithButton:btnDetail];
    
    self.btnSubmit.layer.cornerRadius = 3;
    self.viewHConstraint.constant = ScreenWidth;
    self.tableview.separatorColor = _COLOR(0xe6, 0xe6, 0xe6);
    
    self.tableview.tableFooterView = [[UIView alloc] init];
    
    self.lbExplain.attributedText = [Util getWarningString:@"*提现金额需大于50元，两个工作日内到账"];
    [self.btnSubmit addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableview setSeparatorInset:insets];
    }
    if ([self.tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableview setLayoutMargins:insets];
    }
    
    [self loadAdvanceMoney];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadData
{
    [NetWorkHandler requesToQueryUserBackCardList:[UserInfoModel shareUserInfoModel].userId backCardStatus:@"1" Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            [self.data removeAllObjects];
            [self.data addObjectsFromArray:[BankCardModel modelArrayFromArray:[content objectForKey:@"data"]]];
            if([self.data count] > 0)
                _selectbank = 0;
            [self.tableview reloadData];
        }
    }];
}

- (void) loadAdvanceMoney
{
    [NetWorkHandler requestToQueryUserNowAdvanceMoney:[UserInfoModel shareUserInfoModel].userId Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            _advanceMoney = [[content objectForKey:@"data"] floatValue];
//            _lbAmmount.text = [NSString stringWithFormat:@"%@元", [Util getDecimalStyle:_advanceMoney]];
            [self.tableview reloadData];
        }
    }];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void) handleRightBarButtonClicked:(id)sender
{
    WebViewController *web = [IBUIFactory CreateWebViewController];
    web.title = @"提现说明";
    [self.navigationController pushViewController:web animated:YES];
    NSString *url = [NSString stringWithFormat:@"%@%@%@", SERVER_ADDRESS, @"/news/view/", Withdrawal_Instructions];
    [web loadHtmlFromUrl:url];
}

- (void) submit:(UIButton *)sender
{
    if(_selectbank < 0){
        [Util showAlertMessage:@"请选择使用银行卡"];
        return;
    }
    NSInteger num = [self.tfAmount.text integerValue];
    if(num < 50)
    {
        [Util showAlertMessage:@"提现金额必须大于50元"];
        return;
    }
    if(num > _advanceMoney){
        [Util showAlertMessage:@"超出你所能提取的现金总额"];
        return;
    }
    
    BankCardModel *model = [self.data objectAtIndex:_selectbank];
    [NetWorkHandler requestToApplyForEarn:model.backCardId useId:[UserInfoModel shareUserInfoModel].userId money:self.tfAmount.text Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            _advanceMoney = [[[content objectForKey:@"data"] objectForKey:@"advanceMoneyIng"] floatValue];
//            _lbAmmount.text = [NSString stringWithFormat:@"%@元", [Util getDecimalStyle:_advanceMoney]];
            [Util showAlertMessage:[[content objectForKey:@"data"] objectForKey:@"msg"]];
            self.tfAmount.text = @"";
            [self.tfAmount resignFirstResponder];
            [self.tableview reloadData];
        }
    }];
}

#pragma UITableViewDataSource UITableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    if([self.data count] == 0){
        self.lbExplain.hidden = YES;
        self.btnSubmit.hidden = YES;
        return 1;
    }else{
        self.lbExplain.hidden = NO;
        self.btnSubmit.hidden = NO;
        return 3;
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.data count] == 0){
        self.tableVConstraint.constant =  55;
        return 1;
    }
    else{
        self.tableVConstraint.constant = [self.data count] * 60 + 55 + 50;
        if(section == 0)
            return [self.data count];
        else
            return 1;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.data count] == 0){
        return 55;
    }
    else{
        if(indexPath.section == 0)
            return 60.f;
        else if (indexPath.section == 1)
            return 55.f;
        else
            return 50;
    }
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([self.data count] == 0){
        NSString *deq = @"cell1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
        if(!cell){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
            cell.textLabel.font = _FONT(12);
            cell.textLabel.textColor = _COLOR(0x75, 0x75, 0x75);
            cell.contentView.backgroundColor = _COLOR(245, 245, 245);
        }
        
        cell.textLabel.text = @"添加银行卡";
        cell.imageView.image = ThemeImage(@"add_card");
        
        return cell;
    }
    else{
        if(indexPath.section == 0){
            NSString *deq = @"cell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
            if(!cell){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:deq];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.textLabel.font = _FONT(15);
                cell.textLabel.textColor = _COLOR(0x21, 0x21, 0x21);
                
                UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 16, 16)];
                cell.accessoryView = btn;
                [btn setImage:ThemeImage(@"unselect_point") forState:UIControlStateNormal];
                [btn setImage:ThemeImage(@"select_point") forState:UIControlStateSelected];
                
                cell.detailTextLabel.font = _FONT(11);
                cell.detailTextLabel.textColor = _COLOR(0x75, 0x75, 0x75);
                [btn addTarget:self action:@selector(doBankSelect:) forControlEvents:UIControlEventTouchUpInside];
                btn.userInteractionEnabled = NO;
            }
            
            BankCardModel *model = [self.data objectAtIndex:indexPath.row];
            
            cell.imageView.layer.cornerRadius = 20;
            cell.textLabel.text = model.openBackName;
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.backLogo] placeholderImage:Normal_Logo completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                if(image != nil){
                    UIImage *newimage = [Util fitSmallImage:image scaledToSize:CGSizeMake(40, 40)];
                    cell.imageView.image = newimage;
                }
            }];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"尾号%@", model.backCardTailNo];
            UIButton *btn = (UIButton*)cell.accessoryView;
            btn.tag = 100 + indexPath.row;
            if(indexPath.row == _selectbank){
                btn.selected = YES;
            }else
            {
                btn.selected = NO;
            }
            
            return cell;
        }
        else if(indexPath.section == 1){
            NSString *deq = @"cell1";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
            if(!cell){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
                cell.textLabel.font = _FONT(12);
                cell.textLabel.textColor = _COLOR(0x75, 0x75, 0x75);
                cell.contentView.backgroundColor = _COLOR(245, 245, 245);
            }
            
            cell.textLabel.text = @"添加银行卡";
            cell.imageView.image = ThemeImage(@"add_card");
            
            return cell;
        }else{
            NSString *deq = @"cell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
            if(!cell){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:deq];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.font = _FONT(15);
                cell.textLabel.textColor = _COLOR(0x21, 0x21, 0x21);
                
                UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth - 100, 36)];
                cell.accessoryView = tf;
                tf.font = _FONT(15);
                tf.textColor = _COLOR(0x21, 0x21, 0x21);
                tf.keyboardType = UIKeyboardTypeNumberPad;

            }
            cell.textLabel.text = @"提现金额";
            self.tfAmount = (UITextField*)cell.accessoryView;
            self.tfAmount.placeholder = [NSString stringWithFormat:@"当前能提现的金额最大为%@元", [Util getDecimalStyle:_advanceMoney]];
            
            return cell;
        }
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if([self.data count] == 0){
        BindBankCardVC *vc = [IBUIFactory CreateBindBankCardViewController];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else{
        if(indexPath.section == 1){
            BindBankCardVC *vc = [IBUIFactory CreateBindBankCardViewController];
            [self.navigationController pushViewController:vc animated:YES];
        }else if (indexPath.section == 0){
            _selectbank = indexPath.row;
            [self.tableview reloadData];
        }
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIImageView *view = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    return view;
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

- (void) doBankSelect:(UIButton *)sender
{
    NSInteger tag = sender.tag;
    _selectbank = tag - 100;
    [self.tableview reloadData];
}

@end
