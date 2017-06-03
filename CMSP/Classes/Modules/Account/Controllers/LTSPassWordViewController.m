//
//  LTSPassWordViewController.m
//  CMSP
//
//  Created by 刘刚 on 2017/5/24.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import "LTSPassWordViewController.h"
#import "LeftLabelTextField.h"
#import "UIButton+Style.h"
#import "LTSAppDelegate.h"
//#import "JSLoginViewController.h"
#import "LTSBaseNavigationController.h"
#import "LTSLoginViewController.h"

@interface LTSPassWordViewController ()
@property (strong, nonatomic)  LeftLabelTextField *tf_originalPwd;
@property (strong, nonatomic)  LeftLabelTextField *tf_newPwd;
@property (strong, nonatomic)  LeftLabelTextField *tf_reNewPwd;
@property (strong, nonatomic)  UIButton *btn_submit;
@property (nonatomic,strong) UIButton *backBtn;
@end

@implementation LTSPassWordViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.navigationController.navigationBar.hidden = NO;
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    
    [self initNavBar];
    
    [self addTouchClick];
    
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


- (void)initUI
{
    CGFloat padding = 20;
    CGFloat textFieldH = 40;
    CGFloat textFieldPadding = 10;
    
    self.tf_originalPwd = [[LeftLabelTextField alloc] initWithTitle:@"旧密码" placeHolder:@"请输入您的旧密码"];
    self.tf_originalPwd.secureTextEntry = YES;
    [self.view addSubview:self.tf_originalPwd];
    [self.tf_originalPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(20);
        make.left.equalTo(self.view).with.offset(padding);
        make.right.equalTo(self.view.mas_right).with.offset(-padding);
        make.height.mas_equalTo(textFieldH);
    }];
    
    self.tf_newPwd = [[LeftLabelTextField alloc] initWithTitle:@"新密码" placeHolder:@"请输入您的新密码"];
    self.tf_newPwd.secureTextEntry = YES;
    [self.view addSubview:self.tf_newPwd];
    [self.tf_newPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tf_originalPwd.mas_bottom).with.offset(textFieldPadding);
        make.left.equalTo(self.view).with.offset(padding);
        make.right.equalTo(self.view.mas_right).with.offset(-padding);
        make.height.mas_equalTo(textFieldH);
    }];
    
    self.tf_reNewPwd = [[LeftLabelTextField alloc] initWithTitle:@"确认密码" placeHolder:@"请确认您的新密码"];
    self.tf_reNewPwd.secureTextEntry = YES;
    [self.view addSubview:self.tf_reNewPwd];
    [self.tf_reNewPwd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tf_newPwd.mas_bottom).with.offset(textFieldPadding);
        make.left.equalTo(self.view).with.offset(padding);
        make.right.equalTo(self.view.mas_right).with.offset(-padding);
        make.height.mas_equalTo(textFieldH);
    }];
    
    self.btn_submit = ({ UIButton *button = [UIButton new];
        [button setTitle:@"确认修改" forState:UIControlStateNormal];
        ViewRadius(button, 5);
        button.backgroundColor = OrangeColor;
        [self.view addSubview:button];
        button.alpha = 0.5;
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.tf_reNewPwd.mas_bottom).with.offset(textFieldPadding + 10);
            make.left.equalTo(self.view).with.offset(padding);
            make.right.equalTo(self.view.mas_right).with.offset(-padding);
            make.height.mas_equalTo(textFieldH);
        }];
        button;
    });
    
}
//
- (void)addEvents
{
    //确认修改按钮触发事件
    
    @weakify(self)
    [[self.btn_submit rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        @strongify(self)
        
        
        [self.view endEditing:YES];
        if (![self.tf_reNewPwd.text isEqualToString:self.tf_newPwd.text]) {
            [self showErrorInView:self.view hint:@"两次新密码输入不一致"];
            [self hideHud];
            return;
        }
        
        [self showHudInView:self.view hint:@"正在修改..."];
//        LTSUser *user = LTSUserDes;
        [LTSDBManager POST:[kLTSDBBaseUrl stringByAppendingString:kLTSDBChangePassword] params:@{@"logName":[LTSUserDefault objectForKey:@"logName"],@"oldpassword":self.tf_originalPwd.text,@"newpassword":self.tf_newPwd.text,@"grantticket_id":[LTSUserDefault objectForKey:Login_Token]} block:^(id responseObject, NSError *error) {
            [self hideHud];
            if ([responseObject[@"result"] isEqual:@1]) {
                [self showSuccessInView:self.view hint:@"修改成功"];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    LTSLoginViewController *logVc = [LTSLoginViewController new];
                    [self presentViewController:logVc animated:YES completion:nil];

                });
                
            }
            else [self showHint:responseObject[@"msg"]];
        }];
        
        
        
        
    }];
    
    
    //确认修改按钮
    RAC(self.btn_submit, enabled) = [RACSignal combineLatest:@[self.tf_newPwd.rac_textSignal, self.tf_originalPwd.rac_textSignal, self.tf_reNewPwd.rac_textSignal] reduce:^id(NSString *newPwdText,NSString *originalPwdText, NSString *reNewText ){
        
        return @(newPwdText.length > 0 && originalPwdText.length > 0 && reNewText.length > 0);
    }];
    //
    [RACObserve(self.btn_submit, enabled) subscribeNext:^(NSNumber *x) {
        @strongify(self)
        [UIView animateWithDuration:0.3 animations:^{
            self.btn_submit.alpha = [x boolValue] ?  1 : 0.5;
        }];
    }];
    
    
    
}

//添加触摸收回键盘事件
-(void)addTouchClick {
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(keyboardHide:)];
    //设置成NO表示当前控件响应后会传播到其他控件上，默认为YES。
    tapGestureRecognizer.cancelsTouchesInView = NO;
    //将触摸事件添加到当前view
    [self.view addGestureRecognizer:tapGestureRecognizer];
}

-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [self.tf_newPwd resignFirstResponder];
    [self.tf_reNewPwd resignFirstResponder];
    [self.tf_originalPwd resignFirstResponder];

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
