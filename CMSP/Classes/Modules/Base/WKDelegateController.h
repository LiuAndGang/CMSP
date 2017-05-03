//
//  WKDelegateController.h
//  CMSP
//
//  Created by 李棠松 on 2016/12/7.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#import "LTSBaseViewController.h"
#import <WebKit/WebKit.h>

@protocol WKDelegate
- (void)userContentController:(WKUserContentController *)userContentController didReceiveMessage:(WKScriptMessage *)message;
@end
@interface WKDelegateController : LTSBaseViewController
@property(weak,nonatomic)id delegate;
@end
