//
//  InfoTipsView.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/17.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>

//任务条 高
#define Info_Item_Height 40


@class InfoTipsView;

@protocol InfoTipsViewDelegate <NSObject>

- (void) HandleItemSelected:(InfoTipsView*) infoTip odx:(NSInteger) idx;

@end

@interface InfoTipsView : UIImageView<UITableViewDataSource, UITableViewDelegate>
{
    NSArray *itemArray;
    NSString *infoTips;
}

@property (nonatomic, strong) IBOutlet UILabel *lbTitle;
@property (nonatomic, strong) IBOutlet UITableView *tableview;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *tableHeight;

@property (nonatomic, strong) UIFont *titleFont;
@property (nonatomic, strong) UIFont *itemFont;
@property (nonatomic, strong) UIColor *titleColor;
@property (nonatomic, strong) UIColor *itemColor;

@property (nonatomic, weak) id<InfoTipsViewDelegate> delegate;

+ (id) loadFromNib;
- (id)initWithTitle:(NSString *)title item:(NSArray *)item frame:(CGRect)frame;

@end
