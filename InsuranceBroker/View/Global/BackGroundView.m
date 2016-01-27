//
//  BackGroundView.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/20.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BackGroundView.h"
#import "define.h"

@implementation BackGroundView
@synthesize delegate;

+ (id) loadFromNib
{
    NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"BackGroundView" owner:self options:nil];
    UIView *tmpView = [nib objectAtIndex:0];
    return tmpView;
}

- (id) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [BackGroundView loadFromNib];
        [self addSubview:view];
        view.translatesAutoresizingMaskIntoConstraints = NO;
        
        self.btnAdd = [view viewWithTag:1001];
        self.btnAdd.layer.cornerRadius = 3;
        [self.btnAdd addTarget:self action:@selector(doBtnAdd:) forControlEvents:UIControlEventTouchUpInside];
        NSDictionary *views = NSDictionaryOfVariableBindings(view);
        
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[view]-0-|" options:0 metrics:nil views:views]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[view]-0-|" options:0 metrics:nil views:views]];
    }
    
    return self;
}

- (void) awakeFromNib
{
    [super awakeFromNib];
}

- (void) doBtnAdd:(UIButton *)sender
{
    if(delegate && [delegate respondsToSelector:@selector(notifyToAddNewCustomer:)])
        [delegate notifyToAddNewCustomer:self];
}

@end
