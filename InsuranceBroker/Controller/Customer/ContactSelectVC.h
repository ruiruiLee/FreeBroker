//
//  ContactSelectVC.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/23.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "BasePullTableVC.h"

@class ContactSelectVC;

typedef enum : NSUInteger {
    enumFunctionAdd,
    enumFunctionDel,
} enumFunction;

@protocol ContactSelectVCDelegate <NSObject>

//0:减少 1:增加
- (void) NotifyItemChanged:(ContactSelectVC *) selectVC ChangedItems:(NSArray *) items isDelOrAdd:(BOOL) isDelOrAdd;

@end

@interface ContactSelectVC : BasePullTableVC<UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, strong) UISearchBar *searchbar;
@property (nonatomic, assign) enumFunction type;
@property (nonatomic, weak) id<ContactSelectVCDelegate> delegate;
@property (nonatomic, strong) NSArray *rawData;
@property (nonatomic, strong) NSMutableArray *resultData;

@end
