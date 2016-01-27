//
//  InfoTipsView.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/17.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "InfoTipsView.h"
#import "InfoTipsCell.h"
#import "define.h"

@implementation InfoTipsView
@synthesize titleColor;
@synthesize titleFont;
@synthesize itemColor;
@synthesize itemFont;
@synthesize delegate;
@synthesize lbTitle;
@synthesize tableview;

+ (id) loadFromNib
{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"InfoTipsView" owner:self options:nil];
    UIView *tmpView = [nib objectAtIndex:0];
    return tmpView;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.clipsToBounds = YES;
    }
    return self;
}

- (id)initWithTitle:(NSString *)title item:(NSArray *)item frame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        self.clipsToBounds = YES;
        
        titleFont = _FONT(15);
        titleColor = _COLOR(130, 130, 130);
        
        itemFont = _FONT(15);
        itemColor = _COLOR(130, 130, 130);
        
        [self initView];
        
        itemArray = item;
        infoTips = title;
        if(item == nil)
            self.tableHeight.constant = 0;
        else{
            self.tableHeight.constant = Info_Item_Height * [item count];
        }
    }
    
    return self;
}

- (void) initView
{
    UIView *topView = [[UIView alloc] init];
    topView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:topView];
    
    UIView *buttomView = [[UIView alloc] init];
    buttomView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:buttomView];
    
    lbTitle = [ViewFactory CreateLabelViewWithFont:titleFont TextColor:titleColor];
    [self addSubview:lbTitle];
    lbTitle.numberOfLines = 2;
    lbTitle.preferredMaxLayoutWidth = self.frame.size.width - 40;
    
    tableview = [[UITableView alloc] init];
    [self addSubview:tableview];
    tableview.dataSource = self;
    tableview.delegate = self;
    tableview.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(topView, buttomView, lbTitle, tableview);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[topView]-0-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[buttomView]-0-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[lbTitle]-20-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[tableview]-20-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[topView]-0-[lbTitle]-0-[tableview]-0-[buttomView]-0-|" options:0 metrics:nil views:views]];
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:topView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:buttomView attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
    self.tableHeight = [NSLayoutConstraint constraintWithItem:tableview attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:Info_Item_Height * 2];
    [self addConstraint:self.tableHeight];
}

//2
- (void)awakeFromNib {
    [super awakeFromNib];
    [self.tableview registerNib:[UINib nibWithNibName:@"InfoTipsCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

//4
- (void)layoutSubviews {
    [super layoutSubviews];
//    self.frame = CGRectMake(0, 40, 320, 200);
    if(!self.translatesAutoresizingMaskIntoConstraints)
        self.frame = self.frame;
    
}

#pragma UITableViewDataSource UITableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [itemArray count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return Info_Item_Height;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
    InfoTipsCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
        cell = [[InfoTipsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(delegate && [delegate respondsToSelector:@selector(HandleItemSelected:odx:)]){
        [delegate HandleItemSelected:self odx:indexPath.row];
    }
}


@end
