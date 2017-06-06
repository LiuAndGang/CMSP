//
//  LTSPersonalRegisterViewController.m
//  CMSP
//
//  Created by 李棠松 on 2016/12/6.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#import "LTSPersonalRegisterViewController.h"
#import "LTSCustomTextField.h"
#import "WPAttributedLabel.h"
#import "LTSAgreementViewController.h"
#import "LTSLogTypeTransition.h"

@interface LTSPersonalRegisterViewController ()<UITableViewDelegate>

@property (nonatomic,strong)UIScrollView *scrollView;
/**表格*/
@property (nonatomic,strong) SettingView *tableView;
/**身份证号*/
@property (nonatomic,strong)LTSCustomTextField *idCard_tf;
/**手机号*/
@property (nonatomic,strong)LTSCustomTextField *user_tf;


@property (nonatomic,strong)LTSCustomTextField *password_tf;

@property (nonatomic,strong)LTSCustomTextField *repassword_tf;

@property (nonatomic,strong)UIButton *login_btn;

@property (nonatomic,strong)UIButton *check_btn;

/**获取验证码按钮*/
@property (nonatomic, strong) UIButton *getCodeBtn;
/**验证码*/
@property (nonatomic,strong) UITextField *codeTextField;


@property (nonatomic,strong)WPTappableLabel *tipLabel;

@property (nonatomic, assign) NSUInteger countDown;
/**观察者*/
@property (nonatomic, weak) id observe;

/**企业名称*/
@property (nonatomic,strong) SettingTextFieldItem *itemEntName;
/**证件类型*/
@property (nonatomic,strong) SettingItem *itemCredentialsStyle;
/**证件类型数组*/
@property (nonatomic,strong) NSArray *id_kinds;
/**证件类型数组下标*/
@property(nonatomic,assign)NSInteger id_kind_index;
/**证件类型返回参数*/
@property(nonatomic,copy) NSString * id_kind_return;
/**证件号码*/
@property (nonatomic,strong) SettingTextFieldItem *itemCredentialsNum;
/**联系人*/
@property (nonatomic,strong) SettingTextFieldItem *itemConnectPeople;
/**手机号码*/
@property (nonatomic,strong) SettingTextFieldItem *itemPhoneNum;
/**验证码*/
@property (nonatomic,strong) SettingCheckBoxItem *itemCodeNum;
/**企业座机号码*/
//@property (nonatomic,strong) SettingTextFieldItem *itemPhone;
/**登录名*/
@property (nonatomic,strong) SettingTextFieldItem *itemLogName;
/**设置登录密码*/
@property (nonatomic,strong) SettingTextFieldItem *itemPassword;
/**再次输入登录密码*/
@property (nonatomic,strong) SettingTextFieldItem *itemRepassword;
/**注册按钮*/
@property (nonatomic,strong)UIButton *register_btn;
/**组尾*/
@property (nonatomic,strong) UIView *backGroundView;
/**短信接口返回的data*/
@property (nonatomic,strong) NSString * msg_data;

@end

@implementation LTSPersonalRegisterViewController
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:_observe];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.id_kinds = @[@"身份证",@"外国护照",@"军官证"];
    
    _observe = [[NSNotificationCenter defaultCenter] addObserverForName:@"partner" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"个人注册---收到了通知");
        
        if (self.curIndex == 0) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择证件类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                _itemCredentialsStyle.subtitle = @"未设置";
                [_tableView reloadData];
                
            }];
            UIAlertAction * action0 = [UIAlertAction actionWithTitle:@"身份证" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                _itemCredentialsStyle.subtitle = @"身份证";
                [_tableView reloadData];
                
            }];
            UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"外国护照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                _itemCredentialsStyle.subtitle = @"外国护照";
                [_tableView reloadData];
                
            }];
            UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"军官证" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                _itemCredentialsStyle.subtitle = @"军官证";
                [_tableView reloadData];
                
            }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:action0];
            [alertController addAction:action1];
            [alertController addAction:action3];
            
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        
    }];
}
#pragma mark 获取当前的控制器
-(UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

- (void)initUI{
    
    self.tableView = ({ SettingView *tableView = [[SettingView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        self.automaticallyAdjustsScrollViewInsets = NO;

        tableView.backgroundColor = BGColorGray;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//                tableView.sectionHeaderHeight = MoreTableViewHeaderHeight;
        tableView.rowHeight = 44;
        
        tableView.sectionHeaderHeight = CGFLOAT_MIN;
        tableView.sectionFooterHeight = 44;
        tableView.bottomLineLeftOffset = 0;
        [self.view addSubview:tableView];
        [tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        UIEdgeInsets contentInset = tableView.contentInset;
        contentInset.top = 0;
        [tableView setContentInset:contentInset];
        tableView;
    });
    
    [self addTableViewGroup1];
    
    
}

- (void)addTableViewGroup1
{
    @weakify(self)
    SettingGroup *group = [self.tableView addGroup];
    //用户类型
    //    _itemUserStyle = [SettingArrowItem itemWithTitle:@"用户类型:"];
    //    _itemUserStyle.subtitle = @"担保公司";
    //    _itemUserStyle.subtitleColor = LightDarkText;
    //    _itemUserStyle.operation = ^(){
    //       @strongify(self)
    //        LTSAlertSheetView *sheetView = [LTSAlertSheetView new];
    //        sheetView.dataBase = self.userStyles;
    //        sheetView.delegate = self;
    //        [sheetView showWithAnimation:YES];
    //    };
    
    
    //证件类型
    _itemCredentialsStyle = [SettingArrowItem itemWithTitle:@"证件类型:"];
    _itemCredentialsStyle.subtitle = @"请选择";
    _itemCredentialsStyle.subtitleColor = LightDarkText;
    _itemCredentialsStyle.operation = ^(){
        
    };
    
    //证件号码
    _itemCredentialsNum = [SettingTextFieldItem itemWithTitle:@"证件号码:"];
    _itemCredentialsNum.placeHolder = @"必填";
    _itemCredentialsNum.textInputBlock = ^(NSString *text){
        
    };
    
    //联系人
    _itemConnectPeople = [SettingTextFieldItem itemWithTitle:@"联系人:"];
    _itemConnectPeople.placeHolder = @"必填";
    _itemConnectPeople.textInputBlock = ^(NSString *text){
        
    };
    
    //手机号码
    _itemPhoneNum = [SettingTextFieldItem itemWithTitle:@"手机号码:"];
    _itemPhoneNum.placeHolder = @"必填";
    _itemPhoneNum.textInputBlock = ^(NSString *text){
        
    };
    
    //企业座机号码
    //    _itemPhone = [SettingTextFieldItem itemWithTitle:@"企业座机号码:"];
    //    _itemPhone.placeHolder = @"必填";
    //    _itemPhone.textInputBlock = ^(NSString *text){
    //
    //    };
    

    //设置登录名
    _itemLogName  = [SettingTextFieldItem itemWithTitle:@"登录名:"];
    _itemLogName.placeHolder = @"必填且只能是手机号码";
    _itemLogName.textInputBlock = ^(NSString *text){
        
    };
    
    //设置登录密码
    _itemPassword = [SettingTextFieldItem itemWithTitle:@"设置登录密码:"];
    _itemPassword.secureTextEntry = YES;
    _itemPassword.placeHolder = @"必填";
    _itemPassword.textInputBlock = ^(NSString *text){
        
    };
    
    //设置登录密码
    _itemRepassword = [SettingTextFieldItem itemWithTitle:@"再次输入登录密码:"];
    _itemRepassword.secureTextEntry = YES;
    _itemRepassword.placeHolder = @"必填";
    _itemRepassword.textInputBlock = ^(NSString *text){
        
    };
    
    
    //底部视图
    {
        UIView *footerView = [UIView new];
        footerView.frame = CGRectMake(0, 0, Screen_Width, 120);
        self.tableView.tableFooterView = footerView;
        
        //注册按钮
        self.register_btn = ({UIButton *button = [UIButton new];
            [footerView addSubview:button];
            [button setTitle:@"注册" forState:UIControlStateNormal];
            button.titleLabel.font = [UIFont systemFontOfSize:18];
            [button setTitleColor:LightGrayColor forState:UIControlStateNormal];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.left.mas_equalTo(0);
                make.top.mas_equalTo(30);
                make.height.mas_equalTo(44);
                
            }];
            button.backgroundColor =[UIColor whiteColor];
            button;
        });
        
        //阅读提示同意按钮
        self.check_btn = ({UIButton  *button = [UIButton new];
            [button setImage:[UIImage imageNamed:@"icon_memberPwd_unselected"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"icon_memberPwd_selected"] forState:UIControlStateSelected];
            [footerView addSubview:button];
            [button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(15);
                make.top.mas_equalTo(self.register_btn.mas_bottom).with.offset(15);
                make.width.mas_equalTo(15);
                make.height.mas_equalTo(15);
            }];
            button;
        });
        
        
        
        NSDictionary* style = @{@"body":[UIFont systemFontOfSize:13],
                                @"help":[WPAttributedStyleAction styledActionWithAction:^{
                                    LTSAgreementViewController *agreeVc = [LTSAgreementViewController new];
                                    agreeVc.stringHtml =[kLTSDBBaseUrl stringByAppendingString:KLTSDBDisclaimer];
                                    [self.navigationController pushViewController:agreeVc animated:YES];
                                }],
                                
                                @"link": HexColor(@"#00b0ec")};
        
        NSString *str = @"我已阅读《用户服务协议》，并同意遵守该协议所规定的各项条款";
        self.tipLabel = ({ WPHotspotLabel *label = [[WPHotspotLabel alloc] init];
            
            label.textColor = DrakGrayColor;
            
            //设置属性字符串
            NSMutableAttributedString * attributedString = [@"我已阅读<help>《用户服务协议》</help>，并同意遵守该协议所规定的各项条款" attributedStringWithStyleBook:style];
            NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:5];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [str length])];
            [attributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:NSMakeRange(0, [str length])];
            
            label.attributedText = attributedString;
            
            label.numberOfLines = 0;
            label.userInteractionEnabled=YES;
            [footerView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(self.check_btn.mas_right).with.offset(5);
                make.top.mas_equalTo(self.check_btn.mas_centerY).with.offset(-7);
                make.right.mas_equalTo(-15);
            }];
            label;
        });
        
    }
    
    
    
    //验证码
    {
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 44)];
        _backGroundView.backgroundColor = [UIColor whiteColor];
        
        _codeTextField = [[UITextField alloc] init];
        [_backGroundView addSubview:_codeTextField];
        _codeTextField.placeholder = @"请输入验证码";
        _codeTextField.font = [UIFont systemFontOfSize:15];
        [_codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.height.mas_equalTo(_backGroundView);
            make.width.mas_equalTo(SCREEN_W*2/3);
            make.left.mas_equalTo(_backGroundView).with.offset(20);
        }];
        
        _getCodeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
        [_getCodeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _getCodeBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_backGroundView addSubview:_getCodeBtn];
        [_getCodeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(_codeTextField.mas_right);
            make.top.height.right.mas_equalTo(_backGroundView);
            make.left.mas_equalTo(_codeTextField.mas_right).with.offset(10);

        }];

    }
    
    //判断注册按钮的状态----(座机号接口暂时不支持，先去掉，后期再添加)
    {
        RAC(self.register_btn,enabled) = [RACSignal combineLatest:@[RACObserve(_itemCredentialsNum, text),RACObserve(_itemLogName, text),RACObserve(_itemConnectPeople, text),RACObserve(_itemPhoneNum, text),RACObserve(_itemPassword, text),RACObserve(_itemRepassword, text),RACObserve(self.check_btn, selected),_codeTextField.rac_textSignal] reduce:^id(NSString *itemCredentialsNumText,NSString *itemConnectPeopleText,NSString *itemPhoneNumText,NSString *itemLogNameText,NSString *itemPasswordText,NSString *itemRepasswordText,NSNumber *selected,NSString *codeTextFieldText){
            
            return @(itemCredentialsNumText.length>0 && itemLogNameText.length>0 &&itemConnectPeopleText.length>0 && itemPhoneNumText.length>0 && itemPasswordText.length>0 && itemRepasswordText.length>0 && selected.boolValue && codeTextFieldText.length>0);
        }];
        
        
        [RACObserve(self.register_btn, enabled) subscribeNext:^(NSNumber *x) {
            [UIView animateWithDuration:0.3 animations:^{
                x.boolValue ? [self.register_btn setTitleColor:OrangeColor forState:UIControlStateNormal] : [self.register_btn setTitleColor:LightGrayColor forState:UIControlStateNormal];
            }];
            
        }];
        
    }

    
    group.footerView = _backGroundView;
    group.items = @[_itemCredentialsStyle,_itemCredentialsNum,_itemConnectPeople,_itemLogName,_itemPassword,_itemRepassword,_itemPhoneNum];
    
    
}




- (void)addEvents{
    @weakify(self)
    
    
    [[self.check_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
       @strongify(self)
        self.check_btn.selected = !self.check_btn.selected;
    }];
    
    //发送验证码按钮的状态
    RAC(self.getCodeBtn ,enabled) = [RACSignal combineLatest:@[RACObserve(_itemPhoneNum, text)] reduce:^id(NSString *itemPhoneNumText){
        //如果按钮还没有点击或者已经过了60s，则根据itemPhoneNumText判断按钮的状态
        if ([self.getCodeBtn.titleLabel.text isEqualToString:@"获取验证码"]) {
            return @(itemPhoneNumText.length);
        }else{//如果按钮已经点击，则不能根据itemPhoneNumText判断按钮的状态，enable只能为NO
            return @0;
        }
    }];
    
//    if (_itemPhoneNum.text.length) {
//        self.getCodeBtn.enabled = YES;
//    }else{
//        self.getCodeBtn.enabled = NO;
//
//    }
    
    [RACObserve(self.getCodeBtn, enabled) subscribeNext:^(NSNumber *x) {
        @strongify(self)
        
        x.boolValue ? [self.getCodeBtn OrangeRoundButtonStyle] : [self.getCodeBtn GrayRoundButtonStyle];
    }];

    
    //发送验证码
    [[self.getCodeBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        //判断手机号格式是否错误
        if(![TextChecker isTelephone:self.itemPhoneNum.text]){
            [ActivityHub ShowHub:KWork_PhoneIllegal];
            return;
        }
        self.getCodeBtn.enabled = NO;
        
        
        [LTSDBManager POST:[kLTSDBBaseUrl stringByAppendingString:kLTSDBGetVerifyCode] params:@{@"mobile_phone":self.itemPhoneNum.text} block:^(id responseObject, NSError *error) {
            [self hideHud];
            
            if ([responseObject[@"result"] isEqual:@1]) {
                [ActivityHub ShowHub:@"验证码发送成功!"];
                self.msg_data = responseObject[@"data"];
                self.countDown = 60;
                [[self timeSignal] subscribeNext:^(NSNumber *countDown) {
                    if ([countDown intValue]) {
                        NSString *tip = [NSString stringWithFormat:@"%dS后重新获取",[countDown intValue]];
                        [self.getCodeBtn setTitle:tip forState:UIControlStateNormal];
                    }else{
                        self.countDown = 0;
                        [self.getCodeBtn setTitle:@"获取验证码" forState:UIControlStateNormal];
//                        [self.getCodeBtn setTitleColor:HexColor(@"#00b0ec") forState:UIControlStateNormal];
                        self.getCodeBtn.enabled = YES;
                    }
                }];
            }else{
                [ActivityHub ShowHub:responseObject[@"msg"]];
            
                self.getCodeBtn.enabled = YES;
            }
            
            if (error) {
                NSLog(@"error:%@",error);
            }
            
        
        }];
    }];
    
    
    
    
    //注册
    [[self.register_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        //所选定的证件类型的返回参数
        switch (_id_kind_index) {
            case 0:
                _id_kind_return = @"0";
                break;
            case 1:
                _id_kind_return = @"1";
                break;
            case 2:
                _id_kind_return = @"3";
                break;
            default:
                break;
        }
        

        
        //转换登录用户类型
        NSString *login_user_type = @"11";
        
        [LTSDBManager POST:[kLTSDBBaseUrl stringByAppendingString:KLTSDBPresonal] params:@{@"login_user_type":login_user_type,@"id_kind":_id_kind_return,@"logName":_itemLogName.text,@"password":_itemPassword.text,@"person_code":_itemCredentialsNum.text,@"msg_code":_codeTextField.text,@"real_name":_itemConnectPeople.text,@"mobile_phone":_itemPhoneNum.text,@"msg_data":self.msg_data} block:^(id responseObject, NSError *error) {
            if ([responseObject[@"result"] isEqual:@1]) {
                NSLog(@"用户注册成功")
                NSLog(@"responseObject:%@",responseObject);
                [self showSuccessInView:self.view hint:@"注册成功"];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popViewControllerAnimated:YES];
                });

                
            }else{
                [ActivityHub ShowHub:@"注册失败"];
                NSLog(@"用户注册失败");
            }
        }];


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
