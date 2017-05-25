//
//  LTSBaseWebViewControlle.m
//  SAIFAMC
//
//  Created by 李棠松 on 16/8/17.
//  Copyright © 2016年 leetangsong. All rights reserved.
//

#import "LTSBaseWebViewControlle.h"
#import "WKDelegateController.h"
#import "WKWebViewJavascriptBridge.h"
@interface LTSBaseWebViewControlle ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
{
    WKWebViewConfiguration * configuration;
    UIView *topView;
}

@property WKWebViewJavascriptBridge *webViewBridge;

/**左上角返回上一级按钮*/
@property (nonatomic,strong) UIButton *backBtn ;

@end

@implementation LTSBaseWebViewControlle

- (void)dealloc{
  [configuration.userContentController removeScriptMessageHandlerForName:@"iOSBack"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear: YES];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = OrangeColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //webView适配底部tabar和导航栏
//    self.edgesForExtendedLayout = UIRectEdgeNone;

}

- (void)initUI{
//    UIView *view = [UIView new];
//    view.frame = CGRectMake(0, 0, Screen_Width, 20);
//    [self.view addSubview:view];
//    view.backgroundColor = HexColor(@"#e94f25");
//    topView = view;
//    view.hidden = NO;
    [self webView];
    [self.webView.scrollView beginActLoading];
    
    //注册方法
    [self addHandler];
    
    [self initNavBar];
}

-(void)initNavBar
{
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(10, 20, 20, 20);
    [_backBtn setImage:[UIImage imageNamed:@"icon_nav_back"] forState:UIControlStateNormal];
    [_backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_backBtn];
}


-(void)back:(UIButton *)btn
{
    if (self.webView.canGoBack) {
        [self.webView goBack];
        
    }else{
        [self.view resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    }

}

- (void)initData
{
//    _url = [NSURL URLWithString:@"www.baidu.com"];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (self.url) {
            
            [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
        }
        
        if (self.htmlString) {
//            _htmlString = @"www.baidu.com";
            [self.webView loadHTMLString:self.htmlString baseURL:nil];
        }
    });
}

- (void)addHandler{
    
   [configuration.userContentController addScriptMessageHandler:self name:@"iOSBack"];
    
    
}

#pragma mark --  WKScriptMessageHandler -- 
// 从web界面中接收到一个脚本时调用
#pragma mark - WKScriptMessageHandler
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message
{
    //    message.body  --  Allowed types are NSNumber, NSString, NSDate, NSArray,NSDictionary, and NSNull.
    if ([message.name isEqualToString:@"iOSBack"]) {
        [self.navigationController popViewControllerAnimated: YES];
    }
    NSLog(@"%@",message.name);
}

#pragma mark -- WKNavigationDelegate --


#pragma mark -------------------- UIWebView Delegate ---------------------
//


//开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    [webView.scrollView beginActLoading];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    [webView.scrollView endActLoading];
//     topView.hidden = NO;
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    [_webView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
//    }];
    
//    [webView evaluateJavaScript:@"document.getElementsByClassName('topTitle')[0].style.webkitTextSizeAdjust= '100%'" completionHandler:nil];
    
    [webView evaluateJavaScript:@"document.documentElement.style.webkitUserSelect='none';" completionHandler:nil];
    
    
    [webView evaluateJavaScript:@"document.documentElement.style.webkitTouchCallout='none';" completionHandler:nil];
   
    
}


- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler
{    // js 里面的alert实现，如果不实现，网页的alert函数无效
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:message
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"知道了"
                                                        style:UIAlertActionStyleCancel
                                                      handler:^(UIAlertAction *action) {
                                                          completionHandler();
                                                      }]];
    
    [self presentViewController:alertController animated:YES completion:^{
        
    }];
    
}


-(WKWebView *)webView{
    if (!_webView) {
        configuration = [[WKWebViewConfiguration alloc]init];
        configuration.userContentController = [[WKUserContentController alloc]init];
        
        _webView = [[WKWebView alloc]initWithFrame:self.view.bounds configuration:configuration];
//        _webView.frame = CGRectMake(0, 64, WIDTH(self.view), HEIGHT(self.view)-64);
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.scrollView.bounces = NO;
        _webView.autoresizingMask =(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        [self.view addSubview:_webView];
        
        _webView.multipleTouchEnabled=YES;
        
        _webView.userInteractionEnabled=YES;
        
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(64, 0, 0, 0));
        }];
    }
    return _webView;
}

@end
