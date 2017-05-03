//
//  LTSChangePassWordViewController.m
//  CMSP
//
//  Created by 刘刚 on 17/4/13.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import "LTSChangePassWordViewController.h"
#import "LTSPersonalRegisterViewController.h"
#import "LTSCustomTextField.h"
#import "WPAttributedLabel.h"

@interface LTSChangePassWordViewController ()
@property (nonatomic,strong)UIScrollView *scrollView;
/**手机号*/
@property (nonatomic,strong)LTSCustomTextField *user_tf;
/**验证码*/
@property (nonatomic,strong)LTSCustomTextField *code_tf;

@property (nonatomic,strong)LTSCustomTextField *password_tf;

@property (nonatomic,strong)LTSCustomTextField *repassword_tf;

@property (nonatomic,strong)UIButton *save_btn;


/**获取验证码按钮*/
@property (nonatomic, strong) UIButton *getCodeBtn;


@property (nonatomic,strong)WPTappableLabel *tipLabel;

@property (nonatomic, assign) NSUInteger countDown;

@end

@implementation LTSChangePassWordViewController

- (void)viewDidLoad {
    self.title = @"找回密码";
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)initUI{
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    
    UIView *view = [UIView new];
    [self.scrollView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(Screen_Width);
        make.top.left.mas_equalTo(0);
        make.height.mas_equalTo(667);
    }];
    
    
    self.user_tf = ({LTSCustomTextField *textField = [LTSCustomTextField new];
        [textField setCustomPlaceholder:@"手机号/邮箱"];
        [view addSubview:textField];
        [textField setLeftOffset:15];
        textField.font = [UIFont systemFontOfSize:14];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_offset(0);
            make.width.mas_equalTo(Screen_Width);
            make.height.mas_equalTo(44);
        }];
        textField.backgroundColor = [UIColor whiteColor];
        textField;
    });
    [self addLineOffsetTop:43.5];
    
    self.code_tf = ({LTSCustomTextField *textField = [LTSCustomTextField new];
        [textField setCustomPlaceholder:@"输入验证码"];
        
        UIView *insideview = [UIView new];
        insideview.backgroundColor = [UIColor whiteColor];
        [view addSubview:insideview];
        [insideview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(44);
            make.left.right.mas_equalTo(0);
            make.height.mas_equalTo(44);
        }];
        [view addSubview:textField];
        [textField setLeftOffset:15];
        textField.font = [UIFont systemFontOfSize:14];
        
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(44);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(Screen_Width-100);
            make.height.mas_equalTo(44);
        }];
        textField.backgroundColor = [UIColor whiteColor];
        textField;
    });
    
    
    UIButton *button = [UIButton new];
    [view addSubview:button];
    [button setTitle:@"获取验证码" forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button setTitleColor:HexColor(@"#00b0ec") forState:UIControlStateNormal];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(44);
        make.height.mas_equalTo(44);
        
    }];
    self.getCodeBtn = button;
    
    
    self.password_tf = ({LTSCustomTextField *textField = [LTSCustomTextField new];
        [textField setCustomPlaceholder:@"设置密码"];
        [view addSubview:textField];
        [textField setLeftOffset:15];
        textField.font = [UIFont systemFontOfSize:14];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.top.mas_equalTo(44*2 +8);
            make.width.mas_equalTo(Screen_Width);
            make.height.mas_equalTo(44);
        }];
        textField.backgroundColor = [UIColor whiteColor];
        textField;
    });
    [self addLineOffsetTop:44*3 +8 -0.5];
    
    self.repassword_tf = ({LTSCustomTextField *textField = [LTSCustomTextField new];
        [textField setCustomPlaceholder:@"确认密码"];
        [view addSubview:textField];
        [textField setLeftOffset:15];
        textField.font = [UIFont systemFontOfSize:14];
        [textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(0);
            make.top.mas_equalTo(self.password_tf.mas_bottom).with.offset(0);
            make.width.mas_equalTo(Screen_Width);
            make.height.mas_equalTo(44);
        }];
        textField.backgroundColor = [UIColor whiteColor];
        textField;
    });
    
    
    self.save_btn = ({UIButton *button = [UIButton new];
        [view addSubview:button];
        [button setTitle:@"保存" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        [button setTitleColor:LightGrayColor forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(0);
            make.top.mas_equalTo(self.repassword_tf.mas_bottom).with.offset(30);
            make.height.mas_equalTo(44);
            
        }];
        button.backgroundColor =[UIColor whiteColor];
        button;
    });
    
    
    
    
    
    
    
}

- (void)addEvents{
    @weakify(self)
    
    
    //发送验证码
    [[self.getCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        //判断手机号格式是否错误
        if(![TextChecker isTelephone:self.user_tf.text]){
            [ActivityHub ShowHub:KWork_PhoneIllegal];
            return;
        }
        self.getCodeBtn.enabled = NO;
        //        [self showHudInView:self.view hint:@""];
        
        
        [LTSDBManager POST:kLTSDBGetVerifyCode params:@{@"logName":self.user_tf.text} block:^(id responseObject, NSError *error) {
            [self hideHud];
            
            if (responseObject) {
                [ActivityHub ShowHub:@"验证码发送成功!"];
                
                self.countDown = 60;
                [[self timeSignal] subscribeNext:^(NSNumber *countDown) {
                    if ([countDown intValue]) {
                        NSString *tip = [NSString stringWithFormat:@"%dS后重新获取",[countDown intValue]];
                        [self.getCodeBtn setTitle:tip forState:UIControlStateNormal];
                    }else{
                        self.countDown = 0;
                        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
                        [self.getCodeBtn setTitleColor:HexColor(@"#00b0ec") forState:UIControlStateNormal];
                    }
                }];
            }else{
                [ActivityHub ShowHub:@"请重试"];
                self.getCodeBtn.enabled = YES;
            }
            
            if (error) {
                
            }
            
            
        }];
    }];
    
    
    [RACObserve(self.getCodeBtn, enabled) subscribeNext:^(NSNumber *x) {
        @strongify(self)
        
        x.boolValue ? [self.getCodeBtn setTitleColor:HexColor(@"#00b0ec") forState:UIControlStateNormal] : [self.getCodeBtn setTitleColor:LightGrayColor forState:UIControlStateNormal];
    }];
    
    RAC(self.save_btn,enabled) = [RACSignal combineLatest:@[self.user_tf.rac_textSignal,self.code_tf.rac_textSignal,self.password_tf.rac_textSignal,self.repassword_tf.rac_textSignal]  reduce:^id(NSString *userText,NSString *codeText,NSString *passWordText,NSString *rePasswordText,NSNumber *selected){
        @strongify(self)
        return @(userText.length>0 && codeText.length>0 && passWordText.length>0 && rePasswordText.length>0);
        
    }];
    
    [RACObserve(self.save_btn, enabled) subscribeNext:^(NSNumber *x) {
        [UIView animateWithDuration:0.3 animations:^{
            x.boolValue ? [self.save_btn setTitleColor:OrangeColor forState:UIControlStateNormal] : [self.save_btn setTitleColor:LightGrayColor forState:UIControlStateNormal];
        }];
        
    }];
    

    
    //保存密码
    [[self.save_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
    }];
}

//计时信号先放着
-(RACSignal *)timeSignal
{
    __block NSInteger number = self.countDown;
    RACSignal *racSignal = [[[[[RACSignal interval:1.0 onScheduler:[RACScheduler mainThreadScheduler]] take:number] startWith:@(1)] map:^id(NSDate *date) {
        if (number == 0) {
            NSLog(@"获取验证码");
            
            return @(number);
        }else{
            number--;
            return @(number);
        }
    }] takeUntil:self.rac_willDeallocSignal];
    
    return racSignal;
}

- (void)addLineOffsetTop:(CGFloat)offset{
    UIView *line = [UIView new];
    line.backgroundColor = lineBGColor;
    [self.scrollView addSubview:line];
    [line  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(offset);
        make.width.mas_equalTo(Screen_Width);
        make.height.mas_equalTo(0.5);
    }];
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
