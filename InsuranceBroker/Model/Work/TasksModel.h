//
//  TasksModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/21.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"

@interface TasksModel : BaseModel

@property (nonatomic, strong) NSString *taskId;//:1//任务ID
@property (nonatomic, strong) NSString *taskName;//:招募长的帅团员//任务名称
@property (nonatomic, assign) NSInteger taskLimit;//:1//限制数量
@property (nonatomic, assign) NSInteger taskFinish;//://完成数量

@end
