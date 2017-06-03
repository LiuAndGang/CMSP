//
//  LTSMoreNoticeViewController.m
//  CMSP
//
//  Created by 刘刚 on 2017/5/31.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import "LTSMoreNoticeViewController.h"
#import "LTSCompanyNewsCell.h"
#import "LTSNewsAndNoticeModel.h"
#import "LTSNewsAndNoticeDetailViewController.h"
@interface LTSMoreNoticeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *backBtn;
//页
@property(nonatomic,assign)NSInteger page;
//行
@property(nonatomic,assign)NSInteger rows;

@property (nonatomic,strong) NSMutableArray *noticeDatas;
@end

@implementation LTSMoreNoticeViewController

-(NSMutableArray *)noticeDatas{
    if (!_noticeDatas) {
        _noticeDatas = [NSMutableArray array];
    }
    return _noticeDatas;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"公告";
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

-(void)initData{
    _page = 0;
    _rows = 4;
    //公告数据
    [LTSDBManager POST:[kLTSDBBaseUrl stringByAppendingString:KLTSDBNewsAndNotice] params:@{@"type":@"C",@"page":[NSNumber numberWithInteger:_page],@"rows":[NSNumber numberWithInteger:_rows]} block:^(id responseObject, NSError *error) {
        if(responseObject) {
            //            NSLog(@"responseObject:%@",responseObject);
            NSArray *tempArray = responseObject[@"rows"];
            for (NSDictionary *dict in tempArray) {
                LTSNewsAndNoticeModel *model = [LTSNewsAndNoticeModel modelWithDict:dict];
                [self.noticeDatas addObject:model];
                
            }
            [_tableView reloadData];

            NSLog(@"noticeData数组数量：%ld",self.noticeDatas.count);
        }else{
            NSLog(@"error:%@",error);
        }
    }];

}

-(void)initUI{

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H-64) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    //自动调整滚动视图适配view设置，默认为YES
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    //分割线风格
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    //隐藏多余的cell分割线
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    //注册cell
    [_tableView registerClass:[LTSCompanyNewsCell class] forCellReuseIdentifier:@"cell"];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.noticeDatas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LTSCompanyNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    //模型赋值
    cell.model = self.noticeDatas[indexPath.row];
    
    return cell;
}

//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //取消反选
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LTSNewsAndNoticeDetailViewController *detailVc = [LTSNewsAndNoticeDetailViewController new];
    LTSNewsAndNoticeModel *model = _noticeDatas[indexPath.row];
    detailVc.detailTitle = model.mainTitle;
    detailVc.detailContext = model.context;
    detailVc.detailDate = model.publicDate;
    detailVc.detailPubUser = model.publicUserName;
    detailVc.naviTitle = @"公告详情";
    [self.navigationController pushViewController:detailVc animated:YES];
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
