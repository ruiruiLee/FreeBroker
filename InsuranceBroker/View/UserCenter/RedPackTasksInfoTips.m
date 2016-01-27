//
//  RedPackTasksInfoTips.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "RedPackTasksInfoTips.h"
#import "define.h"

@implementation RedPackTasksInfoTips

- (id) initWithTaskName:(NSString *) taskname
{
    self = [super init];
    if(self){
        
        CGSize size = [taskname sizeWithFont:_FONT(15) constrainedToSize:CGSizeMake(ScreenWidth - 100, 1000)];
        
        if(size.height > 90)
            size.height = 90;
        self.bgview.frame = CGRectMake(30, 0, ScreenWidth - 60, 270 + size.height);
        self.bgview.center = self.alview.center;
        self.logo.image = ThemeImage(@"jiayou");
        self.lbShowInfo.text = @"就差一点点咯！";
        self.lbDetail.text = @"快完成下面任务，把我带走吧！";
        
        self.btnSubmit.frame = CGRectMake(16, self.bgview.frame.size.height - 50, ScreenWidth - 92, 36);
        
        self.lbTask1 = [ViewFactory CreateLabelViewWithFont:_FONT(15) TextColor:_COLOR(0x21, 0x21, 0x21)];
        self.lbTask1.translatesAutoresizingMaskIntoConstraints = YES;
        self.lbTask1.numberOfLines = 0;
        self.lbTask1.frame = CGRectMake(20, 180, ScreenWidth - 100, size.height);
        self.lbTask1.text = taskname;
        [self.bgview addSubview:self.lbTask1];
    }
    
    return self;
}

@end
