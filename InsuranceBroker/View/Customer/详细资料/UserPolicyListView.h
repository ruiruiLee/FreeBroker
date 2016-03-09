//
//  UserPolicyListView.h
//  InsuranceBroker
//
//  Created by LiuZach on 15/12/25.
//  Copyright © 2015年 LiuZach. All rights reserved.
//

#import "BaseInsuranceInfo.h"
#import "FooterView.h"
#import "NetWorkHandler.h"

@interface UserPolicyListView : BaseInsuranceInfo<FooterViewDelegate>

@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) FooterView *footer;

- (void) endLoadMore;
- (void) deleteItemWithOrderId:(NSString *) orderId Completion:(Completion)completion;

@end
