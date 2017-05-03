//
//  LTSProjectDetailViewController.h
//  CMSP
//
//  Created by 刘刚 on 17/4/17.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import "LTSBaseViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@interface LTSProjectDetailViewController : LTSBaseViewController
@property (nonatomic,strong)WKWebView *webView;
@property (nonatomic,strong)NSURL *url;

@end
