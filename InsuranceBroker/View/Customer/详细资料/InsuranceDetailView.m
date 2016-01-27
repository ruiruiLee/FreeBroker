//
//  InsuranceDetailView.m
//  
//
//  Created by LiuZach on 15/12/25.
//
//

#import "InsuranceDetailView.h"
#import "InsuranceTableViewCell.h"
#import "define.h"

@implementation InsuranceDetailView

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self.tableview registerNib:[UINib nibWithNibName:@"InsuranceTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
        self.tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.lbTitle.text = @"投保资料";
        [self.btnEdit setImage:ThemeImage(@"edit_profile") forState:UIControlStateNormal];
    }
    
    return self;
}

- (void) doEditButtonClicked:(UIButton *)sender
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(NotifyModifyInsuranceInfo:)]){
        [self.delegate NotifyModifyInsuranceInfo:self];
    }
}

#pragma UITableViewDataSource UITableViewDelegate

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_carInfo == nil)
        return 0;
    else
        return 4;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
    InsuranceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
        cell = [[InsuranceTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
    }
    
    NSInteger row = indexPath.row;
    if(row == 0)
        [self setCellData:cell title:@"品牌型号" value:_carInfo.carTypeNo];
    else if (row == 1)
        [self setCellData:cell title:@"车牌号码" value:_carInfo.carNo];
    else if (row == 2)
        [self setCellData:cell title:@"车辆识别代码" value:_carInfo.carShelfNo];
    else if (row == 3)
        [self setCellData:cell title:@"发动机号码" value:_carInfo.carEngineNo];
    else if (row == 4){
//        NSDate *carRegTime = _carInfo.carRegTime;
//        NSString *sub = [_carInfo.carRegTime substringToIndex:10];
        [self setCellData:cell title:@"注册日期" value:[Util getDayString:_carInfo.carRegTime]];
    }
    return cell;
}

- (void) setCellData:(InsuranceTableViewCell *) cell title:(NSString *)title value:(NSString *) value
{
    cell.lbTitle.text = title;
    cell.lbDetail.text = value;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void) setCarInfo:(CarInfoModel *)model
{
    _carInfo = model;
    [self.tableview reloadData];
}

@end
