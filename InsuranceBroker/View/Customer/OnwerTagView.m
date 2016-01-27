//
//  OnwerTagView.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/23.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "OnwerTagView.h"
#import "define.h"
#import "TagButton.h"

@implementation OnwerTagView

@synthesize dataArray;
@synthesize delegate;
@synthesize textfield;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        //        self.clipsToBounds = YES;
        viewArray = [[NSMutableArray alloc] init];
        modelArray = [[NSMutableArray alloc] init];
        
        textfield = [[DashBorderTextfield alloc] initWithFrame:CGRectMake(0, 0, 86, 26)];
        [self addSubview:textfield];
        textfield.delegate = self;
    }
    
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        //        self.clipsToBounds = YES;
        viewArray = [[NSMutableArray alloc] init];
        modelArray = [[NSMutableArray alloc] init];
        
        textfield = [[DashBorderTextfield alloc] initWithFrame:CGRectMake(0, 0, 86, 26)];
        [self addSubview:textfield];
        textfield.delegate = self;
    }
    
    return self;
}

- (void) setDataArray:(NSArray *)_dataArray
{
    dataArray = _dataArray;
    [self performSelector:@selector(initSubViews) withObject:nil afterDelay:0.2];
}

- (void) initSubViews
{
    for (int i = 0; i < [viewArray count]; i++) {
        UIView *view = [viewArray objectAtIndex:i];
        [view removeFromSuperview];
    }
    [viewArray removeAllObjects];
    [modelArray removeAllObjects];
    
    [modelArray addObjectsFromArray:dataArray];
    
    for (int i = 0; i < [dataArray count]; i++) {
        NSString *str = [dataArray objectAtIndex:i];
        if([str isKindOfClass:[TagObjectModel class]])
            str = ((TagObjectModel*)str).labelName;
        
        TagButton *btn = [[TagButton alloc] initWithFrame:CGRectZero];
        [btn setTitle:str forState:UIControlStateNormal];
        btn.layer.cornerRadius = 13;
        btn.layer.borderWidth = 1;
        btn.layer.borderColor = _COLOR(0xff, 0x66, 0x19).CGColor;
        [btn setTitleColor:_COLOR(0xff, 0x66, 0x19) forState:UIControlStateNormal];
        btn.titleLabel.font = _FONT(15);
        btn.tag = 100 + i;
        
        [viewArray addObject:btn];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(doBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [self reset];
}

- (void) layoutSubviews
{
    [super layoutSubviews];
}

- (void) reset
{
    CGRect frame = self.frame;
    CGFloat width = frame.size.width;
    
    CGFloat ox = 0;
    CGFloat oy = 10;
    
    for (int i = 0; i < [viewArray count]; i++) {
        TagButton *btn = [viewArray objectAtIndex:i];
        NSString *title = btn.titleLabel.text;
        CGSize size = [title sizeWithFont:btn.titleLabel.font constrainedToSize:CGSizeMake(INT_MAX, 26)];
        
        CGFloat nx = ox + size.width + 20;
        if(nx > frame.size.width){
            oy += 36;
            ox = 0;
        }
        
        btn.frame = CGRectMake(ox, oy, size.width + 20, 26);
        
        ox += size.width + 30;
    }
    
    CGFloat nx = ox + textfield.frame.size.width;
    if(nx > frame.size.width){
        oy += 36;
        ox = 0;
    }
    
    textfield.frame = CGRectMake(ox, oy, textfield.frame.size.width, textfield.frame.size.height);
    
    if(delegate && [delegate respondsToSelector:@selector(NotifyOwnerTagViewHeightChange:tagView:)]){
        [delegate NotifyOwnerTagViewHeightChange:oy + 36 tagView:self];
    }
}

- (void) addTagWithTagId:(NSString *)tagId
{
    
}

- (void) doBtnClicked:(TagButton *)sender
{
    TagButtonType type = sender.tagType;
    if(type == enumTagButtonNormal){
        sender.tagType = enumTagButtonDel;
    }else{
        [viewArray removeObject:sender];
        [sender removeFromSuperview];
        TagObjectModel *model = [dataArray objectAtIndex:sender.tag - 100];
        [modelArray removeObject:model];
        
        if(delegate && [delegate respondsToSelector:@selector(NotifyOwnerTagSelectedChanged:)]){
            [delegate NotifyOwnerTagSelectedChanged:modelArray];
        }
    }
    
    [self resetSubViews];
}

- (void) resetSubViews
{
    CGRect frame = self.frame;
    CGFloat width = frame.size.width;
    
    CGFloat ox = 0;
    CGFloat oy = 10;
    
    for (int i = 0; i < [viewArray count]; i++) {
        TagButton *btn = [viewArray objectAtIndex:i];
        CGSize size = btn.frame.size;
        
        CGFloat nx = ox + size.width;
        if(nx > frame.size.width){
            oy += 36;
            ox = 0;
        }
        
        btn.frame = CGRectMake(ox, oy, size.width, 26);
        
        ox += size.width + 10;
    }
    
    CGFloat nx = ox + textfield.frame.size.width;
    if(nx > frame.size.width){
        oy += 36;
        ox = 0;
    }
    
    textfield.frame = CGRectMake(ox, oy, textfield.frame.size.width, textfield.frame.size.height);
    
    if(delegate && [delegate respondsToSelector:@selector(NotifyOwnerTagViewHeightChange:tagView:)]){
        [delegate NotifyOwnerTagViewHeightChange:oy + 36 tagView:self];
    }
}

//- (BOOL) DelPrevTag:(DashBorderTextfield *) sender
//{
//    TagButton *btn = [viewArray lastObject];
//    if(btn != nil)
//    {
//        if(btn.tagType == enumTagButtonNormal)
//            btn.tagType = enumTagButtonDel;
//        else{
//            [viewArray removeObject:btn];
//            [btn removeFromSuperview];
//        }
//    }
//    return YES;
//}

- (NSArray *) getSelectedLabelName
{
    return modelArray;
}

- (NSString *) getEditLabelName
{
    NSString *text = textfield.textfield.text;
    return text;
}

@end
