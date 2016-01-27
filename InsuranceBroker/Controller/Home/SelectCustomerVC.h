//
//  SelectCustomerVC.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/18.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BasePullTableVC.h"

@interface SelectCustomerVC : BasePullTableVC<UISearchBarDelegate, UISearchDisplayDelegate>

@property (nonatomic, strong) UISearchBar *searchbar;

@end
