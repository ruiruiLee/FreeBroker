//
//  NewsModel.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/12.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseModel.h"

@interface NewsModel : BaseModel

@property (nonatomic, strong) NSString *nid;//": "5694a41a60b28583926eff24",
@property (nonatomic, strong) NSString *title;//": "通知消息个人",
@property (nonatomic, strong) NSString *content;//": "原标题：广西一贪官详述潜逃路线体重大半年消瘦50多斤●忏悔人：马宏●原任职务：广西壮族自治区全州县财...",
@property (nonatomic, strong) NSString *url;//": "http://localhost:3000/news/edit?objectId=5694a41a60b28583926eff24",
@property (nonatomic, strong) NSString *imgUrl;//": "http://ac-0PyuKjNl.clouddn.com/7c7a383bce1093bd9f11.jpg",
@property (nonatomic, assign) BOOL isRedirect;//": 1,
@property (nonatomic, strong) NSDate *createdAt;//": 1452581914804

@property (nonatomic, assign) NSInteger keyType;
@property (nonatomic, strong) NSString *keyId;

@end
