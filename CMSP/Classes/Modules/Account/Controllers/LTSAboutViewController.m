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

    
    
}
-(void)initData
{
    if (self.versionData == 11) {
        _dataSource = @[@"公司介绍",@"版本检测",@"客服热线"];

    }else{
        _dataSource = @[@"公司介绍",@"客服热线"];
    }
    

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
        cell.detailTextLabel.font = cell.textLabel.font;
    }
    if ([cell.textLabel.text isEqualToString:@"版本检测"]) {
       
        
        if (self.versionData == 11) {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"发现新版本%@",self.storeVersion];
            
            UIView *redView = [[UIView alloc] init];
            redView.backgroundColor = [UIColor redColor];
            [cell.contentView addSubview:redView];
            [redView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.height.mas_equalTo(10);
                make.centerY.mas_equalTo(cell.contentView.mas_centerY);
                make.left.mas_equalTo(cell.textLabel.mas_right).with.offset(10);
            }];
            redView.layer.masksToBounds = YES;
            redView.layer.cornerRadius = 5;

        }else if(self.versionData == 22){
            cell.detailTextLabel.text = [NSString stringWithFormat:@"已是最新版本%@",self.storeVersion];

        }

        cell.detailTextLabel.font = cell.textLabel.font;

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
        
        
        if (self.versionData == 11) {
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
        
        }else if (self.versionData == 22){
            [ActivityHub ShowHub:@"当前已是最新版本"];

        }

    }
    
};


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
