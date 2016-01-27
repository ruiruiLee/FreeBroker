//
//  EditButton.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/8.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopImageButton.h"
#import "enumFile.h"
#import "CustomerInfoModel.h"

@interface EditButton : TopImageButton

@property (nonatomic, strong) UIImageView *delFlag;
@property (nonatomic, assign) enumEditType editType;
@property (nonatomic, strong) CustomerInfoModel *model;

@end
