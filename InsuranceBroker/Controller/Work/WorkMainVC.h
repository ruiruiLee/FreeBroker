//
//  WorkMainVC.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/18.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "BaseViewController.h"

@interface WorkMainVC : BaseViewController<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)IBOutlet UITableView *tableview;

@end
