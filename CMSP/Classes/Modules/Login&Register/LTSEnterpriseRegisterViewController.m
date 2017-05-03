//
//  LTSEnterpriseRegisterViewController.m
//  CMSP
//
//  Created by 李棠松 on 2016/12/6.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#import "LTSEnterpriseRegisterViewController.h"
#import "SettingView.h"
#import "LTSAlertSheetView.h"
#import "WPAttributedLabel.h"
#import "LTSLogTypeTransition.h"
@interface LTSEnterpriseRegisterViewController ()

@property (nonatomic,strong)SettingView *tableView;
//用户类型
//@property (nonatomic,strong)SettingItem *itemUserStyle;

@property (nonatomic,strong)UIButton *register_btn;

@property (nonatomic,strong)WPTappableLabel *tipLabel;

@property (nonatomic,strong)UIButton *check_btn;

@property (nonatomic,strong)NSArray *userStyles;
@property (nonatomic,strong)NSArray *credentialsStyles;
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
/**企业座机号码*/
//@property (nonatomic,strong) SettingTextFieldItem *itemPhone;
/**登录名*/
@property (nonatomic,strong) SettingTextFieldItem *itemLogName;
/**设置登录密码*/
@property (nonatomic,strong) SettingTextFieldItem *itemPassword;
/**再次输入登录密码*/
@property (nonatomic,strong) SettingTextFieldItem *itemRepassword;
/**观察者*/
@property (nonatomic, weak) id observe;

@end

@implementation LTSEnterpriseRegisterViewController

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:_observe];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.id_kinds = @[@"组织机构代码",@"统一社会信用代码",@"工商注册号",@"税务登记号"];
    
    _observe = [[NSNotificationCenter defaultCenter] addObserverForName:@"partner" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSLog(@"企业注册---收到了通知");
        
        if (self.curIndex == 2) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择证件类型" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
                _itemCredentialsStyle.subtitle = @"未设置";
                [_tableView reloadData];
                
            }];
            UIAlertAction * actionP = [UIAlertAction actionWithTitle:@"组织机构代码" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                _itemCredentialsStyle.subtitle = @"组织机构代码";
                [_tableView reloadData];
                
            }];
            UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"社会统一信用代码" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                _itemCredentialsStyle.subtitle = @"社会统一信用代码";
                [_tableView reloadData];
                
            }];
            UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"工商注册号" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                _itemCredentialsStyle.subtitle = @"工商注册号";
                [_tableView reloadData];
                
            }];
            UIAlertAction *actioni = [UIAlertAction actionWithTitle:@"税务登记号" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                _itemCredentialsStyle.subtitle = @"税务登记号";
                [_tableView reloadData];
                
            }];
            
            [alertController addAction:cancelAction];
            [alertController addAction:actionP];
            [alertController addAction:action4];
            [alertController addAction:action2];
            [alertController addAction:actioni];
            
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
    self.tableView = ({ SettingView *tableView = [[SettingView alloc] init];
        tableView.backgroundColor = BGColorGray;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        //        tableView.sectionHeaderHeight = MoreTableViewHeaderHeight;
        tableView.rowHeight = 44;
        tableView.sectionHeaderHeight = 0;
        tableView.sectionFooterHeight = 10;
        tableView.bottomLineLeftOffset = 0;
        [self.view addSubview:tableView];
        [tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
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
    
    //企业名称
    _itemEntName = [SettingTextFieldItem itemWithTitle:@"企业名称:"];
    _itemEntName.placeHolder = @"请填写企业名称";
    _itemEntName.textInputBlock = ^(NSString *text){
        
    };
    
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
    _itemLogName.placeHolder = @"必填";
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
        footerView.frame = CGRectMake(0, 0, Screen_Width, 100);
        group.footerView = footerView;
        
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
            }];
            button;
        });
        
        
        
        NSDictionary* style = @{@"body":[UIFont systemFontOfSize:13],
                                @"help":[WPAttributedStyleAction styledActionWithAction:^{
                                    
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
    
    
    //判断注册按钮的状态----(座机号接口暂时不支持，先去掉，后期再添加)
    {
        RAC(self.register_btn,enabled) = [RACSignal combineLatest:@[RACObserve(_itemEntName, text),RACObserve(_itemCredentialsNum, text),RACObserve(_itemLogName, text),RACObserve(_itemConnectPeople, text),RACObserve(_itemPhoneNum, text),RACObserve(_itemPassword, text),RACObserve(_itemRepassword, text),RACObserve(self.check_btn, selected)] reduce:^id(NSString *itemEntNameText,NSString *itemCredentialsNumText,NSString *itemConnectPeopleText,NSString *itemPhoneNumText,NSString *itemLogNameText,NSString *itemPasswordText,NSString *itemRepasswordText,NSNumber *selected){
            
            return @(itemEntNameText.length>0 && itemCredentialsNumText.length>0 && itemLogNameText.length>0 &&itemConnectPeopleText.length>0 && itemPhoneNumText.length>0 && itemPasswordText.length>0 && itemRepasswordText.length>0 && selected.boolValue );
        }];
        
        [RACObserve(self.register_btn, enabled) subscribeNext:^(NSNumber *x) {
            [UIView animateWithDuration:0.3 animations:^{
                x.boolValue ? [self.register_btn setTitleColor:OrangeColor forState:UIControlStateNormal] : [self.register_btn setTitleColor:LightGrayColor forState:UIControlStateNormal];
            }];
            
        }];
    }
    
    
    group.items = @[_itemEntName,_itemCredentialsStyle,_itemCredentialsNum,_itemConnectPeople,_itemPhoneNum,_itemLogName,_itemPassword,_itemRepassword];
    
    
}



- (void)addEvents{
    @weakify(self)
    
    [[self.check_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        self.check_btn.selected = !self.check_btn.selected;
    }];
    
    
    //注册
    [[self.register_btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        
        //所选定的证件类型的返回参数
        switch (_id_kind_index) {
            case 0:
                _id_kind_return = @"P";
                break;
            case 1:
                _id_kind_return = @"4";
                break;
            case 2:
                _id_kind_return = @"2";
                break;
            case 3:
                _id_kind_return = @"i";
                break;
            default:
                break;
        }
        
        //汉字转码
        [LTSDBManager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        NSString *company_name = [_itemEntName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *real_name = [_itemConnectPeople.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSString *logName = [_itemLogName.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        
        //转换登录用户类型
        NSString *login_user_type = [LTSLogTypeTransition logTypeTransition];
        
        [LTSDBManager POST:[kLTSDBBaseUrl stringByAppendingString:kLTSDBRegUser]params:@{@"login_user_type":login_user_type,@"id_kind":_id_kind_return,@"logName":logName,@"password":_itemPassword.text,@"company_name":company_name,@"org_code":_itemCredentialsNum.text,@"real_name":real_name,@"mobile_phone":_itemPhoneNum.text} block:^(id responseObject, NSError *error) {
            if ([responseObject[@"result"] isEqualToString:@"true"]) {
                NSLog(@"用户注册成功")
                
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [ActivityHub ShowHub:@"注册失败"];
                NSLog(@"用户注册失败");
            }
        }];
        
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
