//
//  EasyJSWebView+JavaScriptAlert.m
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "EasyJSWebView+JavaScriptAlert.h"

@implementation EasyJSWebView (JavaScriptAlert)

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(CGRect)frame {
    
    UIAlertView* customAlert = [[UIAlertView alloc] initWithTitle:@"提示信息" message:message delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [customAlert show];
    
}

@end
