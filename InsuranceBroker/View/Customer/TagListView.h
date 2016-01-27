//
//  TagListView.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/23.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TagListView;

@protocol TagListViewDelegate <NSObject>

- (void) NotifyTagListViewHeightChangeTo:(NSInteger) height TagList:(TagListView*) view;
- (void) NotifySelectTag:(NSArray *) labelArray;

@end

@interface TagListView : UIView
{
    NSMutableArray *viewArray;
    NSMutableArray *labelArray;
    
}


@property (nonatomic, weak) id<TagListViewDelegate> delegate;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *ownerArray;

@end
