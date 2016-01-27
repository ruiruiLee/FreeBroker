//
//  OnwerTagView.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/23.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DashBorderTextfield.h"

@class OnwerTagView;

@protocol OnwerTagViewDelegate <NSObject>

- (void) NotifyOwnerTagViewHeightChange:(NSInteger) height tagView:(OnwerTagView *) view;
- (void) NotifyOwnerTagSelectedChanged:(NSArray *) labelArray;

@end

@interface OnwerTagView : UIView <DashBorderTextfieldDelegate>
{
    NSMutableArray *viewArray;
    
    NSMutableArray *modelArray;
}

@property (nonatomic, weak) id<OnwerTagViewDelegate> delegate;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) DashBorderTextfield *textfield;

- (void) addTagWithTagId:(NSString *)tagId;
- (NSArray *) getSelectedLabelName;
- (NSString *) getEditLabelName;

@end
