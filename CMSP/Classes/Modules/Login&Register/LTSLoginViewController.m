//
//  LTSLoginViewController.m
//  CMSP
//
//  Created by 李棠松 on 2016/12/1.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#import "LTSLoginViewController.h"
#import "LTSCustomTextField.h"
#import "LTSTabBarController.h"
#import "LTSRegisterViewController.h"
#import "LTSAlertSheetView.h"
#import "UIColor+Common.h"
#import "LTSChangePassWordViewController.h"
#import "UIViewController+HUD.h"
#import "LTSLogTypeTransition.h"
@interface LTSLoginViewController ()

@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)UIView *topView;

@property (nonatomic,strong)UIButton *closeButton;

/**底部大view*/
@property (nonatomic,strong) UIView *bigView;

@property (nonatomic,strong)LTSCustomTextField *user_tf;
@property (nonatomic,strong)LTSCustomTextField *password_tf;

/**自动登录按钮*/
@property (nonatomic,strong)UIButton *autoLoginBtn;

/**注册按钮*/
@property (nonatomic,strong)UIButton *registerBtn;
/**登录按钮*/
@property (nonatomic,strong)UIButton *loginBtn;
/**随便看看按钮*/
@property (nonatomic,strong)UIButton *seeBtn;
/**个人类型*/
@property (nonatomic,strong)UIButton *personalBtn;
/**合作用户*/
@property (nonatomic,strong)UIButton *PartnersBtn;
/**企业类型*/
@property (nonatomic,strong)UIButton *enterpriseBtn;
/**箭头图片*/
@property (nonatomic,strong)UIImageView *statusImageView;
/**选择用户类型按钮*/
@property (nonatomic,strong)UIButton *accountTypeBtn;
/**忘记密码按钮*/
@property (nonatomic,strong) UIButton *forgetbButton;
/**用户账号类型AlertController*/
@property (nonatomic,strong) UIAlertController *alertController;
/**0 个人     1企业      2合作机构*/
@property (nonatomic,assign)NSInteger userType;
/**用户账号类型----个人手机:1 , 个人用户名:3 , 企业用户名:7 ,个人邮箱:2 ，企业邮箱:6 ,合作机构:-7  */
@property(nonatomic,copy) NSString * userLoginType;

@property (nonatomic,strong) UIAlertAction *userNameAction;
@property (nonatomic,strong) UIAlertAction *emailAction;
@end

@implementation LTSLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = OrangeColor;
    self.userType = 0;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [LTSUserDefault setBool:0 forKey:KPath_AutoLogin];
    [LTSUserDefault setBool:0 forKey:KPath_UserLoginState];
    
    [self addTouchClick];
    
}

- (void)initUI{
    
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.scrollView];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = CGSizeMake(Screen_Width, Screen_Height);
    self.scrollView.bounces = NO;
    self.scrollView.showsVerticalScrollIndicator = NO;
    
    UIView *topView = [UIView new];
    [self.scrollView addSubview:topView];
    topView.backgroundColor = OrangeColor;
    if (Screen_Height == 480 ||Screen_Height == 568) {
        topView.frame = CGRectMake(0, 0, Screen_Width, 275*Screen_Height/667);
    }else{
        topView.frame = CGRectMake(0, 0, Screen_Width, 275);
    }

    self.topView = topView;
    
    UIImageView *topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"longin.jpg"]];
    [topView addSubview:topImageView];
    if (Screen_Height == 480 ||Screen_Height == 568) {
        topImageView.frame = CGRectMake(0, 0, Screen_Width, 275*Screen_Height/667);
    }else{
        topImageView.frame = CGRectMake(0, 0, Screen_Width, 275);
    }
    
    //覆盖的透明view
    UIView *coverView = [UIView new];
    coverView.backgroundColor = [UIColor whiteColor];
    coverView.alpha = 0.5;
    [topView addSubview:coverView];
    coverView.userInteractionEnabled = YES;
    [coverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(topView);
        make.height.mas_equalTo(44);
    }];

    
    //关闭登录页面
    UIButton *closeButton = [UIButton new];
    self.closeButton = closeButton;
    [closeButton setImage:[UIImage imageNamed:@"icon_close"] forState:UIControlStateNormal];
    [topView addSubview:closeButton];
    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(30);
        make.left.mas_equalTo(25);
    }];
    
    
    

//    [topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(85);
//        make.centerX.mas_equalTo(self.scrollView.mas_centerX).with.offset(20);
//        make.size.mas_equalTo(CGSizeMake(215, 70));
//    }];
    
    //个人按钮
    self.personalBtn = ({UIButton  *button = [UIButton new];
        
        [button setTitle:@"个人" forState:UIControlStateNormal];
        [button setTitleColor:OrangeColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [coverView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.mas_equalTo(topView);
            make.size.mas_equalTo(CGSizeMake(Screen_Width/3, 44));
            
        }];
        
        
        button;});
    
    //合作机构按钮
    self.PartnersBtn = ({UIButton  *button = [UIButton new];

        [button setTitle:@"合作机构" forState:UIControlStateNormal];
        [button setTitleColor:OrangeColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [coverView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.personalBtn.mas_right);
            make.bottom.mas_equalTo(topView);
            make.size.mas_equalTo(CGSizeMake(Screen_Width/3, 44));
        }];
        
        
        button;});
    
    //企业按钮
    self.enterpriseBtn = ({UIButton  *button = [UIButton new];
        
        [button setTitle:@"企业" forState:UIControlStateNormal];
        [button setTitleColor:OrangeColor forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [coverView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.mas_equalTo(topView);
            make.size.mas_equalTo(CGSizeMake(Screen_Width/3, 44));
        }];
        
        
        button;});
   
    
    
    //登录类型的选择箭头图片
    self.statusImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_loginjiantou"]];
    [topView addSubview:self.statusImageView];
    [self.statusImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0.5);
        make.centerX.mas_equalTo(topView.mas_left).with.offset(Screen_Width/6);
    }];

    
    //下边白色部分底图
    _bigView = [UIView new];
    _bigView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:_bigView];
    
    [_bigView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topView.mas_bottom).with.offset(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(Screen_Width);
        make.bottom.mas_equalTo(self.view);
        
    }];
    
    
    //选择输入的帐号的类型
    _accountTypeBtn = [UIButton new];
    _accountTypeBtn.backgroundColor = [UIColor whiteColor];
    [_accountTypeBtn GrayRoundButtonStyle];
    [_bigView addSubview:_accountTypeBtn];
    [_accountTypeBtn setTitle:@"请选择账号类型" forState:UIControlStateNormal];
    _accountTypeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_accountTypeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(35);
        make.right.mas_equalTo(-35);
        make.height.mas_equalTo(25);
    }];
    
    
    

    //账号输入框
    self.user_tf = ({LTSCustomTextField *textField = [LTSCustomTextField textFieldWithleftImageIcon:@"icon_userLogin"];
        textField.borderType = LTSCustomTextFieldBorderTypeBottom;
        [textField setCustomPlaceholder:@"手机号/邮箱"];
        [_bigView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.accountTypeBtn.mas_bottom).with.offset(10);
            make.left.mas_equalTo(25);
            make.right.mas_equalTo(-25);
            make.height.mas_equalTo(44);
        }];
        textField;
    });
    
    //密码输入框
    self.password_tf= ({LTSCustomTextField *textField = [LTSCustomTextField textFieldWithleftImageIcon:@"icon_userPassword"];
        [textField setCustomPlaceholder:@"输入密码"];
        textField.borderType = LTSCustomTextFieldBorderTypeBottom;
        textField.secureTextEntry = YES;
        [_bigView addSubview:textField];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.user_tf.mas_bottom).with.offset(10);
            make.left.mas_equalTo(25);
            make.right.mas_equalTo(-25);
            make.height.mas_equalTo(44);
        }];
        
//        //忘记密码按钮
//        _forgetbButton = [UIButton new];
//        _forgetbButton.frame = CGRectMake(0, 0, 50, 20);
//        [_forgetbButton setTitle:@"忘记密码" forState:UIControlStateNormal];
//        _forgetbButton.titleLabel.font = [UIFont systemFontOfSize:12];
//        [_forgetbButton setTitleColor:HexColor(@"#00b0ec") forState:UIControlStateNormal];
//        textField.rightViewMode = UITextFieldViewModeAlways;
//        textField.rightView = _forgetbButton;
        
        
        textField;
    });
    
    //自动登录按钮
    self.autoLoginBtn = ({UIButton  *button = [UIButton new];
        [button setImage:[UIImage imageNamed:@"icon_memberPwd_unselected"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"icon_memberPwd_selected"] forState:UIControlStateSelected];
        [_bigView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.password_tf.mas_left);
            make.top.mas_equalTo(self.password_tf.mas_bottom).with.offset(30);
        }];
        
        UILabel *label = [UILabel new];
        label.text = @"自动登录";
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = LightDarkText;
        [_bigView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(button.mas_right).with.offset(5);
            make.centerY.mas_equalTo(button.mas_centerY);
        }];
        
        
        button;});
    
    
    //注册按钮
    self.registerBtn = ({UIButton  *button = [UIButton new];
        [button setTitleColor:LightDarkText forState:UIControlStateNormal];
        [button setTitle:@"注册" forState:UIControlStateNormal];
         button.titleLabel.font = [UIFont systemFontOfSize:12];
        [_bigView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(-30);
            make.centerY.mas_equalTo(self.autoLoginBtn.mas_centerY);
        }];
        
        
        button;});
    
    //登录按钮
    self.loginBtn = ({ UIButton *button = [[UIButton alloc] init];
        
        [button GrayRoundButtonStyle];
        [button setTitle:@"登录" forState:UIControlStateNormal];
        
        [_bigView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_bigView).with.offset(30);
            make.right.equalTo(_bigView.mas_right).with.offset(-30);
            make.top.equalTo(self.autoLoginBtn.mas_bottom).with.offset(15);
            make.height.mas_equalTo(44);
        }];
        
        button;
    });
    
    //随便看看
    self.seeBtn = ({UIButton  *button = [UIButton new];
        [button setTitleColor:HexColor(@"#00b0ec") forState:UIControlStateNormal];
        [button setTitle:@"随便看看" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        [_bigView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_equalTo(self.view.mas_bottom).with.offset(-20);
            make.size.mas_equalTo(CGSizeMake(70, 27));
            make.centerX.mas_equalTo(_bigView.mas_centerX);
        }];
        ViewRadius(button, 27/2.0);
        button.layer.borderColor = HexColor(@"#00b0ec").CGColor;
        button.layer.borderWidth = 0.5;
        
        button;});
    
}


- (void)addEvents{
    @weakify(self)
    
    RAC(self.loginBtn,enabled) = [RACSignal combineLatest:@[self.user_tf.rac_textSignal,self.password_tf.rac_textSignal] reduce:^id(NSString *userNameText,NSString *pwdText){
        return @(userNameText.length > 0 && pwdText.length > 0);
    }];
    
    [RACObserve(self.loginBtn, enabled) subscribeNext:^(NSNumber *x) {
        @strongify(self)
        [UIView animateWithDuration:0.3 animations:^{
            x.boolValue ? [self.loginBtn OrangeRoundButtonStyle] : [self.loginBtn GrayRoundButtonStyle];
        }];
    }];
    
    
    //请选择账号类型
    [[self.accountTypeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        if (self.userType == 0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择账户类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [_accountTypeBtn setTitle:@"请选择账号类型" forState:UIControlStateNormal];
            }];
            //        _userNameAction = [UIAlertAction actionWithTitle:@"用户名" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            //            [self.accountTypeBtn setTitle:@"用户名" forState:UIControlStateNormal];
            //        }];
            UIAlertAction *phoneAction = [UIAlertAction actionWithTitle:@"个人手机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [self.accountTypeBtn setTitle:@"个人手机" forState:UIControlStateNormal];
            }];
            _emailAction = [UIAlertAction actionWithTitle:@"个人邮箱" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.accountTypeBtn setTitle:@"个人邮箱" forState:UIControlStateNormal];
            }];
            [alertController addAction:cancelAction];
//            [alertController addAction:_userNameAction];
            [alertController addAction:_emailAction];
            [alertController addAction:phoneAction];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
        //区分企业和用户的alertView
        if (self.userType == 1) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择账户类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                [_accountTypeBtn setTitle:@"请选择账号类型" forState:UIControlStateNormal];
            }];

            _userNameAction = [UIAlertAction actionWithTitle:@"企业用户名" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.accountTypeBtn setTitle:@"企业用户名" forState:UIControlStateNormal];
            }];
            _emailAction = [UIAlertAction actionWithTitle:@"企业邮箱" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                [self.accountTypeBtn setTitle:@"企业邮箱" forState:UIControlStateNormal];
            }];
            [alertController addAction:cancelAction];
            [alertController addAction:_userNameAction];
            [alertController addAction:_emailAction];
            [self presentViewController:alertController animated:YES completion:nil];

  
        }
        
        
        
    }];
    
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       @strongify(self)

        
//        if (![TextChecker isValidateUserName:self.user_tf.text]) {
//            [ActivityHub ShowHub:KWork_UserNameIllegal];
//            return;
//        }
//        if (![TextChecker isValidatePassword:self.password_tf.text]) {
//            [ActivityHub ShowHub:KWork_UserNameIllegal];
//            return;
//        }
        
        //判断auth_login_acct的类型
        if (self.userType == 0) {//个人
            if ([_accountTypeBtn.titleLabel.text isEqualToString:@"用户名"]) {
                self.userLoginType = @"3";//个人用户名
            }else if ([_accountTypeBtn.titleLabel.text isEqualToString:@"个人邮箱"]){
                self.userLoginType = @"2";//个人邮箱
            }else if ([_accountTypeBtn.titleLabel.text isEqualToString:@"个人手机"]){
                self.userLoginType = @"1";//个人手机
            }else{
                [ActivityHub ShowHub:@"请选择账号类型"];
                return;
            }
        }else if (self.userType == 1){//企业
            if ([_accountTypeBtn.titleLabel.text isEqualToString:@"企业用户名"]) {
                self.userLoginType = @"7";//企业用户名
            }else if ([_accountTypeBtn.titleLabel.text isEqualToString:@"企业邮箱"]){
                self.userLoginType = @"6";//企业邮箱
            }else{
                [ActivityHub ShowHub:@"请选择账号类型"];
                return;
            }
        }else{
            self.userLoginType = @"-7";//合作机构
        }
        [self showHudInView:self.view hint:@"正在登录"];

        [LTSDBManager POST:[kLTSDBBaseUrl stringByAppendingString:kLTSDBLogin] params:@{@"auth_login_acct":self.userLoginType,@"logName":self.user_tf.text,@"password":self.password_tf.text} block:^(id responseObject, NSError *error) {
            if ([responseObject[@"result"] isEqual:@1]) {
                NSLog(@"responseObject:%@",responseObject[@"result"]);
                [self showSuccessInView:self.view hint:@"登录成功"];
                NSLog(@"responseObject:%@",responseObject);
                //页面一直持有这个票据
                NSLog(@"账户类型:%@",self.userLoginType);
                NSLog(@"票据:%@", responseObject[@"data"]);
                [LTSUserDefault setObject:responseObject[@"data"] forKey:Login_Token];
                [LTSUserDefault setObject:self.user_tf.text forKey:@"logName"];
                //保存用户类型
                [LTSUserDefault setObject:self.userLoginType forKey:KPath_UserLoginType];
                [LTSUserDefault setObject:self.password_tf.text forKey:@"password"];
                
                //判断自动登录
                if ([_autoLoginBtn isSelected]) {
                    [LTSUserDefault setBool:1 forKey:KPath_AutoLogin];
                }else{
                    [LTSUserDefault setBool:0 forKey:KPath_AutoLogin];
                }
                
                //表示登录状态
                [LTSUserDefault setBool:1 forKey:KPath_UserLoginState];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    LTSTabBarController *tabbar = [LTSTabBarController new];
                    LTSAppDelegated.window.rootViewController = tabbar;
                });

                
                
                //转换登录用户类型
                NSString *login_user_type = [LTSLogTypeTransition logTypeTransition];
                
                //获取用户详情
                //    [LTSDBManager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
                if ([LTSUserDefault objectForKey:Login_Token]) {
                    [LTSDBManager POST:[kLTSDBBaseUrl stringByAppendingString:KLTSDBGainUserInfo] params:@{@"login_user_type":login_user_type,@"logName":[LTSUserDefault objectForKey:@"logName"]} block:^(id responseObject, NSError *error) {
                        if ([responseObject[@"result"] isEqual:@1]) {
                            NSLog(@"获取用户详情成功");
                            
                            NSLog(@"responseObject：%@",responseObject);
                            
                            [LTSUserDefault setObject:responseObject[@"data"][@"cif_account"] forKey:@"cif_account"];
                            
                            NSLog(@"cif_account:%@",[LTSUserDefault objectForKey:@"cif_account"]);
                            [LTSUserDefault setObject:responseObject[@"data"][@"real_name"] forKey:@"real_name"];
                            [LTSUserDefault setObject:responseObject[@"data"][@"organ_flag"] forKey:@"organ_flag"];
                            
                        }else{
                            
                            NSLog(@"获取详情失败");
                        }
                    }];
                    
                }


            }else{
                [self showErrorInView:self.view hint:responseObject[@"msg"]];
                [self hideHud];
            }

        }];
        
    }];
    
    //忘记密码
    [[self.forgetbButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        LTSChangePassWordViewController *changePasVc = [LTSChangePassWordViewController new];
        [self.navigationController pushViewController:changePasVc animated:YES];
    }];
    
    
    //注册
    [[self.registerBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        
        [self.navigationController pushViewController:[LTSRegisterViewController new] animated:YES];
    }];
    
    
    
    //自动登录
    [[self.autoLoginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       @strongify(self)
        self.autoLoginBtn.selected = !self.autoLoginBtn.selected;
        NSLog(@"点击自动登录的按钮之后：%d",[_autoLoginBtn isSelected]);
        
    }];
    
    //左上角关闭
    [[self.closeButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        LTSTabBarController *tabbar = [LTSTabBarController new];
        LTSAppDelegated.window.rootViewController = tabbar;
    }];
    
    //随便看看
    [[self.seeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        LTSTabBarController *tabbar = [LTSTabBarController new];
        LTSAppDelegated.window.rootViewController = tabbar;
    }];
    
    //个人
    [[self.personalBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        self.userType = 0;
        [self.statusImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.topView.mas_left).with.offset(Screen_Width/6);
        }];
        //显示选择账号类型按钮
        _accountTypeBtn.hidden = NO;

    }];
    
    //合作机构
    [[self.PartnersBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        self.userType = 2;
        [self.statusImageView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.centerX.mas_equalTo(self.topView);
            make.centerX.mas_equalTo(self.topView.mas_left).with.offset(Screen_Width/2);

        }];
        //隐藏选择账号类型按钮
        _accountTypeBtn.hidden = YES;
    }];

    //企业
    [[self.enterpriseBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        self.userType = 1;
        
        [self.statusImageView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.topView.mas_left).with.offset(Screen_Width/6*5);
        }];
        //显示选择账号类型按钮
        _accountTypeBtn.hidden = NO;
        
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
    [self.user_tf resignFirstResponder];
    [self.password_tf resignFirstResponder];
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
