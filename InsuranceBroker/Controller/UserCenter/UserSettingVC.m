//
//  UserSettingVC.m
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/29.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "UserSettingVC.h"
#import "define.h"
#import "RootViewController.h"
#import "ZWIntroductionViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import <AVOSCloudSNS/AVOSCloudSNS.h>
#import "EGOCache.h"
@interface UserSettingVC ()

@property (nonatomic, strong) ZWIntroductionViewController *introductionView;

@end

@implementation UserSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"设置";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) initSubViews
{
    self.tableview = [[UITableView alloc] initWithFrame:CGRectZero];
    UITableView *tableview = self.tableview;
    [self.view addSubview:tableview];
    tableview.delegate = self;
    tableview.dataSource = self;
    tableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    tableview.translatesAutoresizingMaskIntoConstraints = NO;
    tableview.backgroundColor = [UIColor clearColor];//_COLOR(242, 242, 242);//TableBackGroundColor;
    tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableview.separatorColor = _COLOR(0xe6, 0xe6, 0xe6);
    tableview.scrollEnabled = NO;
    
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.tableview.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableview setSeparatorInset:insets];
    }
    if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableview setLayoutMargins:insets];
    }
    
    UIButton *btnLogout = [[UIButton alloc] init];
    [self.view addSubview:btnLogout];
    btnLogout.translatesAutoresizingMaskIntoConstraints = NO;
    btnLogout.backgroundColor = _COLOR(0xf4, 0x43, 0x36);
    btnLogout.layer.cornerRadius = 5;
    [btnLogout setTitle:@"退出登录" forState:UIControlStateNormal];
    btnLogout.titleLabel.font = _FONT(18);
    btnLogout.titleLabel.textColor = [UIColor whiteColor];
    [btnLogout addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
    
    UILabel *lbVersion = [ViewFactory CreateLabelViewWithFont:_FONT(12) TextColor:_COLOR(0xcc, 0xcc, 0xcc)];
    [self.view addSubview:lbVersion];
    lbVersion.textAlignment = NSTextAlignmentCenter;
    lbVersion.text = [NSString stringWithFormat:@"当前版本：%@", [Util getCurrentVersion]];
    
    NSDictionary *views = NSDictionaryOfVariableBindings(tableview, btnLogout, lbVersion);
    
    self.hConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[tableview]-0-|" options:0 metrics:nil views:views];
    [self.view addConstraints:self.hConstraints];
    self.vConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[tableview(330)]->=0-[btnLogout(45)]-6-[lbVersion]-10-|" options:0 metrics:nil views:views];
    [self.view addConstraints:self.vConstraints];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[lbVersion]-12-|" options:0 metrics:nil views:views]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-12-[btnLogout]-12-|" options:0 metrics:nil views:views]];
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

#pragma UITableViewDataSource UITableViewDelegate

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0)
        return 1;
    else
        return 5;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *deq = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:deq];
    if(!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:deq];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.font = _FONT(15);
        cell.textLabel.textColor = _COLOR(0x21, 0x21, 0x21);
    }
    
    if(indexPath.section == 0){
        cell.textLabel.text = @"个人资料";
    }else{
        switch (indexPath.row) {
            case 0:
            {
                cell.textLabel.text = @"功能介绍";
            }
                break;
            case 1:
            {
                cell.textLabel.text = @"用户协议";
            }
                break;
            case 2:
            {
                cell.textLabel.text = @"给我们评分";
            }
                break;
            case 3:
            {
                cell.textLabel.text = @"清空缓存";
            }
                break;
            case 4:
            {
                cell.textLabel.text = @"关于";
            }
                break;
            default:
                break;
        }
    }
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if(indexPath.section == 0){
        UserInfoEditVC *vc = [IBUIFactory CreateUserInfoEditViewController];
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        switch (indexPath.row) {
            case 0:
            {
//                cell.textLabel.text = @"功能介绍";
                NSArray *coverImageNames = @[@"guide1",@"guide2",@"guide3",@"guide4"];
                // Example 2 自定义登陆按钮
                self.introductionView = [[ZWIntroductionViewController alloc] initWithCoverImageNames:coverImageNames backgroundImageNames:coverImageNames button:nil];
                
                [((AppDelegate*)([UIApplication sharedApplication].delegate)).window addSubview:self.introductionView.view];
                __weak UserSettingVC *weakself = self;
                self.introductionView.didSelectedEnter = ^() {
                    [weakself.introductionView.view removeFromSuperview];
                    weakself.introductionView = nil;
                };
            }
                break;
            case 1:
            {
//                cell.textLabel.text = @"用户协议";
                WebViewController *web = [IBUIFactory CreateWebViewController];
                [self.navigationController pushViewController:web animated:YES];
                web.title = @"用户协议";
                NSString *url = [NSString stringWithFormat:@"%@%@%@", SERVER_ADDRESS, @"/news/view/", User_Agreement];
                [web loadHtmlFromUrl:url];
            }
                break;
            case 2:
            {
                NSString *str = [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=xxxxxx" ];
                if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)){
                    str = [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/idxxxxxxx"];
                }
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }
                break;
            case 3:{
                [[EGOCache globalCache] clearCache];
                UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"缓存清除成功！"
                                                                    message:nil
                                                                   delegate:nil
                                                          cancelButtonTitle:@"确定"
                                                          otherButtonTitles:nil];
                [alertView show];

            }
                break;
            case 4:
            {
//                cell.textLabel.text = @"关于";
                WebViewController *web = [IBUIFactory CreateWebViewController];
                [self.navigationController pushViewController:web animated:YES];
                web.title = @"关于我们";
                NSString *url = [NSString stringWithFormat:@"%@%@%@", SERVER_ADDRESS, @"/news/view/", ABOUT_US];
                [web loadHtmlFromUrl:url];
            }
                break;
            default:
                break;
        }
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 0, 0);
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:insets];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:insets];
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 15;
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 15)];
    [view addSubview:imgv];
    imgv.image = ThemeImage(@"shadow");
    
    return view;
}

- (void) logout:(UIButton *) sender
{
    UserInfoModel *model = [UserInfoModel shareUserInfoModel];
    model.isLogin = NO;
    [[AppContext sharedAppContext] removeData];
    [[NSNotificationCenter defaultCenter] postNotificationName:Notify_Logout object:nil];
//    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
//    RootViewController *root = delegate.root;
//    root.selectedIndex = 0;
//    root.selectVC = root.homevc;
//    [self.navigationController popViewControllerAnimated:NO];
    [self login];
    
    AVInstallation *currentInstallation = [AVInstallation currentInstallation];
    [currentInstallation removeObject:@"ykbbrokerLoginUser4" forKey:@"channels"];
    [currentInstallation removeObject:[UserInfoModel shareUserInfoModel].userId forKey:@"channels"];
    [currentInstallation saveInBackground];
    [AVUser logOut];  //清除缓存用户对象
}

@end
