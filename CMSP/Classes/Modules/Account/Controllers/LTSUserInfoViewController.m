//
//  LTSUserInfoViewController.m
//  CMSP
//
//  Created by 刘刚 on 17/4/11.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import "LTSUserInfoViewController.h"
#import "LTSSetGesturePwdViewController.h"
#import "LTSLoginViewController.h"
#import "LTSChangeInformationViewController.h"
#import "LTSUserInfoModel.h"
#import "MJRefresh.h"
#import "LTSLogTypeTransition.h"

//#import ""
@interface LTSUserInfoViewController ()<UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate>
/**数据源*/
@property (nonatomic,strong) NSArray *dataSource;
/**企业用户数据源*/
@property (nonatomic,strong) NSArray *dataSourceEnterprise;
/**个人用户数据源*/
@property (nonatomic,strong) NSArray *dataSourcePersonsl;
@property (nonatomic,strong)UIButton *outButton;
@property (nonatomic,strong) UITableView *tableView;
/**用户信息字典*/
@property (nonatomic,strong) NSMutableDictionary *userInfoDic;
@end

@implementation LTSUserInfoViewController

-(NSMutableDictionary *)userInfoDic{
    if (!_userInfoDic) {
        _userInfoDic = [[NSMutableDictionary alloc] init];
    }
    return _userInfoDic;
}

//隐藏tabBar
-(void)viewDidAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    //马上进入刷新状态
//    [self.tableView.mj_header beginRefreshing];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的";
    self.view.backgroundColor = BGColorGray;

    [self initUI];
    [self initData];
}

-(void)initData{
    
    //转换登录用户类型
    NSString *login_user_type = [LTSLogTypeTransition logTypeTransition];

    //获取用户详情
//    [LTSDBManager.requestSerializer setValue:@"application/x-www-form-urlencoded; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
        if ([LTSUserDefault objectForKey:Login_Token]) {
        [LTSDBManager POST:[kLTSDBBaseUrl stringByAppendingString:KLTSDBGainUserInfo] params:@{@"login_user_type":login_user_type,@"logName":[LTSUserDefault objectForKey:@"logName"]} block:^(id responseObject, NSError *error) {
            if (responseObject[@"result"]) {
                NSLog(@"获取用户详情成功");
                [self.tableView.mj_header endRefreshing];
                
                [self.userInfoDic setValue:[responseObject[@"data"][@"real_name"] stringByRemovingPercentEncoding] forKey:@"真实姓名"];
                [self.userInfoDic setValue:responseObject[@"data"][@"mobile_phone"]  forKey:@"手机号"];
                [self.userInfoDic setValue:responseObject[@"data"][@"organ_flag"] forKey:@"用户类型"];
                [self.userInfoDic setValue:[responseObject[@"data"][@"company_name"] stringByRemovingPercentEncoding] forKey:@"公司名称"];
                [self.userInfoDic setValue:responseObject[@"data"][@"id_kind"] forKey:@"证件类型"];
                [self.userInfoDic setValue:responseObject[@"data"][@"id_no"] forKey:@"证件号码"];
                [self.userInfoDic setValue:[LTSUserDefault objectForKey:@"logName"] forKey:@"登录名"];

                NSLog(@"responseObject：%@",responseObject);
                
                
                //判断用户性质
//                NSString *string = [NSString stringWithFormat:@"%@",_userInfoDic[@"用户类型"]];
//                _userInfoDic[@"用户类型"] = string.intValue;
                if ([_userInfoDic[@"用户类型"] intValue] == 0) {
                    _userInfoDic[@"用户类型"] = @"自然人";
                }else if([_userInfoDic[@"用户类型"] intValue] == 1){
                    _userInfoDic[@"用户类型"] = @"公司法人";
                }else if([_userInfoDic[@"用户类型"] intValue] == 3){
                    _userInfoDic[@"用户类型"] = @"合作机构";
                }
                
                //判断证件类型
                if ([_userInfoDic[@"证件类型"] isEqualToString:@"P"]) {
                    _userInfoDic[@"证件类型"] = @"组织机构代码";
                }else if([_userInfoDic[@"证件类型"] isEqualToString:@"4"]){
                    _userInfoDic[@"证件类型"] = @"统一社会信用代码";
                }else if ([_userInfoDic[@"证件类型"] isEqualToString:@"2"]){
                    _userInfoDic[@"证件类型"] = @"工商注册号";
                }else if([_userInfoDic[@"证件类型"] isEqualToString:@"i"]){
                    _userInfoDic[@"证件类型"] = @"税务登记号";
                }
                
                //刷新表格
                [self.tableView reloadData];
                
                
                LTSUserInfoModel *userInfoModel = [LTSUserInfoModel modelWithDict:_userInfoDic];
                NSLog(@"%@",userInfoModel);
                
            }else{
                [_tableView.mj_header endRefreshing];
                NSLog(@"获取详情失败");
            }
        }];

    }
    
    _dataSourceEnterprise = @[@[@"真实姓名",@"手机号"],
                            @[@"用户类型",@"公司名称",@"证件类型",@"证件号码"]];
    _dataSourcePersonsl = @[@[@"登录名",@"用户类型"],
                            @[@"真实姓名",@"证件号码"]];
    
    NSString *string = [LTSUserDefault objectForKey:KPath_UserLoginType];

    if (string.intValue == 1 ||string.intValue == 2||string.intValue == 3) {
        _dataSource = _dataSourcePersonsl;
    }else if(string.intValue == 5 ||string.intValue == 6||string.intValue == 7||string.intValue == -7){
        _dataSource = _dataSourceEnterprise;
    }
}

-(void)initUI
{
    //UITableView
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    tableView.backgroundColor = BGColorGray;
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    tableView.tableHeaderView.height = 0;
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;
    
    //创建下拉刷新控件
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self initData];
    }];

    
    //表头视图
    UIView *topView = [[UIView alloc] init];
    topView.backgroundColor = [UIColor redColor];
    topView.frame = CGRectMake(0, 0, SCREEN_W, 75);
//    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.mas_equalTo(0);
//        make.height.mas_equalTo(75);
//        make.width.mas_equalTo(SCREEN_W);
//    }];
//    self.tableView.tableHeaderView = topView;
    
    UILabel *iconLabel = [[UILabel alloc] init];
    iconLabel.backgroundColor = [UIColor greenColor];
    iconLabel.frame = CGRectMake(15, 30, 60, 20);
//    [iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(topView).with.offset(15);
//        make.size.mas_equalTo(CGSizeMake(40, 20));
//        make.centerY.mas_equalTo(topView);
//    }];
    [topView addSubview:iconLabel];
    
    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.image = [UIImage imageNamed:@"icon_headerDefault"];
    imageView.backgroundColor = [UIColor whiteColor];
    imageView.frame = CGRectMake(SCREEN_W - 20-55, 10, 55, 55);
    imageView.layer.cornerRadius = 55/2;
//    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.right.mas_equalTo(topView).with.offset(-30);
//        make.top.mas_equalTo(topView).with.offset(10);
//        make.height.width.mas_equalTo(55);
//    }];
    [topView addSubview:imageView];
    UIGestureRecognizer *tap = [[UIGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap)];
    [imageView addGestureRecognizer:tap];
    tap.delegate = self;
    imageView.userInteractionEnabled = YES;
    topView.userInteractionEnabled = YES;
    self.view.userInteractionEnabled = YES;
    
    //退出登录按钮
    UIView *footerView = [UIView new];
    footerView.frame = CGRectMake(0, 0, Screen_Width, 100);
    tableView.tableFooterView = footerView;
    self.outButton = ({UIButton *button = [UIButton new];
        [footerView addSubview:button];
        [button setTitle:@"退出" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:18];
        [button setTitleColor:OrangeColor forState:UIControlStateNormal];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.left.mas_equalTo(0);
            make.top.mas_equalTo(25);
            make.height.mas_equalTo(44);
            
        }];
        button.backgroundColor =[UIColor whiteColor];
        button;
    });
    [_outButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
}

//-(void)imageViewTap
//{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
//    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"照相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    UIAlertAction *pictureAction = [UIAlertAction actionWithTitle:@"本地相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//    }];
//    
//    [alertController addAction:cameraAction];
//    [alertController addAction:pictureAction];
//    [alertController addAction:cancelAction];
//    [self presentViewController:alertController animated:YES completion:nil];
//}

//用户登出
-(void)logout{
    @weakify(self)
    [[self.outButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [LTSDBManager POST:[kLTSDBBaseUrl stringByAppendingString:KLTSDBLogout] params:@{@"grantticket_id":(NSString*)[LTSUserDefault valueForKey:Login_Token]} block:^(id responseObject, NSError *error) {
            if (responseObject[@"result"]) {
                NSLog(@"登出成功！");
                LTSLoginViewController *loginVC = [LTSLoginViewController new];
                [self presentViewController:loginVC animated:YES completion:nil];
                
                [LTSUserDefault setBool:0 forKey:KPath_UserLoginState];
                [LTSUserDefault setBool:0 forKey:KPath_AutoLogin];
                [LTSUserDefault setObject:nil forKey:Login_Token];
            }
        }];
        
    }];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    //cell左侧标题
    cell.textLabel.text = _dataSource[indexPath.section][indexPath.row];
    cell.textLabel.textColor = HexColor(@"#676769");
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if ([[LTSUserDefault objectForKey:KPath_UserLoginType] isEqualToString:@"1"]) {//不是个人用户和企业用户的时候
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if ([cell.textLabel.text isEqualToString:@"手机号"]){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    //第一行头像
//    if (indexPath.section == 0 && indexPath.row == 0) {
//        
//    }else{
        //cell右侧副标题
//        if ([cell.textLabel.text isEqualToString:@"头像"]) {
//            UIImageView *imageView = [[UIImageView alloc] init];
//            imageView.image = [UIImage imageNamed:@"icon_headerDefault"];
//            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.right.mas_equalTo(30);
//                make.top.mas_equalTo(10);
//                make.height.width.mas_equalTo(55);
//            }];
//            [cell.detailTextLabel addSubview:imageView];
//            
//        }else{
        
            NSString *title = (NSString *)_dataSource[indexPath.section][indexPath.row];
            cell.detailTextLabel.text = self.userInfoDic[title];
            
            cell.detailTextLabel.font  = [UIFont systemFontOfSize:15];
            cell.detailTextLabel.textColor = HexColor(@"#676769");

//        }
//    }
    
    
    return cell;
}

//cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消反选
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //获取当前点击的cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    

    if (cell.accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        //手势密码
        if (indexPath.section == 3) {
            if (indexPath.row == 1) {
                LTSSetGesturePwdViewController *gestureVc = [LTSSetGesturePwdViewController new];
                [self.navigationController pushViewController:gestureVc animated:YES];
            }else{
                //标题文本
                NSString *title = _dataSource[indexPath.section][indexPath.row];
                //内容文本
                NSString *subTitle = cell.detailTextLabel.text;
                LTSChangeInformationViewController *changeInfoVc = [[LTSChangeInformationViewController alloc] initWithNavTitle:[NSString stringWithFormat:@"修改%@",title] message:subTitle title:title];
                [self.navigationController pushViewController:changeInfoVc animated:YES];
                
            }
        }else if (indexPath.section == 0){
            //        if (indexPath.row == 0) {//修改头像
            //
            //        }else{
            
            //标题文本
            NSString *title = _dataSource[indexPath.section][indexPath.row];
            //内容文本
            NSString *subTitle = cell.detailTextLabel.text;
            LTSChangeInformationViewController *changeInfoVc = [[LTSChangeInformationViewController alloc] initWithNavTitle:[NSString stringWithFormat:@"修改%@",title] message:subTitle title:title];
            [self.navigationController pushViewController:changeInfoVc animated:YES];
            
            //        }
        }else{//修改文本信息
            //标题文本
            NSString *title = _dataSource[indexPath.section][indexPath.row];
            //内容文本
            NSString *subTitle = cell.detailTextLabel.text;
            LTSChangeInformationViewController *changeInfoVc = [[LTSChangeInformationViewController alloc] initWithNavTitle:[NSString stringWithFormat:@"修改%@",title] message:subTitle title:title];
            [self.navigationController pushViewController:changeInfoVc animated:YES];
        }

    }
    
}

//每行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
          return 44;
        }
    }
    return 44;
}

//组头高度
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    return 5;
}
//组尾高度
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
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
