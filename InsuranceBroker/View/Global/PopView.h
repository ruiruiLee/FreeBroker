//
//  PopView.h
//  SpringCare
//
//  Created by LiuZach on 15/11/20.
//  Copyright © 2015年 cmkj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PopView;

@protocol PopViewDelegate <NSObject>

- (void) HandleItemSelect:(PopView *) view withTag:(NSInteger) tag;

@end

@interface PopView : UIView

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *view;

@property (nonatomic, weak) id<PopViewDelegate> delegate;


- (id) initWithImageArray:(NSArray*) images nameArray:(NSArray*) names;

- (void) show;

- (void) hidden;

@end
