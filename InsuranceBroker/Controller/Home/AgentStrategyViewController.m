//
//  AgentStrategyViewController.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/12.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "AgentStrategyViewController.h"
#import "AgentStrategyTableViewCell.h"
#import "AdScrollView.h"
#import "define.h"
#import "NetWorkHandler+strategy.h"
#import "AnnouncementModel.h"
#import "UIButton+WebCache.h"
#import "BaseStrategyView.h"

@interface AgentStrategyViewController ()
{
    NSArray *_strategyArray;
    NSMutableArray *_btnArray;
    NSMutableArray *_contentViewArray;
    
    UIButton *_adview;
    UILabel *_line;
    
    UILabel *lbSelectline;
    
    AnnouncementModel *_selectModel;
}

@end

@implementation AgentStrategyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"经纪人攻略";
    _btnArray = [[NSMutableArray alloc] init];
    _contentViewArray = [[NSMutableArray alloc] init];
    [self loadData];
}

- (void) reInitSubViews
{
    UIView *tabBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
    tabBgView.backgroundColor = [UIColor whiteColor];
    
    for (int i = 0; i < [_btnArray count]; i++) {
        UIButton *btn = [_btnArray objectAtIndex:i];
        [btn removeFromSuperview];
        
        UIView *view = [_contentViewArray objectAtIndex:i];
        [view removeFromSuperview];
    }
    
    [_btnArray removeAllObjects];
    [_contentViewArray removeAllObjects];
    
    _adview = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, ScreenWidth, [Util getHeightByWidth:3 height:1 nwidth:ScreenWidth])];
    [_adview addTarget:self action:@selector(doButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    CGFloat width = ScreenWidth / [_strategyArray count];
    CGFloat ox = 0;
    
    for (int i = 0; i < [_strategyArray count]; i++) {
        AnnouncementModel *model = [_strategyArray objectAtIndex:i];
        UIButton *btn = [self createButtonWithTitle:model.title frame:CGRectMake(ox, 0, width, 50)];
        [tabBgView addSubview:btn];
        btn.tag = 101 + i;
        ox += width;
        
        [_btnArray addObject:btn];
        
        BaseStrategyView *view = [[BaseStrategyView alloc] initWithFrame:CGRectMake(0, 66 + [Util getHeightByWidth:3 height:1 nwidth:ScreenWidth], ScreenWidth, self.view.frame.size.height - 66 - _adview.frame.size.height) Strategy:model.category];
        [self.view addSubview:view];
        view.parentvc = self;
        [_contentViewArray addObject:view];
    }
    
    [self.view addSubview:_adview];
    
    lbSelectline = [[UILabel alloc] initWithFrame:CGRectMake(0, 48, width, 2)];
    lbSelectline.backgroundColor = _COLOR(0xff, 0x66, 0x19);
    [tabBgView addSubview:lbSelectline];
    
    [self.view addSubview:tabBgView];
    
    _line = [[UILabel alloc] initWithFrame:CGRectMake(0, 65 + _adview.frame.size.height, ScreenWidth, 0.5)];
    [self.view addSubview:_line];
    _line.backgroundColor = _COLOR(0xe6, 0xe6, 0xe6);
    
    if([_btnArray count] > 0)
        [self doTabButtonClicked:[_btnArray objectAtIndex:0]];
}

- (UIButton *) createButtonWithTitle:(NSString *) title frame:(CGRect) frame
{
    UIButton *btn = [[UIButton alloc] initWithFrame:frame];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:_COLOR(0x75, 0x75, 0x75) forState:UIControlStateNormal];
    [btn setTitleColor:_COLOR(0xff, 0x66, 0x19) forState:UIControlStateSelected];
    btn.titleLabel.font = _FONT(15);
    [btn addTarget:self action:@selector(doTabButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) doTabButtonClicked:(UIButton *)sender
{
    if(sender.selected == YES)
        return;
    
    CGFloat ox = 0;
    ox = (sender.tag - 101)*ScreenWidth/[_strategyArray count];
    for (int i = 0; i < [_btnArray count]; i++) {
        UIButton *btn = [_btnArray objectAtIndex:i];
        btn.selected = NO;
    }
    for (int i = 0; i < [_contentViewArray count]; i++) {
        UIView *view = [_contentViewArray objectAtIndex:i];
        view.hidden = YES;
    }
    
    _adview.tag = sender.tag;
    
    sender.selected = YES;
    
    AnnouncementModel *model = [_strategyArray objectAtIndex:sender.tag - 101];
    BaseStrategyView *view = [_contentViewArray objectAtIndex:sender.tag - 101];
    view.hidden = NO;
    [_adview sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] forState:UIControlStateNormal placeholderImage:Normal_Image];
    if(model.imgUrl == nil){
        _adview.frame = CGRectMake(0, 50, ScreenWidth, 0);
        _line.frame = CGRectMake(0, 65 + _adview.frame.size.height, ScreenWidth, 0.5);
        view.frame = CGRectMake(0, 66 + _adview.frame.size.height, ScreenWidth, self.view.frame.size.height - 66 - _adview.frame.size.height);
    }
    else{
        _adview.frame = CGRectMake(0, 50, ScreenWidth, [Util getHeightByWidth:3 height:1 nwidth:ScreenWidth]);
        _line.frame = CGRectMake(0, 65 + _adview.frame.size.height, ScreenWidth, 0.5);
        view.frame = CGRectMake(0, 66 + _adview.frame.size.height, ScreenWidth, self.view.frame.size.height - 66 - _adview.frame.size.height);
    }
    
    if(model.isRedirect){
        _adview.userInteractionEnabled = YES;
    }else{
        _adview.userInteractionEnabled = NO;
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        lbSelectline.frame = CGRectMake(ox, 48, ScreenWidth/[_strategyArray count], 2);
    }];
    
}

- (void) loadData
{
    [NetWorkHandler requestToStrategy:^(int code, id content) {
        [self handleResponseWithCode:code msg:[content objectForKey:@"msg"]];
        if(code == 200){
            _strategyArray = [AnnouncementModel modelArrayFromArray:[[content objectForKey:@"data"] objectForKey:@"rows"]];
            if(self.view)
                [self reInitSubViews];
        }
    }];
}

- (void) doButtonClicked:(UIButton *)sender
{
    NSInteger idx = (sender.tag - 101);
    AnnouncementModel *model = [_strategyArray objectAtIndex:idx];
    if(model.isRedirect){
        WebViewController *web = [IBUIFactory CreateWebViewController];
        web.title = model.title;
        web.type = enumShareTypeShare;
        web.shareTitle = model.title;
        if(model.imgUrl != nil)
            web.shareImgArray = [NSArray arrayWithObject:model.imgUrl];
        [self.navigationController pushViewController:web animated:YES];
        [web loadHtmlFromUrlWithUserId:model.url];
    }
}

@end
