//
//  OrderWebVC.h
//  InsuranceBroker
//
//  Created by LiuZach on 16/1/22.
//  Copyright © 2016年 LiuZach. All rights reserved.
//

#import "BaseViewController.h"
#import "EasyJSWebView.h"
#import "EasyJSWebView+JavaScriptAlert.h"
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"

@interface OrderWebVC : BaseViewController<NJKWebViewProgressDelegate, UIWebViewDelegate>
{
    NJKWebViewProgressView *_progressView;
    NJKWebViewProgress *_progressProxy;
}

@property (nonatomic, strong) IBOutlet EasyJSWebView *webview;
@property (nonatomic, strong) NSString *urlpath;

- (void) loadHtmlFromUrl:(NSString *) url;

@end
