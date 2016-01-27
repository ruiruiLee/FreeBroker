//
//  OrderDetailWebVC.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "WebViewController.h"

@interface OrderDetailWebVC : WebViewController
{
    NSString *_urlPath;
    NSString *_orderId;
    NSString *_insuranceType;
    NSString *_planOfferId;
    NSInteger tagNum;
}

- (void) initShareUrl:(NSString *) orderId insuranceType:(NSString *) insuranceType planOfferId:(NSString *) planOfferId;

@end
