//
//  RedPackTasksInfoTips.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RedPackInfoTips.h"

@interface RedPackTasksInfoTips : RedPackInfoTips

@property (nonatomic, strong) UILabel *lbTask1;

- (id) initWithTaskName:(NSString *) taskname;

@end
