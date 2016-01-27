//
//  AnnouncementModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/12.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"

@interface AnnouncementModel : BaseModel

@property (nonatomic, strong) NSString *category;//": 10,
@property (nonatomic, strong) NSString *title;//": "通知消息",
@property (nonatomic, strong) NSDate *lastNewsDt;//": 1452581897403,
@property (nonatomic, strong) NSString *lastNewsContent;//": "原标题：广西一贪官详述潜逃路线体重大半年消瘦50多斤●忏悔人：马宏●原任职务：广西壮族自治区全州县财",
@property (nonatomic, strong) NSString *lastNewsTitle;//": "通知消息公共"
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) BOOL isRedirect;

@end
