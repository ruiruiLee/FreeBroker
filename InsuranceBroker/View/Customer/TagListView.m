//
//  TagListView.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/23.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "TagListView.h"
#import "define.h"

@implementation TagListView
@synthesize dataArray;
@synthesize delegate;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        //        self.clipsToBounds = YES;
        viewArray = [[NSMutableArray alloc] init];
        labelArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        //        self.clipsToBounds = YES;
        viewArray = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) setDataArray:(NSArray *)_dataArray
{
    dataArray = _dataArray;
    [self initSubViews];
}

- (void) initSubViews
{
    for (int i = 0; i < [viewArray count]; i++) {
        UIView *view = [viewArray objectAtIndex:i];
        [view removeFromSuperview];
    }
    [viewArray removeAllObjects];
    
    for (int i = 0; i < [dataArray count]; i++) {
        NSString *str = ((TagObjectModel*)[dataArray objectAtIndex:i]).labelName;
        
        UIButton *btn = [[UIButton alloc] init];
        [btn setTitle:str forState:UIControlStateNormal];
        btn.layer.cornerRadius = 13;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = _COLOR(0x75, 0x75, 0x75).CGColor;
        [btn setTitleColor:_COLOR(0x21, 0x21, 0x21) forState:UIControlStateNormal];
        [btn setTitleColor:_COLOR(0xff, 0x66, 0x19) forState:UIControlStateSelected];
        btn.titleLabel.font = _FONT(15);
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(doBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [viewArray addObject:btn];
        [self addSubview:btn];
    }
    
    [self reset];
}

- (void) doBtnClicked:(UIButton *)sender
{
    TagObjectModel *model = [dataArray objectAtIndex:sender.tag - 100];
    BOOL selected = sender.selected;
    if(selected){
        sender.layer.borderColor = _COLOR(0x75, 0x75, 0x75).CGColor;
        [labelArray removeObject:model];
    }else{
        sender.layer.borderColor = _COLOR(0xff, 0x66, 0x19).CGColor;
        [labelArray addObject:model];
    }
    sender.selected = !selected;
    
    if(delegate && [delegate respondsToSelector:@selector(NotifySelectTag:)]){
        [delegate NotifySelectTag:labelArray];
    }
}


- (void) layoutSubviews
{
    [super layoutSubviews];
    [self reset];
}

- (void) reset
{
    CGRect frame = self.frame;
    CGFloat width = frame.size.width;
    
    CGFloat ox = 0;
    CGFloat oy = 10;
    
    [labelArray removeAllObjects];
    
    for (int i = 0; i < [viewArray count]; i++) {
        UIButton *btn = [viewArray objectAtIndex:i];
        NSString *title = btn.titleLabel.text;
        CGSize size = [title sizeWithFont:btn.titleLabel.font constrainedToSize:CGSizeMake(INT_MAX, 26)];
        
        CGFloat nx = ox + size.width + 20;
        if(nx > frame.size.width){
            oy += 36;
            ox = 0;
        }
        
        btn.frame = CGRectMake(ox, oy, size.width + 20, 26);
        
        NSString *labelId = ((TagObjectModel*)[dataArray objectAtIndex:i]).labelId;
        if([self searchTagIdInOwnerArray:labelId]){
            btn.layer.borderColor = _COLOR(0xff, 0x66, 0x19).CGColor;
            btn.selected = YES;
            [labelArray addObject:[dataArray objectAtIndex:i]];
        }else{
            btn.layer.borderColor = _COLOR(0x75, 0x75, 0x75).CGColor;
            btn.selected = NO;
        }
        
        ox += size.width + 30;
    }
    
    if(delegate && [delegate respondsToSelector:@selector(NotifyTagListViewHeightChangeTo:TagList:)]){
        [delegate NotifyTagListViewHeightChangeTo:oy + 36 TagList:self];
    }
}

- (BOOL) searchTagIdInOwnerArray:(NSString *) tagId
{
    BOOL result = NO;
    for (int i = 0; i < [self.ownerArray count]; i++) {
//        NSString *tag = [self.ownerArray objectAtIndex:i];
        TagObjectModel *model = [self.ownerArray objectAtIndex:i];
        NSString *tag = model.labelId;
        if([tagId isEqualToString:tag])
            return YES;
    }
    
    return result;
}

- (void) setOwnerArray:(NSArray *)array
{
    _ownerArray = array;
    [self reset];
}

@end
