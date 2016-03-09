//
//  MenuViewController.m
//  MneuDemo
//
//  Created by iHope on 13-9-17.
//  Copyright (c) 2013年 iHope. All rights reserved.
//

#import "MenuViewController.h"
#import "define.h"
#import "MenuCell.h"
#import "DictModel.h"

@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize titleArray;
@synthesize title;


//初始化
- (id)initWithTitles:(NSArray *) titles
{
    self = [super init];
    if (self) {
        titleArray = titles;
        self.selectIdx = -1;
        _tag = 0;
    }
    return self;
}
//显示
- (void) show:(UIView*)parent
{
    parentView = parent;
    
    //先隐藏backView,table
    backView.alpha = 0;
    self.headView.alpha = 0;
    
    //移动table
//    [self.headView setTransform:CGAffineTransformMakeTranslation(0, self.headView.frame.size.height)];
    
    //父窗口添加本view，---这个会调用viewDidLoad
    [parentView.superview addSubview:self.view];
    
    //添加动画，添加到父窗口中，使之从下移动上
    [UIView animateWithDuration:0.3 animations:^{
        //父窗口缩小
//        CGAffineTransform t = CGAffineTransformMakeScale(0.9, 0.9);
 //       [parentView setTransform:t];
        
        //显示backview,table
        backView.alpha = 1;
        self.headView.alpha = 1;
        
        //移动table,CGAffineTransformIdentity还原原始坐标
//        [self.headView setTransform:CGAffineTransformIdentity];
        CGRect frame = self.headView.frame;
        CGRect rect = self.view.bounds;
        self.headView.frame = CGRectMake(frame.origin.x, rect.size.height - frame.size.height, frame.size.width, frame.size.height);

    } completion:^(BOOL finished) {

    }];
    
    
}

//隐藏
- (void) hide
{
    //添加动画，添加到父窗口中，使之从下移动上
    [UIView animateWithDuration:0.3 animations:^{
        //父窗口还原 
 //       CGAffineTransform t = CGAffineTransformIdentity;
  //      [parentView setTransform:t];
        
        //显示backview,table
        backView.alpha = 0;
        self.headView.alpha = 0;
        
        //移动table
//        [self.headView setTransform:CGAffineTransformMakeTranslation(0, self.headView.frame.size.height)];
        
        CGRect frame = self.headView.frame;
        CGRect rect = self.view.bounds;
        self.headView.frame = CGRectMake(frame.origin.x, rect.size.height, frame.size.width, frame.size.height);
        
    } completion:^(BOOL finished) {
        [self.view removeFromSuperview];
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    
    //背影黑罩
    backView = [[UIView alloc]initWithFrame:self.view.bounds];
    backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    [self.view addSubview:backView];
    
    //算出table的CGRect
    CGRect rect = self.view.bounds;
    int height = titleArray.count * 60;
    if(height > 264)
        height = 264;
    rect.origin.y = rect.size.height - height - 60;
    rect.size.height = height;
    
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, rect.size.height + 60)];
    [self.view addSubview:self.headView];
    self.headView.backgroundColor = [UIColor whiteColor];
    self.headView.userInteractionEnabled = YES;
    
    self.lbTitle = [[UILabel alloc] initWithFrame:CGRectMake(20, 24, 200, 20)];
    [self.headView addSubview:self.lbTitle];
    self.lbTitle.backgroundColor = [UIColor clearColor];
    self.lbTitle.font = _FONT(15);
    self.lbTitle.textColor = _COLOR(0x21, 0x21, 0x21);
    self.lbTitle.text = title;
    
    line = [[UILabel alloc] initWithFrame:CGRectMake(0, 59, rect.size.width, 0.5)];
    [self.headView addSubview:line];
    line.backgroundColor = _COLOR(0xe6, 0xe6, 0xe6);
    
    _table = [[UITableView alloc]initWithFrame:CGRectMake(0, 60, rect.size.width, height)];
    _table.delegate = self;
    _table.dataSource = self;
    [_table registerNib:[UINib nibWithNibName:@"MenuCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.headView addSubview:_table];
    _table.separatorStyle = UITableViewCellSeparatorStyleNone;
    _table.backgroundColor = [UIColor clearColor];

}
#pragma UITableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"cell";
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
//        cell = [[MenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"MenuCell" owner:nil options:nil];
        cell = [nibs lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }

    [cell.btnSelect setImage:ThemeImage(@"unselect_point") forState:UIControlStateNormal];
    [cell.btnSelect setImage:ThemeImage(@"select_point") forState:UIControlStateSelected];
    DictModel *model = [titleArray objectAtIndex:indexPath.row];
    cell.lbTitle.text = model.dictName;
    
    if(self.selectIdx == indexPath.row)
        cell.btnSelect.selected = YES;
    else
        cell.btnSelect.selected = NO;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [_menuDelegate menuViewController:self AtIndex:indexPath.row];
    self.selectIdx = indexPath.row;
    [tableView reloadData];
}

#pragma touch
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_menuDelegate menuViewControllerDidCancel:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

- (void) setTitleArray:(NSArray *)array
{
    titleArray = array;
    [self.table reloadData];
    CGRect frame = self.headView.frame;
    CGFloat headHeight = titleArray.count * 60 + 60;
    if(headHeight > 308)
        headHeight = 308;
    self.headView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, headHeight);
    _table.frame = CGRectMake(0, 60, frame.size.width, headHeight - 60);
}

- (void) setTitle:(NSString *)text
{
    title = text;
    if(self.lbTitle){
        self.lbTitle.text = title;
    }
}

- (void) setSelectIdx:(NSInteger)selectIdx
{
    _selectIdx = selectIdx;
    [self.table reloadData];
}

@end
