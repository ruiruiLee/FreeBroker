//
//  UserPolicyListView.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/24.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "BaseInsuranceInfo.h"
#import "PolicyInfoTableViewCell.h"
#import "define.h"

@implementation BaseInsuranceInfo
@synthesize tableview;
@synthesize lbSepLine;
@synthesize lbTitle;
@synthesize btnEdit;

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.lbTitle = [ViewFactory CreateLabelViewWithFont:_FONT(15) TextColor:_COLOR(0x21, 0x21, 0x21)];
        [self addSubview:self.lbTitle];
        
        btnEdit = [[UIButton alloc] initWithFrame:CGRectZero];
        [self addSubview:btnEdit];
        btnEdit.translatesAutoresizingMaskIntoConstraints = NO;
        [btnEdit addTarget:self action:@selector(doEditButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        self.lbSepLine = [ViewFactory CreateLabelViewWithFont:_FONT(15) TextColor:nil];
        [self addSubview:self.lbSepLine];
        lbSepLine.backgroundColor = _COLOR(0xe6, 0xe6, 0xe6);
        
        tableview = [[UITableView alloc] initWithFrame:CGRectZero];
        [self addSubview:tableview];
        tableview.delegate = self;
        tableview.dataSource = self;
        self.tableview.scrollEnabled = NO;
        tableview.translatesAutoresizingMaskIntoConstraints = NO;
        
        UIEdgeInsets insets = UIEdgeInsetsMake(0, 20, 0, 20);
        self.tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.tableview.separatorColor = _COLOR(0xe6, 0xe6, 0xe6);
        if ([self.tableview respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableview setSeparatorInset:insets];
        }
        if ([self.tableview respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.tableview setLayoutMargins:insets];
        }
        
        NSDictionary *views = NSDictionaryOfVariableBindings(lbTitle, lbSepLine, tableview, btnEdit);
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-30-[lbTitle]-10-[lbSepLine(1)]-0-[tableview]-10-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[lbTitle]->=10-[btnEdit]-20-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[lbSepLine]-20-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableview]-0-|" options:0 metrics:nil views:views]];
        
        [self addConstraint:[NSLayoutConstraint constraintWithItem:btnEdit attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:lbTitle attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
        
    }
    
    return self;
}

- (CGFloat) resetSubviewsFrame
{
    NSInteger num = [self tableView:self.tableview numberOfRowsInSection:0];
    CGFloat tableheight = 0;
    if(num > 0){
        CGFloat cellheight = [self tableView:self.tableview heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        tableheight = cellheight * num;
    }
    
    return tableheight + 58 + 18;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
}

- (void) doEditButtonClicked:(UIButton *)sender
{
    
}

#pragma UITableViewDataSource UITableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 20, 0, 20);
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:insets];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:insets];
    }
}

@end
