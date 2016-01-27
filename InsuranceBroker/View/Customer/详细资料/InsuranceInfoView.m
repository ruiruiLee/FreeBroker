//
//  InsuranceInfoView.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/24.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "InsuranceInfoView.h"
#import "define.h"

@implementation InsuranceInfoView
@synthesize delegate;
@synthesize addCarInfo;
@synthesize lbExplain;
@synthesize lbSepLine;
@synthesize lbTitle;
@synthesize btnAdd;

//+ (id) loadFromNib
//{
//    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"InsuranceInfoView" owner:self options:nil];
//    UIView *tmpView = [nib objectAtIndex:0];
//    return tmpView;
//}

//- (id) initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if(self){
//        self.btnAdd.layer.cornerRadius = 3;
//    }
//    
//    return self;
//}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        [self initSubViews];
        self.btnAdd.layer.cornerRadius = 3;
    }
    
    return self;
}

- (void) initSubViews
{
    addCarInfo = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:addCarInfo];
    addCarInfo.translatesAutoresizingMaskIntoConstraints = NO;
    
    btnAdd = [[UIButton alloc] initWithFrame:CGRectZero];
    [self addSubview:btnAdd];
    btnAdd.translatesAutoresizingMaskIntoConstraints = NO;
    btnAdd.backgroundColor = _COLOR(0xff, 0x66, 0x19);
    [btnAdd setTitle:@"立即添加" forState:UIControlStateNormal];
    [btnAdd setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnAdd.titleLabel.font = _FONT(15);
    [btnAdd addTarget:self action:@selector(handleAddButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    lbExplain = [ViewFactory CreateLabelViewWithFont:_FONT(15) TextColor:_COLOR(0x75, 0x75, 0x75)];
    [self addSubview:lbExplain];
    lbExplain.textAlignment = NSTextAlignmentCenter;
    
    lbTitle = [ViewFactory CreateLabelViewWithFont:_FONT(15) TextColor:_COLOR(0x21, 0x21, 0x21)];
    [self addSubview:lbTitle];
    
    lbSepLine = [ViewFactory CreateLabelViewWithFont:_FONT(15) TextColor:_COLOR(0x21, 0x21, 0x21)];
    [self addSubview:lbSepLine];
    lbSepLine.backgroundColor = _COLOR(0xe6, 0xe6, 0xe6);
    
    NSDictionary *views = NSDictionaryOfVariableBindings(addCarInfo, btnAdd, lbExplain, lbSepLine, lbTitle);
    
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[lbTitle]-20-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[lbSepLine]-20-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[lbExplain]-20-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-90-[btnAdd]-90-|" options:0 metrics:nil views:views]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[lbTitle]-10-[lbSepLine(1)]-40-[lbExplain]-20-[btnAdd(40)]->=10-|" options:0 metrics:nil views:views]];
}

- (void) awakeFromNib
{
    [super awakeFromNib];
    self.btnAdd.layer.cornerRadius = 3;
    self.type = enumInsuranceInfoViewTypeInsurance;
    [self.btnAdd addTarget:self action:@selector(handleAddButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void) handleAddButtonClicked:(UIButton *)sender
{
    if(delegate && [delegate respondsToSelector:@selector(NotifyAddButtonClicked:type:)])
    {
        [delegate NotifyAddButtonClicked:self type:self.type];
    }
}

- (void) setType:(InsuranceInfoViewType)type
{
    _type = type;
    if(type == enumInsuranceInfoViewTypePolicy)
        self.btnAdd.hidden = YES;
    else
        self.btnAdd.hidden = NO;
}

@end
