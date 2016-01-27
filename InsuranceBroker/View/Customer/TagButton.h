//
//  TagButton.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/23.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    enumTagButtonNormal,
    enumTagButtonDel,
} TagButtonType;


@class TagButton;

@protocol TagButtonDelegate <NSObject>

- (void) NotifyButtonFrameChanged:(TagButton *) sender;

@end


@interface TagButton : UIButton
{
    UIImageView *delImag;
}

@property (nonatomic, assign) TagButtonType tagType;
@property (nonatomic, weak) id<TagButtonDelegate> delagete;

@end
