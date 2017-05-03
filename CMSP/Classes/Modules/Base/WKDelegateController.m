//
//  WKDelegateController.m
//  CMSP
//
//  Created by 李棠松 on 2016/12/7.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#import "WKDelegateController.h"

@interface WKDelegateController ()

@end

@implementation WKDelegateController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveMessage:(WKScriptMessage *)message{
    if([self.delegate respondsToSelector:@selector(userContentController:didReceiveMessage:)]){
        [self.delegate userContentController:userContentController didReceiveMessage:message];
        }
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
