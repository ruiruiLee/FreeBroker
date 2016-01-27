//
//  UserInfoEditVC.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/22.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "BaseViewController.h"

@interface UserInfoEditVC : BaseViewController<UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableview;

@end
