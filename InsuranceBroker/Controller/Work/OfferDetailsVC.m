//
//  OfferDetailsVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/2.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "OfferDetailsVC.h"
#import "define.h"
#import "OfferDetailTableViewCell.h"
#import "NetWorkHandler+queryForInsuranceOffersList.h"
#import "NetWorkHandler+saveOrUpdateInsuranceRatio.h"
#import "InsurOffersInfoModel.h"
#import "UIImageView+WebCache.h"
#import "LCPickView.h"

@interface OfferDetailsVC ()<LCPickViewDelegate>
{
    LCPickView *_datePicker;
}

@property (nonatomic, strong) InsurOffersInfoModel *data;

@end

@implementation OfferDetailsVC

- (void) dealloc
{
    [_datePicker remove];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"报价详情";
    
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableview.scrollEnabled = NO;
    [self.tableview registerNib:[UINib nibWithNibName:@"OfferDetailTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self resetBtnNameWidth:[self.btnName titleForState:UIControlStateNormal]];
    [self resetBtnNoWidth:[self.btnNo titleForState:UIControlStateNormal]];
    
    self.viewHConstraint.constant = ScreenWidth;
    [self loadData];
    
    self.lbWarning.attributedText = [Util getWarningString:@"*客户优惠 为您实际优惠客户的点数，只针对商业险，对于只购买强制交强险的客户不能享有优惠"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) handleLeftBarButtonClicked:(id)sender
{
    [super handleLeftBarButtonClicked:sender];
    if(_datePicker){
        [_datePicker remove];
    }
}

- (void) loadData
{
    [NetWorkHandler requestToQueryForInsuranceOffersList:self.orderId insuranceType:@"1" Completion:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            self.data = (InsurOffersInfoModel*)[InsurOffersInfoModel modelFromDictionary:[content objectForKey:@"data"]];//[InsurOffersInfoModel modelArrayFromArray:[[content objectForKey:@"data"] objectForKey:@"rows"]];
            [self initSubViews];
        }
    }];
}

//
- (void) initSubViews
{
    self.lbIdenCode.text = self.data.insuranceOrderNo;
    self.lbPlan.text = [NSString stringWithFormat:@"车险方案：%@", self.data.planTypeName];
    self.lbTime.text = [NSString stringWithFormat:@"创建时间：%@", [Util getTimeString:self.data.createdAt]];
    [self.btnName setTitle:self.data.customerName forState:UIControlStateNormal];
    [self.btnNo setTitle:self.data.carNo forState:UIControlStateNormal];
    self.btnNameHConstraint.constant = [self.data.customerName sizeWithFont:self.btnName.titleLabel.font].width + 6 + 16;
    self.btnNoHConstraint.constant = [self.data.carNo sizeWithFont:self.btnNo.titleLabel.font].width + 6 + 16;
    
    [self.tableview reloadData];
}

- (void) awakeFromNib
{
    
}

- (void) resetBtnNameWidth:(NSString *) string
{
    UIImage *image = ThemeImage(@"car_owner");
    self.btnNameHConstraint.constant = 6 + image.size.width + [string sizeWithFont:self.btnName.titleLabel.font constrainedToSize:CGSizeMake(200, 30)].width;
}

- (void) resetBtnNoWidth:(NSString *) string
{
    UIImage *image = ThemeImage(@"car_id");
    self.btnNoHConstraint.constant = 6 + image.size.width + [string sizeWithFont:self.btnNo.titleLabel.font constrainedToSize:CGSizeMake(200, 30)].width;
}

#pragma UITableViewDataSource UITableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger num = [self.data.offersVoList count];
    self.tableVConstraint.constant = num * 130;
    return num;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 130;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
    OfferDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"OfferDetailTableViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.contentView.backgroundColor = [UIColor clearColor];
    [cell.btnAdd addTarget:self action:@selector(doBtnAddPlanUBKRatio:) forControlEvents:UIControlEventTouchUpInside];
//    [cell.btnReduce addTarget:self action:@selector(doBtnReducePlanUBKRatio:) forControlEvents:UIControlEventTouchUpInside];
    cell.btnAdd.tag = indexPath.row;
    cell.btnReduce.tag = indexPath.row;
    
    OffersModel *model = [self.data.offersVoList objectAtIndex:indexPath.row];
    
    cell.lbGain.attributedText = [self getPlanUkbSavePriceAttbuteString:[NSString stringWithFormat:@"赚：¥%.2f", model.planUserAllot] sub:@".00"];
    cell.lbName.text = model.productName;
    cell.lbPrice.attributedText = [self getPlanInsuranceCompanyPriceAttbuteString:[NSString stringWithFormat:@"保单价：%.2f", model.planInsuranceCompanyPrice] sub:[NSString stringWithFormat:@"%.2f", model.planInsuranceCompanyPrice]];
    cell.lbRebate.text = [NSString stringWithFormat:@"%d%@", (int)model.planUkbRatio, @"%"];
    cell.lbtruePrice.attributedText = [self getPlanUkbPriceAttbuteString:[NSString stringWithFormat:@"折后价：¥%.2f", model.planUkbPrice] sub:[NSString stringWithFormat:@"¥%.2f", model.planUkbPrice]];
    [cell.photo sd_setImageWithURL:[NSURL URLWithString:model.productLogo] placeholderImage:Normal_Image];
    
    if(model.businessPrice == 0){
        cell.btnAdd.hidden = YES;
        cell.btnReduce.hidden = YES;
        cell.lbRebate.hidden = YES;
        cell.lbNoRebate.hidden = NO;
        cell.lbRebateTitle.hidden = YES;
    }else{
        cell.btnAdd.hidden = NO;
        cell.btnReduce.hidden = NO;
        cell.lbRebate.hidden = NO;
        cell.lbNoRebate.hidden = YES;
        cell.lbRebateTitle.hidden = NO;
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    OffersModel *model = [self.data.offersVoList objectAtIndex:indexPath.row];
    [self updateInsuranceRatio:self.data.insuranceOrderUuid planOfferId:model.planOfferId model:model];
}

- (void) doBtnAddPlanUBKRatio:(UIButton *)sender
{
//    NSInteger tag = sender.tag;
//    OffersModel *model = [self.data.offersVoList objectAtIndex:tag];
//    model.isRatioSubmit = NO;
//    CGFloat planUkbRatio = model.planUkbRatio;
//    CGFloat max = model.productMaxRatio;
//    planUkbRatio = planUkbRatio + 1;
//    if(planUkbRatio > max){
//        planUkbRatio = max;
//    }
//    
//    CGFloat planUkbPrice = model.businessPrice * (100 - planUkbRatio) / 100.0 + model.jqxCcsPrice;
//    CGFloat planUkbSavePrice = model.businessPrice * (model.productMaxRatio - planUkbRatio) / 100.0;
//    
//    model.planUkbSavePrice = planUkbSavePrice;
//    model.planUkbPrice = planUkbPrice;
//    model.planUkbRatio = planUkbRatio;
//    
//    [self.tableview reloadData];

    OffersModel *model = [self.data.offersVoList objectAtIndex:sender.tag];
//    if (!_datePicker) {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = (int)model.productMinRatio; i <= (int)model.productMaxRatio; i++) {
        [array addObject:[NSString stringWithFormat:@"%d%@", i, @"%"]];
    }
    
    _datePicker = [[LCPickView alloc] initPickviewWithArray:array isHaveNavControler:NO];
    _datePicker.delegate = self;
    _datePicker.lbTitle.text = [NSString stringWithFormat:@"%@,优惠范围(%d%@－%d%@)", model.productName, (int)model.productMinRatio, @"%", (int)model.productMaxRatio, @"%"];
//    }
    [_datePicker show];
    _datePicker.tag = sender.tag;
    [_datePicker setCurrentSelectIdx:model.planUkbRatio - model.productMinRatio];
    
    [UIView animateWithDuration:0.25 animations:^{
        CGFloat y = self.tableview.frame.origin.y + 50;//包含picker toolbar的50像素
        y += (sender.tag + 1) * 130;
        if(y - _datePicker.frame.origin.y > 0)
            self.scrollview.contentOffset = CGPointMake(0, y - _datePicker.frame.origin.y );
    }];

}

//- (void) doBtnReducePlanUBKRatio:(UIButton *)sender
//{
//    NSInteger tag = sender.tag;
//    OffersModel *model = [self.data.offersVoList objectAtIndex:tag];
//    model.isRatioSubmit = NO;
//    CGFloat planUkbRatio = model.planUkbRatio;
//    CGFloat min = model.productMinRatio;
//    planUkbRatio = planUkbRatio - 1;
//    if(planUkbRatio < min){
//        planUkbRatio = min;
//    }
//    
//    CGFloat planUkbPrice = model.businessPrice * (100 - planUkbRatio) / 100.0 + model.jqxCcsPrice;
//    CGFloat planUkbSavePrice = model.businessPrice * (model.productMaxRatio - planUkbRatio) / 100.0;
//    
//    model.planUkbSavePrice = planUkbSavePrice;
//    model.planUkbPrice = planUkbPrice;
//    model.planUkbRatio = planUkbRatio;
//    
//    [self.tableview reloadData];
//    
//    OffersModel *model = [self.data.offersVoList objectAtIndex:sender.tag];
//    _datePicker = [[LCPickView alloc] initPickviewWithArray:@[@"男", @"女"] isHaveNavControler:NO];
//    [_datePicker show];
//    _datePicker.delegate = self;
//    _datePicker.tag = sender.tag;
//    
//}

- (void) updateInsuranceRatio:(NSString *) orderId planOfferId:(NSString *)planOfferId model:(OffersModel *) model
{
    if(model.isRatioSubmit){
        OrderDetailWebVC *web = [IBUIFactory CreateOrderDetailWebVC];
        web.type = enumShareTypeToCustomer;
        web.title = @"保单详情";
//        UserInfoModel *user = [UserInfoModel shareUserInfoModel];
        if(model.productLogo)
            web.shareImgArray = [NSArray arrayWithObject:model.productLogo];
//        web.shareTitle = [NSString stringWithFormat:@"我是%@，我是优快保自由经纪人。这是为您定制的投保方案报价，请查阅。电话%@", user.realName, user.phone];
        web.shareTitle = [NSString stringWithFormat:@"您好，优快保携手%@为您定制车险",model.productName];
        [self.navigationController pushViewController:web animated:YES];
        NSString *url = [NSString stringWithFormat:@"%@/car_insur/car_insur_detail.html?insuranceType=%@&orderId=%@&planOfferId=%@", Base_Uri, @"1", orderId, planOfferId];
        [web initShareUrl:orderId insuranceType:@"1" planOfferId:planOfferId];
        [web loadHtmlFromUrl:url];
    }
    else{
        [NetWorkHandler requestToSaveOrUpdateInsuranceRatio:orderId insuranceType:@"1" planOfferId:planOfferId ratio:[NSString stringWithFormat:@"%d", (int)model.planUkbRatio] userId:[UserInfoModel shareUserInfoModel].userId Completion:^(int code, id content) {
            [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
            if(code == 200){
                OrderDetailWebVC *web = [IBUIFactory CreateOrderDetailWebVC];
                web.type = enumShareTypeToCustomer;
                web.title = @"保单详情";
                if(model.productLogo)
                    web.shareImgArray = [NSArray arrayWithObject:model.productLogo];
                UserInfoModel *user = [UserInfoModel shareUserInfoModel];
                web.shareTitle = [NSString stringWithFormat:@"我是%@，我是优快保自由经纪人。这是为您定制的投保方案报价，请查阅。电话%@", user.realName, user.phone];
                [self.navigationController pushViewController:web animated:YES];
                NSString *url = [NSString stringWithFormat:@"%@/car_insur/car_insur_detail.html?insuranceType=%@&orderId=%@&planOfferId=%@", Base_Uri, @"1", orderId, planOfferId];
                [web initShareUrl:orderId insuranceType:@"1" planOfferId:planOfferId];
                [web loadHtmlFromUrl:url];
            }
        }];
    }
}

//保单价
- (NSMutableAttributedString *)getPlanInsuranceCompanyPriceAttbuteString:(NSString *)string sub:(NSString *) sub
{
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = [string rangeOfString:sub];
    
    [attstr addAttribute:NSFontAttributeName value:_FONT(13) range:range];
    [attstr addAttribute:NSForegroundColorAttributeName value:_COLOR(0x21, 0x21, 0x21) range:range];
//    [attstr addAttribute:NSFontAttributeName value:_FONT(10) range:NSMakeRange([string length] - 3, 3)];
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};

    [attstr addAttributes:attribtDic range:range];
    return attstr;
}

//折后价
- (NSMutableAttributedString *)getPlanUkbPriceAttbuteString:(NSString *)string sub:(NSString *) sub
{
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = [string rangeOfString:sub];
    
    [attstr addAttribute:NSFontAttributeName value:_FONT(18) range:range];
    [attstr addAttribute:NSForegroundColorAttributeName value:_COLOR(0xf4, 0x43, 0x36) range:range];
//    [attstr addAttribute:NSFontAttributeName value:_FONT(13) range:NSMakeRange([string length] - 3, 3)];
    
    return attstr;
}

//赚
- (NSMutableAttributedString *)getPlanUkbSavePriceAttbuteString:(NSString *)string sub:(NSString *) sub
{
    NSMutableAttributedString *attstr = [[NSMutableAttributedString alloc] initWithString:string];
//    NSRange range = [string rangeOfString:sub];
    
//    NSRange range = NSMakeRange([string length] - 3, 3);
//    [attstr addAttribute:NSFontAttributeName value:_FONT(13) range:range];
    
    return attstr;
}

#pragma ZHPickViewDelegate

-(void)toobarDonBtnHaveClick:(LCPickView *)pickView resultString:(NSString *)resultString
{
    OffersModel *model = [self.data.offersVoList objectAtIndex:pickView.tag];
    model.isRatioSubmit = NO;
    CGFloat planUkbRatio = model.planUkbRatio;
    CGFloat max = model.productMaxRatio;
    planUkbRatio = [resultString floatValue];
    if(planUkbRatio > max){
        planUkbRatio = max;
    }
    CGFloat min = model.productMinRatio;
    if(planUkbRatio < min)
        planUkbRatio = min;
    
    CGFloat planUkbPrice = model.businessPrice * (100 - planUkbRatio) / 100.0 + model.jqxCcsPrice;
    CGFloat planAbonusPrice = model.businessPrice * (model.productMaxRatio - planUkbRatio) / 100.0 + model.businessPrice * model.allotBonusRatio * model.levelRatio/10000;
    
    model.planUkbPrice = (int)planUkbPrice;//客户价
    CGFloat last = planUkbPrice - model.planUkbPrice;
    model.planUserAllot = planAbonusPrice - last;//经纪人收益
    if(model.planUserAllot < 0)
        model.planUserAllot = 0;
    model.planUkbRatio = planUkbRatio;
    
    [self.tableview reloadData];
}

- (void) toobarDonBtnCancel:(LCPickView *)pickView
{
    [UIView animateWithDuration:0.25 animations:^{
        self.scrollview.contentOffset = CGPointMake(0, 0);
    }];
}


@end
