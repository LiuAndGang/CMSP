//
//  LTSProjectDetailViewController.m
//  CMSP
//
//  Created by 刘刚 on 17/4/17.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import "LTSProjectDetailViewController.h"

@interface LTSProjectDetailViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
{
    WKWebViewConfiguration * configuration;
    UIView *topView;
}

/**左上角返回上一级按钮*/
@property (nonatomic,strong) UIButton *backBtn ;

@end

@implementation LTSProjectDetailViewController

- (void)dealloc{
    [configuration.userContentController removeScriptMessageHandlerForName:@"iOSBack"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = OrangeColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //webView适配底部tabar和导航栏
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
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

//判断是h5页面的返回上一级按钮
-(void)back:(UIBarButtonItem *)btn{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        
    }else{
        [self.view resignFirstResponder];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)initData
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        if (self.url) {
            
            [self.webView loadRequest:[NSURLRequest requestWithURL:self.url]];
        }
        
        //        if (self.htmlString) {
        //            //            _htmlString = @"www.baidu.com";
        //            [self.webView loadHTMLString:self.htmlString baseURL:nil];
        //        }
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
//发送请求之前决定是否跳转
- (void)webView:(UIWebView *)webView decidePolicyForNavigationAction:(nonnull WKNavigationAction *)navigationAction decisionHandler:(nonnull void (^)(WKNavigationActionPolicy))decisionHandler {
    
    
    NSString * requestString = [[navigationAction.request URL] absoluteString];
    requestString = [requestString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"detail-----%@",requestString);
    NSLog(@"detail-----self:%@",self.url.absoluteString);
    
    if([requestString isEqualToString:self.url.absoluteString]) {//主页面加载内容
        decisionHandler(WKNavigationActionPolicyAllow);//允许跳转
    } else {//截获页面里面的链接点击
        decisionHandler(WKNavigationActionPolicyAllow);//不允许跳转
    }
    
    //获取H5页面里面按钮的操作方法,根据这个进行判断返回是内部的还是push的上一级页面
    //    if ([requestString hasPrefix:@"goback:"]) {
    //        [self.navigationController popViewControllerAnimated:YES];
    //    }else{
    //        [self.webView goBack];
    //    }
    //    return YES;
}

//开始加载时调用
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    [webView.scrollView endActLoading];
    //     topView.hidden = NO;
    //    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [_webView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
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
        
        _webView.UIDelegate = self;
        _webView.navigationDelegate = self;
        _webView.scrollView.bounces = NO;
        _webView.autoresizingMask =(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
        [self.view addSubview:_webView];
        
        _webView.multipleTouchEnabled=YES;
        
        _webView.userInteractionEnabled=YES;
        
        [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
    }
    return _webView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
