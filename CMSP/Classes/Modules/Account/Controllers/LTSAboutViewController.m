//
//  LTSAboutViewController.m
//  CMSP
//
//  Created by 李棠松 on 2016/12/8.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#import "LTSAboutViewController.h"
#import "LTSBaseWebViewControlle.h"
#import "LTSCompanyIntroduceViewController.h"
@interface LTSAboutViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *tableView;
/**数据源*/
@property (nonatomic,strong) NSArray *dataSource;
@property (nonatomic,strong) UIButton *backBtn;


@end

@implementation LTSAboutViewController
//隐藏tabBar
-(void)viewWillAppear:(BOOL)animated
{   [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"关于";
    // Do any additional setup after loading the view.
}
-(void)initData
{
    _dataSource = @[@"公司介绍",@"版本检测",@"客服热线"];
}


- (void)initUI{
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"about.jpg"]];
    imageView.contentMode = UIViewContentModeCenter;
    [self.view addSubview:imageView];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(240*Scale);
    }];
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain] ;
    _tableView.backgroundColor = BGColorGray;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableView.rowHeight = 44;
    _tableView.sectionHeaderHeight = 8;
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.top.mas_equalTo(imageView.mas_bottom).with.offset(0);
    }];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //隐藏多余的cell分割线
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];

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
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell标题
    cell.textLabel.text = _dataSource[indexPath.row];
    cell.textLabel.textColor = HexColor(@"#676769");
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    if ([cell.textLabel.text isEqualToString:@"客服热线"]) {
        cell.detailTextLabel.text = @"020-83063218";
        cell.detailTextLabel.textColor = HexColor(@"#00b0ec");
    }
    if ([cell.textLabel.text isEqualToString:@"版本检测"]) {
        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        cell.detailTextLabel.text = infoDictionary[@"CFBundleShortVersionString"];
        [LTSUserDefault setObject:infoDictionary[@"CFBundleShortVersionString"] forKey:@"CFBundleShortVersionString"];
    }
    return cell;
}

//每行的高度
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

//cell点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell.textLabel.text isEqualToString:@"客服热线"]) {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"020-83063218"];
        UIWebView * callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    
    }
    if ([cell.textLabel.text isEqualToString:@"公司介绍"]) {
        LTSCompanyIntroduceViewController *companyVc = [LTSCompanyIntroduceViewController new];
        companyVc.stringHtml =[kLTSDBBaseUrl stringByAppendingString:KLTSDBComponyIntro];
        [self.navigationController pushViewController:companyVc animated:YES];
    }
    if ([cell.textLabel.text isEqualToString:@"版本检测"]) {
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
                        
                        UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:@"提示" message:@"发现新版本，是否前往更新?" preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            NSString *urlString = @"https://itunes.apple.com/cn/app/客户营销系统/id1229576389?mt=8";
                            NSString *encodString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
                            
                            NSURL *url = [NSURL URLWithString:encodString];
                            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                               [[UIApplication sharedApplication] openURL:url];
                            }
                            
                            
                        }];
                        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            
                        }];
                        [alertVc addAction:sure];
                        [alertVc addAction:cancel];
                        [self presentViewController:alertVc animated:YES completion:nil];
                        
                        
                        
//                        NSLog(@"Appstore：%ld",storeVersion.integerValue);
//                        NSLog(@"currentVersion：%ld", currentVersion.integerValue);
                        
                    }else{
//                        NSLog(@"currentVersion：%ld", currentVersion.integerValue);
                        
                        [ActivityHub ShowHub:@"当前已是最新版本"];
                    }

                }
            }
        }];
    }
    
};

//- (void)addTableViewGroup1{
//    SettingGroup *group = [self.tableView addGroup];
//    SettingItem *item1 = [SettingArrowItem itemWithTitle:@"公司介绍"];
//    item1.operation = ^(id data){
//        
//    };
//
//    
//    SettingItem *item2 = [SettingArrowItem itemWithTitle:@"版本检测"];
//    item2.operation = ^(id data){
//        
//    };
//    
//    SettingItem *item3 = [SettingArrowItem itemWithTitle:@"客户热线"];
//    item3.subtitle = @"020-55555534";
//    item3.subtitleColor = HexColor(@"#00b0ec");
//    item3.operation = ^(id data){
//        
//    };
//    group.items  = @[item1,item2,item3];
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
