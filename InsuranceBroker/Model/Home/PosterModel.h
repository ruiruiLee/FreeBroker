//
//  PosterModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/12.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"

@interface PosterModel : BaseModel

@property (nonatomic, strong) NSString *pid;//": "5690acac00b009a3348e5b1d",  //新闻id
@property (nonatomic, strong) NSString *title;//": "jQuery怎么简单去获取一个div的高度啊",
@property (nonatomic, strong) NSString *url;//": "xxxx_",  //点击海报重定向
@property (nonatomic, strong) NSString *imgUrl;//": "http://ac-0PyuKjNl.clouddn.com/9c218bc5c42df7053297.jpg",   //海报图片
@property (nonatomic, assign) BOOL isRedirect;//": 1   //是否可转入到新闻详细页面

@end
