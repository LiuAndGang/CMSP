//
//  LTSAccountViewController.m
//  CMSP
//
//  Created by 李棠松 on 2016/12/1.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#import "LTSAccountViewController.h"
#import "LTSUserInfoViewController.h"
#import "LTSAboutViewController.h"
#import "LTSLoginViewController.h"
#import "CleanCache.h"
#import "LTSBaseWebViewControlle.h"
#import "LTSLogTypeTransition.h"
#import "LTSPassWordViewController.h"
@interface LTSAccountViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UIImageView *headerImage;

@property (nonatomic,strong)UIImageView *login;

@property (nonatomic,strong)UIButton *messgaeButton;

@property (nonatomic,strong)UITableView *tableView;

@property (nonatomic,strong)UILabel *nameLabel;

/**数据源*/
@property (nonatomic,strong) NSArray *dataSource;
/**cell图标*/
@property (nonatomic,strong) NSArray *images;
/**缓存*/
@property (nonatomic ,strong) CleanCache *cleancache;

/**用户信息字典*/
@property (nonatomic,strong) NSMutableDictionary *userInfoDic;
/**App Store版本是否大于当前版本   11--有新版本   22--没有新版本*/
@property (nonatomic,assign) int versionData;
/**App Store版本号*/
@property (nonatomic,copy) NSString *storeVersion;



@end

@implementation LTSAccountViewController

-(NSMutableDictionary *)userInfoDic{
    if (!_userInfoDic) {
        _userInfoDic = [[NSMutableDictionary alloc] init];
    }
    return _userInfoDic;
}

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initUI];
    [self initData];
    _cleancache = [[CleanCache alloc] init];
}
-(void)initData
{
    //@[@"我的粤财币",@"我的资产"]
    _dataSource = @[@"修改密码",@"清除缓存",@"服务协议",@"关于"];
//    @[@"icon_goldcoin",@"icon_property"]
    _images =  @[@"updatePw",@"icon_checkUpdate",@"icon_declare",@"icon_about"];
    //缓存对象
    _cleancache = [[CleanCache alloc] init];
    

    //转换登录用户类型
//    NSString *login_user_type = [LTSLogTypeTransition logTypeTransition];

    
    
    //拉去App Store的版本号和本地版本号对比
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    [LTSUserDefault setObject:infoDictionary[@"CFBundleShortVersionString"] forKey:@"CFBundleShortVersionString"];
    
    [LTSDBManager POST:@"https://itunes.apple.com/lookup?id=1229576389" params:nil block:^(id responseObject, NSError *error) {
        if (responseObject[@"results"]) {
            NSArray *array = responseObject[@"results"];
            
            if (array.count != 0) {
                NSDictionary *dict = array[0];
                //去掉“.”小数点进行版本比较
                NSString *storeVersion = [dict[@"version"] stringByReplacingOccurrencesOfString:@"." withString:@""];
                NSString *currentVersion = [[LTSUserDefault objectForKey:@"CFBundleShortVersionString"] stringByReplacingOccurrencesOfString:@"." withString:@""];
                //判断 当前版本号 和 App store版本号的大小
                if (storeVersion.integerValue > currentVersion.integerValue) {
                    self.versionData = 11;//
                    self.storeVersion = dict[@"version"];

                }else{
                    self.versionData = 22;
                    
                }
                
                [self.tableView reloadData];
            }
        }
    }];


}

- (void)initUI{
    //头部试图
    UIView *view = [UIView new];
    view.backgroundColor = OrangeColor;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(328/2);
    }];
    
    UIImageView *headerDefault =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine.jpg"]];
    [view addSubview:headerDefault];
    [headerDefault mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(328/2);

    }];
    self.headerImage = headerDefault;
    headerDefault.userInteractionEnabled = YES;
    //给背景图添加手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerImageTap)];
    [self.headerImage addGestureRecognizer:tap];
    
    
    
    //消息按钮
//    self.messgaeButton = ({UIButton *button = [UIButton new];
//        [view addSubview:button];
//        [button setImage:[UIImage imageNamed:@"icon_nomessage"] forState:UIControlStateNormal];
//        
//        [button mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_equalTo(30);
//            make.right.mas_equalTo(-12);
//            
//        }];
//        
//        button;
//    });

    
    
    self.login = ({UIImageView *imageView = [UIImageView new];
        [headerDefault addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_equalTo(CGSizeMake(100, 68));
            make.center.mas_equalTo(CGPointMake(0, 0));
            
            }];
        imageView.image = [UIImage imageNamed:@"icon_default_head1"];
//        ViewRadius(imageView, 58/2.0);
        
        imageView;
    });
    
    
    self.nameLabel = ({UILabel *label = [UILabel new];
        [view addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        BOOL loginState = [LTSUserDefault boolForKey:KPath_UserLoginState];
        NSLog(@"%d",loginState);
        if ([LTSUserDefault objectForKey:@"real_name"] && loginState) {
            label.text = [LTSUserDefault objectForKey:@"real_name"];
        }else{
            label.text = @"登录/注册";
        }

        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(_login.mas_bottom).with.offset(10);
            make.height.mas_equalTo(15);
            make.centerX.mas_equalTo(view.mas_centerX);
        }];
        
        label;
    });
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped] ;
    _tableView.backgroundColor = BGColorGray;
//    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.rowHeight = 44;
//    _tableView.sectionHeaderHeight = 8;
    [self.view addSubview:_tableView];
    [_tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(328/2, 0, 0, 0));
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
}

//背景图点击手势
-(void)headerImageTap{
    if ([LTSUserDefault boolForKey:KPath_UserLoginState] ) {
        LTSUserInfoViewController *userInfo = [LTSUserInfoViewController new];
        [self.navigationController pushViewController:userInfo animated:YES];
    }else [self goLogin];

}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataSource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    
    //cell标题
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.textLabel.textColor = HexColor(@"#676769");
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    //cell左侧图标
    cell.imageView.image = [UIImage imageNamed:_images[indexPath.row]];
    if ([cell.textLabel.text isEqualToString:@"清除缓存"]) {
        
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fM",[_cleancache getCacheSizeAtPath:[_cleancache getCachesPath]]];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:15];

    }else if([cell.textLabel.text isEqualToString:@"关于"]){
        if (self.versionData == 11) {
            
            //添加小红点
            UIView *redView = [[UIView alloc] init];
            redView.backgroundColor = [UIColor redColor];
            [cell.contentView addSubview:redView];
            [redView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.mas_equalTo(10);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
                make.left.mas_equalTo(cell.contentView.mas_right).with.offset(-10);
            }];
            redView.layer.masksToBounds = YES;
            redView.layer.cornerRadius = 5;
        }

        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else{
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    }
    return cell;
}

//每行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
////组尾高度
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    return 5;
//}

//cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    //获取到当前点击的cell
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:@"我的粤财币"]) {
        LTSBaseWebViewControlle *detailVc = [LTSBaseWebViewControlle new];
        detailVc.url = [NSURL URLWithString:[kLTSDBBaseUrl stringByAppendingString:KLTSDBComponyIntro]];
        [self.navigationController pushViewController:detailVc animated:YES];

    }
    if ([cell.textLabel.text isEqualToString:@"我的资产"]) {
        LTSBaseWebViewControlle *detailVc = [LTSBaseWebViewControlle new];
        detailVc.url = [NSURL URLWithString:[kLTSDBBaseUrl stringByAppendingString:KLTSDBComponyIntro]];
        [self.navigationController pushViewController:detailVc animated:YES];

    }
    if ([cell.textLabel.text isEqualToString:@"修改密码"]) {
        LTSPassWordViewController *passWordVc = [LTSPassWordViewController new];
        [self.navigationController pushViewController:passWordVc animated:YES];
        
    }
    if ([cell.textLabel.text isEqualToString:@"清除缓存"]) {
        [CleanCache clearCacheAtPath:[_cleancache getCachesPath]];
        cell.detailTextLabel.text = [NSString stringWithFormat:@"%.2fM",[_cleancache getCacheSizeAtPath:[_cleancache getCachesPath]]];
        [ActivityHub ShowHub:KWork_cleanCacheSuccess];
    }
    if ([cell.textLabel.text isEqualToString:@"服务协议"]) {
        LTSBaseWebViewControlle *detailVc = [LTSBaseWebViewControlle new];
        detailVc.url = [NSURL URLWithString:[kLTSDBBaseUrl stringByAppendingString:KLTSDBDisclaimer]];
        [self.navigationController pushViewController:detailVc animated:YES];

    }
    if ([cell.textLabel.text isEqualToString:@"关于"]) {
        LTSAboutViewController *aboutVC = [LTSAboutViewController new];
        aboutVC.versionData = self.versionData;
        aboutVC.storeVersion = self.storeVersion;

      
        [self.navigationController pushViewController:aboutVC animated:YES];
    }

};

- (void)goLogin{
    LTSLoginViewController *loginVC = [LTSLoginViewController new];
    LTSBaseNavigationController *loginNavi = [[LTSBaseNavigationController alloc]initWithRootViewController:loginVC];

    
   
    [self presentViewController:loginNavi animated:YES completion:nil];
}
//- (void)addEvents{
//    @weakify(self)
//    UITapGestureRecognizer *tap = [UITapGestureRecognizer new];
//    [self.headerImage addGestureRecognizer:tap];
//    [[tap rac_gestureSignal] subscribeNext:^(id x) {
//        @strongify(self)
//        
//        if ([LTSUserDefault boolForKey:KPath_UserLoginState]) {
//            LTSUserInfoViewController *userInfo = [LTSUserInfoViewController new];
//            [self.navigationController pushViewController:userInfo animated:YES];
//        }else [self goLogin];
//        
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
