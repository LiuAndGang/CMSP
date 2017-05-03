//
//  LTSBaseWebViewControlle.h
//  SAIFAMC
//
//  Created by 李棠松 on 16/8/17.
//  Copyright © 2016年 leetangsong. All rights reserved.
//

#import "LTSBaseViewController.h"
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
@interface LTSBaseWebViewControlle : LTSBaseViewController
@property (nonatomic,strong)WKWebView *webView;
@property (nonatomic,strong)NSURL *url;

@property (nonatomic,strong)NSString *htmlString;

- (void)addHandler;
@end
