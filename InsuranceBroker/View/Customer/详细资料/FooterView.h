//
//  FooterView.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/7.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FooterView;

@protocol FooterViewDelegate <NSObject>

- (void) NotifyToLoadMore:(FooterView *) view;

@end

@interface FooterView : UIView
{
    UILabel *lbTitle;
}

@property (nonatomic, strong) id<FooterViewDelegate> delegate;
@property (strong, nonatomic) UIActivityIndicatorView *loadingview;
@property (strong, nonatomic) UIButton *loadbtn;

- (void) startLoading;
- (void) endLoading;

@end
