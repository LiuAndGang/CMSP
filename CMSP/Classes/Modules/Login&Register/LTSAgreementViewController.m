//
//  LTSAgreementViewController.m
//  CMSP
//
//  Created by 刘刚 on 2017/5/18.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import "LTSAgreementViewController.h"

@interface LTSAgreementViewController ()<UIWebViewDelegate>
@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong) UIWebView *webView;

@end

@implementation LTSAgreementViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-64)];
    [self.view addSubview:_webView];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_stringHtml]]];
    _webView.delegate = self;
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
    //        [self.view resignFirstResponder];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // starting the load, show the activity indicator in the status bar
    //    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    [webView.scrollView beginActLoading];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    // finished loading, hide the activity indicator in the status bar
    //    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [webView.scrollView endActLoading];
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
