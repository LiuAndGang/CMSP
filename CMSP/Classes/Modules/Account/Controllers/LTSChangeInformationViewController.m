//
//  LTSChangeInformationViewController.m
//  SAIFAMC
//
//  Created by leetangsong_macbk on 16/4/15.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "LTSChangeInformationViewController.h"
#import "LeftLabelTextField.h"
#import "LTSUserInfoModel.h"
#import "LTSLogTypeTransition.h"
@interface LTSChangeInformationViewController ()<UITextFieldDelegate>

@property (strong, nonatomic) UIBarButtonItem *commit;
/**内容文本*/
@property (nonatomic, copy)  NSString *originalMessage;
/**左边标题*/
@property (nonatomic,copy)NSString *leftTitle;

@property (nonatomic,copy)NSString *nav_title;
/**用户信息模型*/
@property (nonatomic,strong) LTSUserInfoModel *model;


@end

@implementation LTSChangeInformationViewController

- (instancetype)initWithNavTitle:(NSString *)nav_title message:(NSString *)message title:(NSString *)title{
    if (self == [super init]) {
       
        self.leftTitle = title;
        
        self.nav_title = nav_title;
        
        self.originalMessage = message;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.nav_title;
    _model = [[LTSUserInfoModel alloc] init];
    [self addEvents];
}
- (void)initUI
{
    CGFloat padding = 20;
    CGFloat textFieldH = 40;
//    CGFloat textFieldPadding = 10;
    
    self.tf_title = [[LeftLabelTextField alloc] initWithTitle:self.leftTitle placeHolder:[NSString stringWithFormat:@"请输入%@",self.leftTitle]];
    self.tf_title.text = self.originalMessage;
    self.tf_title.delegate = self;
    
    
    [self.view addSubview:self.tf_title];
    [self.tf_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(20);
        make.left.equalTo(self.view).with.offset(padding);
        make.right.equalTo(self.view.mas_right).with.offset(-padding);
        make.height.mas_equalTo(textFieldH);
    }];
    
}


//- (void)addEvents
//{
//    @weakify(self)
//    [[self.btn_submit rac_signalForControlEvents:UIControlEventTouchUpInside]  subscribeNext:^(id x) {
//        @strongify(self)
//                //保存
//    }];
//    
//    //确认修改按钮
////    RAC(self.self.btn_submit, enabled) = [RACSignal combineLatest:@[self.tf_title.rac_textSignal] reduce:^id(NSString *newNameText){
////        return @(newNameText.length > 0);
////    }];
//    
////    [RACObserve(self.btn_submit, enabled) subscribeNext:^(NSNumber *x) {
////        @strongify(self)
////        [UIView animateWithDuration:0.3 animations:^{
////            self.btn_submit.alpha = [x boolValue] ?  1 : 0.5;
////        }];
////    }];
//}

- (void)initNav{
    
    //保存按钮
    self.commit = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(click)];
    _commit.enabled = NO;
    
    [[self.tf_title rac_signalForControlEvents:UIControlEventEditingChanged|UIControlEventAllTouchEvents]subscribeNext:^(id x) {
        if (!self.tf_title.text.length) {
            _commit.enabled = NO;
        }
        else _commit.enabled = YES;
    }];
    [_commit setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = _commit;
    
    
}

//-(void)commitState
//{
//    if (_tf_title.text  == NULL) {
//        _commit.enabled = NO;
//    }else{
//        _commit.enabled = YES;
//    }
//
//}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([_leftTitle isEqualToString:@"用户类型"]) {
        [_tf_title resignFirstResponder];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择用户类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *personalAction = [UIAlertAction actionWithTitle:@"自然人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _tf_title.text = @"自然人";
            _commit.enabled = YES;
        }];
        UIAlertAction *ceoAction = [UIAlertAction actionWithTitle:@"公司法人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _tf_title.text = @"公司法人";
            _commit.enabled = YES;

        }];
        UIAlertAction *partnerAction = [UIAlertAction actionWithTitle:@"合作机构" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _tf_title.text = @"合作机构";
            _commit.enabled = YES;

        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _tf_title.text = _originalMessage;
            _commit.enabled = YES;
            
        }];

        [alertController addAction:personalAction];
        [alertController addAction:ceoAction];
        [alertController addAction:partnerAction];
        [alertController addAction:cancelAction];

        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    
    if ([_leftTitle isEqualToString:@"证件类型"]) {
        [_tf_title resignFirstResponder];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择证件类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *personalAction = [UIAlertAction actionWithTitle:@"组织机构代码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _tf_title.text = @"组织机构代码";
            _commit.enabled = YES;
        }];
        UIAlertAction *ceoAction = [UIAlertAction actionWithTitle:@"统一社会信用代码" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _tf_title.text = @"统一社会信用代码";
            _commit.enabled = YES;

        }];
        UIAlertAction *partnerAction = [UIAlertAction actionWithTitle:@"工商注册号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _tf_title.text = @"工商注册号";
            _commit.enabled = YES;

        }];
        UIAlertAction *taxAction = [UIAlertAction actionWithTitle:@"税务登记号" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _tf_title.text = @"税务登记号";
            _commit.enabled = YES;

        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            _tf_title.text = _originalMessage;
            _commit.enabled = YES;
            
        }];

        [alertController addAction:personalAction];
        [alertController addAction:ceoAction];
        [alertController addAction:partnerAction];
        [alertController addAction:taxAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }

    return YES;
}

//保存按钮点击事件
-(void)click{
    
    self.commit.enabled = NO;
    if ([self.tf_title.text isEqualToString:self.originalMessage]) {
        return;
    }else{
        if ([self.leftTitle isEqualToString:@"真实姓名"]) {
            if (!self.tf_title.text.length) {
                _model.real_name = @"未设置";
            }else{
                _model.real_name = self.tf_title.text;
            }
        }
        if ([self.leftTitle isEqualToString:@"手机号"]) {
            if (!self.tf_title.text.length) {
                _model.mobile_phone = @"未设置";
            }else{
                _model.mobile_phone = self.tf_title.text;
            }
        }
        
        if ([self.leftTitle isEqualToString:@"公司名称"]) {
            if (!self.tf_title.text.length) {
                _model.company_name = @"未设置";
            }else{
                _model.company_name = self.tf_title.text;
            }
        }
        if ([self.leftTitle isEqualToString:@"证件类型"]) {
            if (!self.tf_title.text.length) {
                _model.id_kind = @"未设置";
            }else{
                _model.id_kind = self.tf_title.text;
            }
        }
        
        if ([self.leftTitle isEqualToString:@"证件号码"]) {
            if (!self.tf_title.text.length) {
                _model.org_code = @"未设置";
            }else{
                _model.org_code = self.tf_title.text;
            }
        }
       
        //修改用户信息
        
        if ([_model.id_kind isEqualToString:@"组织机构代码"]) {
            _model.id_kind = @"P";
        }else if ([_model.id_kind isEqualToString:@"统一社会信用代码"]){
            _model.id_kind = @"4";

        }else if ([_model.id_kind isEqualToString:@"工商注册号"]){
            _model.id_kind = @"2";

        }else if ([_model.id_kind isEqualToString:@"税务登记号"]){
            _model.id_kind = @"i";

        }
        

        NSLog(@"修改信息model----%@",_model);
        //转换登录用户类型
        NSString *login_user_type = [LTSLogTypeTransition logTypeTransition];

        NSString *logName = [LTSUserDefault objectForKey:@"logName"];

        [LTSDBManager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
//        NSString *real_name = [_model.real_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSString *comany_name = [_model.company_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

        [LTSDBManager POST:[kLTSDBBaseUrl stringByAppendingString:KLTSDBChangeUserInfo] params:@{@"logName":logName,@"login_user_type":login_user_type,@"id_kind":_model.id_kind,@"company_name":_model.company_name,@"org_code":_model.org_code,@"real_name":_model.real_name,@"mobile_phone":_model.mobile_phone,} block:^(id responseObject, NSError *error) {
            if (responseObject[@"result"]) {
                NSLog(@"修改用户信息成功");
                [self.navigationController popViewControllerAnimated:YES];

            }else{
                NSLog(@"修改用户信息失败");
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];

    }
}

//- (void)click{
//    [self.view endEditing:YES];
//    self.commit.enabled = NO;
//    if ([self.tf_title.text isEqualToString:self.originalMessage]) {
//        return;
//    }
//    NSMutableDictionary *params = [@{@"userID":UserId} mutableCopy];
//    
//    params[@"headImage"] = LTSUserDes.headImage;
//    params[@"userName"] = LTSUserDes.userName;
//    params[@"nickName"] = LTSUserDes.nickName;
//    params[@"mobilePhone"] = LTSUserDes.mobilePhone;
//    params[@"eMail"] = LTSUserDes.eMail;
//    params[@"addressLocation"] = LTSUserDes.addressLocation;
//    params[@"autograph"] = LTSUserDes.autograph;
//    
//    
//    
//    
//    if ([self.leftTitle isEqualToString:@"真实姓名"]) {
//       
//         params[@"userName"] = self.tf_title.text;
//        if (!LTSUserDes.nickName.length) {
//             params[@"userName"] = @" ";
//        }else  params[@"userName"] = LTSUserDes.nickName;
//        
//       
//        
//    }
//    
//    if ([self.leftTitle isEqualToString:@"昵称"]) {
//        params[@"nickName"] = self.tf_title.text;
//       
//        if (!LTSUserDes.userName.length) {
//            params[@"nickName"] = @" ";
//        }else  params[@"nickName"] = LTSUserDes.userName;
//        
//      
//    }
//    if ([self.leftTitle isEqualToString:@"手机"]) {
//       self.tf_title.keyboardType = UIKeyboardTypeNumberPad;
//        if (![TextChecker isTelephone:self.tf_title.text]) {
//            [ActivityHub ShowHub:@"请输入正确的手机号码"];
//            return;
//        }
//        params[@"mobilePhone"] = self.tf_title.text;
//        
//    }
//    if ([self.leftTitle isEqualToString:@"邮箱"]) {
//        if (![TextChecker isEmailAddress:self.tf_title.text]) {
//            [ActivityHub ShowHub:@"请输入正确的邮箱"];
//            return;
//        }
//        params[@"eMail"] = self.tf_title.text;
//    }
//
//    if ([self.leftTitle isEqualToString:@"地址"]) {
//        params[@"addressLocation"] = self.tf_title.text;
//    }
//    if ([self.leftTitle isEqualToString:@"个性签名"]) {
//        params[@"autograph"] = self.tf_title.text;
//    }
//    LTSUser *user = LTSUserDes;
//    [self showHudInView:self.view hint:@"正在保存"];
//
//    [LTSDBManager POST:kLTSDBCustomUserInfoModify params:params block:^(id responseObject, NSError *error) {
//        [self hideHud];
//        if ([responseObject isEqualToString:@"success"]) {
//            [self showHint:@"保存成功"];
//            if ([self.leftTitle isEqualToString:@"真实姓名"]) {
//                
//                user.userName = self.tf_title.text;
//                
//            }
//            
//            if ([self.leftTitle isEqualToString:@"昵称"]) {
//                user.nickName = self.tf_title.text;
//              
//            }
//            if ([self.leftTitle isEqualToString:@"手机"]) {
//                
//                user.mobilePhone = self.tf_title.text;
//                
//            }
//            if ([self.leftTitle isEqualToString:@"邮箱"]) {
//               
//                user.eMail = self.tf_title.text;
//            }
//            
//            if ([self.leftTitle isEqualToString:@"地址"]) {
//               user. addressLocation = self.tf_title.text;
//            }
//            if ([self.leftTitle isEqualToString:@"个性签名"]) {
//                user.autograph = self.tf_title.text;
//            }
//            
//            [LTSUserDefault setObject:[user dataFromUser]  forKey:KPath_UserDes];
//    
////            [LTSNotification postNotificationName:KNotification_UserInfoUpdate object:nil];
//            [self.navigationController popViewControllerAnimated:YES];
//            self.updateSuccessBlck(self.tf_title.text);
//        }
//    }];
//
//}
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
