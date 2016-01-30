//
//  OrderManagerVC.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/28.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "BasePullTableVC.h"

@interface OrderManagerVC : BasePullTableVC

@property (nonatomic, strong) UISearchBar *searchbar;
@property (nonatomic, strong) NSString *filterString;

@end
