//
//  CustomerPanEditView.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/23.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "CustomerPanEditView.h"
#import "define.h"
#import "CustomerInfoModel.h"
#import "EditButton.h"

#define Btn_width 55

@implementation CustomerPanEditView
@synthesize delegate;

- (id) initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if(self){
        self.clipsToBounds = YES;
        
        self.editType = enumEditTypeNormal;
        
        viewArray = [[NSMutableArray alloc] init];
        
        btnAdd = [[TopImageButton alloc] initWithFrame:CGRectZero];
        [btnAdd setImage:ThemeImage(@"add_user") forState:UIControlStateNormal];
        btnAdd.titleLabel.font = _FONT(14);
        [self addSubview:btnAdd];
        [btnAdd addTarget:self action:@selector(doBtnAddUser:) forControlEvents:UIControlEventTouchUpInside];
        
        btnDel = [[TopImageButton alloc] initWithFrame:CGRectZero];
        [btnDel setImage:ThemeImage(@"del_user") forState:UIControlStateNormal];
        btnDel.titleLabel.font = _FONT(14);
        [self addSubview:btnDel];
        [btnDel addTarget:self action:@selector(doBtnDelUser:) forControlEvents:UIControlEventTouchUpInside];
        
        [self resetSubViews];
    }
    
    return self;
}

- (id) initWithFrame:(CGRect)frame Array:(NSArray *) array
{
    self = [super initWithFrame:frame];
    if(self){
        userArray = [[NSMutableArray alloc] initWithArray:array];
        viewArray = [[NSMutableArray alloc] init];
        
        [self initViews];
        
        btnAdd = [[TopImageButton alloc] initWithFrame:CGRectZero];
        [btnAdd setImage:ThemeImage(@"add_user") forState:UIControlStateNormal];
        btnAdd.titleLabel.font = _FONT(14);
        [self addSubview:btnAdd];
        [btnAdd addTarget:self action:@selector(doBtnAddUser:) forControlEvents:UIControlEventTouchUpInside];
        
        btnDel = [[TopImageButton alloc] initWithFrame:CGRectZero];
        [btnDel setImage:ThemeImage(@"del_user") forState:UIControlStateNormal];
        btnDel.titleLabel.font = _FONT(14);
        [self addSubview:btnDel];
        [btnDel addTarget:self action:@selector(doBtnDelUser:) forControlEvents:UIControlEventTouchUpInside];
        
        [self resetSubViews];
    }
    
    return self;
}

- (void) initViews
{
    for (int i = 0; i < [viewArray count]; i++) {
        UIView *view = [viewArray objectAtIndex:i];
        [view removeFromSuperview];
    }
    
    [viewArray removeAllObjects];
    
    for (int i = 0; i < [userArray count]; i++) {
        EditButton *btn = [[EditButton alloc] initWithFrame:CGRectZero];
        [btn setImage:ThemeImage(@"user_head") forState:UIControlStateNormal];
        CustomerInfoModel *model = [userArray objectAtIndex:i];
        [btn setTitle:model.customerName forState:UIControlStateNormal];
        [btn setTitleColor:_COLOR(0x75, 0x75, 0x75) forState:UIControlStateNormal];
        btn.titleLabel.font = _FONT(14);
        [btn addTarget:self action:@selector(doBtnCustomerClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.model = model;
        
        [viewArray addObject:btn];
        [self addSubview:btn];
    }
    
    self.editType = enumEditTypeNormal;
}

- (void) resetSubViews
{
    for (int i = 0; i < [viewArray count]; i++) {
        TopImageButton *btn = [viewArray objectAtIndex:i];
        
        [self resetCombtnFrame:btn idx:i];
    }
    
    [self resetCombtnFrame:btnAdd idx:[viewArray count]];
    [self resetCombtnFrame:btnDel idx:[viewArray count] + 1];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(NotifyEditFrameChanged:)]){
        [self.delegate NotifyEditFrameChanged:[viewArray count] + 2];
    }
}

- (void) resetCombtnFrame:(TopImageButton *) btn idx:(NSInteger)idx
{
    CGFloat ox = 10;
    CGFloat oy = 10;
    CGFloat space = (ScreenWidth - 40 - Btn_width * 4)/3;
    CGFloat itemHeight = Btn_width + 20;
    
    CGFloat bh = oy + (idx / 4) * (itemHeight + 10);
    
    btn.frame = CGRectMake(ox + ((idx % 4)) * (space + Btn_width), bh, Btn_width, itemHeight);
}

- (void) setUserArray:(NSArray *)array
{
    userArray = [[NSMutableArray alloc] initWithArray:array];
    [self initViews];
    
    [self resetSubViews];
}

- (void) doBtnCustomerClicked:(EditButton *) sender
{
    if(sender.editType == enumEditTypeNormal){
        if(delegate && [delegate respondsToSelector:@selector(NotifyToViewDetail:)]){
            [delegate NotifyToViewDetail:sender.model];
        }
    }
    else{
        if(delegate && [delegate respondsToSelector:@selector(NotifyToDelObject:)]){
            [delegate NotifyToDelObject:sender.model];
            [sender removeFromSuperview];
            [viewArray removeObject:sender];
        }
        
        [self resetSubViews];
    }
}

- (void) doBtnAddUser:(id) sender
{
    self.editType = enumEditTypeNormal;
    if(delegate && [delegate respondsToSelector:@selector(NotifyEditContact:)]){
        [delegate NotifyEditContact:YES];
    }
}

- (void) doBtnDelUser:(id) sender
{
//    if(delegate && [delegate respondsToSelector:@selector(NotifyEditContact:)]){
//        [delegate NotifyEditContact:NO];
//    }
    self.editType = enumEditTypeDel;
}

- (void) setEditType:(enumEditType)type
{
    _editType = type;
    for (int i = 0; i < [viewArray count]; i++) {
        EditButton *btn = [viewArray objectAtIndex:i];
        
        btn.editType = type;
    }
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    self.editType = enumEditTypeNormal;
}

@end
