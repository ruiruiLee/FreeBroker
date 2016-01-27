//
//  PotentialPlayersVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/2.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "PotentialPlayersVC.h"
#import "define.h"
#import "NetWorkHandler+queryForWechatUserPageList.h"
#import "PotentialPlayerModel.h"
#import "UIImageView+WebCache.h"

@interface PotentialPlayersVC ()

@end

@implementation PotentialPlayersVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"潜在队员";
    
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 65)];
    headerview.backgroundColor = [UIColor whiteColor];
    
    UIView *topview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 25)];
    [headerview addSubview:topview];
    
    UILabel *lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, ScreenWidth - 40, 25)];
    lbTitle.backgroundColor = [UIColor clearColor];
    lbTitle.font = _FONT(12);
    lbTitle.textColor = [UIColor whiteColor];
    lbTitle.text = @"潜在队员为你已邀请的暂未注册使用保险经纪人好友";
    [topview addSubview:lbTitle];
    
    
    topview.backgroundColor = _COLORa(0x00, 0x00, 0x00, 0.1);
    
    UIView *buttom = [[UIView alloc] initWithFrame:CGRectMake(0, 25, ScreenWidth, 40)];
    [headerview addSubview:buttom];
    buttom.backgroundColor = _COLORa(245, 245, 245, 1);
    
    UILabel *lbName = [ViewFactory CreateLabelViewWithFont:_FONT(15) TextColor:_COLORa(0x21, 0x21, 0x21, 1)];
    lbName.translatesAutoresizingMaskIntoConstraints = YES;
    lbName.frame = CGRectMake(20, 0, 100, 40);
    [buttom addSubview:lbName];
    lbName.text = @"姓名";
    
    UILabel *lbArea = [ViewFactory CreateLabelViewWithFont:_FONT(15) TextColor:_COLOR(0x21, 0x21, 0x21)];
    lbArea.translatesAutoresizingMaskIntoConstraints = YES;
    lbArea.frame = CGRectMake(ScreenWidth-120, 0, 100, 40);
    [buttom addSubview:lbArea];
    lbArea.textAlignment = NSTextAlignmentRight;
    lbArea.text = @"所在地区";
    
    
    self.pulltable.tableHeaderView = headerview;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadDataInPages:(NSInteger)page
{
    [NetWorkHandler requestToQueryForWechatUserPageList:[UserInfoModel shareUserInfoModel].userId offset:page limit:LIMIT Completion:^(int code, id content) {
        [self refreshTable];
        [self loadMoreDataToTable];
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            if(page == 0)
                [self.data removeAllObjects];
            [self.data addObjectsFromArray:[PotentialPlayerModel modelArrayFromArray:[[content objectForKey:@"data"] objectForKey:@"rows"]]];
            self.total = [[content objectForKey:@"total"] integerValue];
            [self.pulltable reloadData];
        }
    }];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([self.data count] == 0){
        [self showNoDatasImage:ThemeImage(@"no_data")];
    }
    else{
        [self hidNoDatasImage];
    }
    return [self.data count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 68.f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
        cell.imageView.layer.cornerRadius = 20;
        cell.imageView.layer.borderWidth = 1;
        cell.imageView.clipsToBounds = YES;
        cell.imageView.layer.borderColor = _COLOR(0xe6, 0xe6,0xe6).CGColor;
        cell.textLabel.textColor = _COLOR(0x21, 0x21, 0x21);
        cell.textLabel.font = _FONT(15);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UILabel *lb = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 130, 30)];
        cell.accessoryView = lb;
        lb.backgroundColor = [UIColor clearColor];
        lb.textColor = _COLOR(0xcc, 0xcc, 0xcc);
        lb.font = _FONT(15);
        lb.textAlignment = NSTextAlignmentRight;
    }
    
    PotentialPlayerModel *model = [self.data objectAtIndex:indexPath.row];
    UIImage *sex = ThemeImage(@"list_user_head");
    if(model.sex == 2)
        sex = ThemeImage(@"list_user_famale");
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.headImg] placeholderImage:sex];
    if(model.headImg)
        [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.headImg] placeholderImage:sex completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            cell.imageView.image = [Util fitSmallImage:image scaledToSize:CGSizeMake(40, 40)];
        }];
    else{
        cell.imageView.image = sex;
    }
    cell.textLabel.text = model.nickName;
    if(model.nickName == nil)
        cell.textLabel.text = @"未知";
    UILabel *lb = (UILabel *) cell.accessoryView;
    lb.text = [NSString stringWithFormat:@"%@ %@", model.province, model.city];
    if(model.province == nil && model.city == nil)
        lb.text = @"未知";
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
