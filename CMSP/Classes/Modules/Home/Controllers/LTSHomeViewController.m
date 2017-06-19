//
//  LTSHomeViewController.m
//  CMSP
//
//  Created by 李棠松 on 2016/12/1.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#import "LTSHomeViewController.h"
#import "LTSBaseWebViewControlle.h"
#import "SDCycleScrollView.h"
#import "LTSCompanyNewsCell.h"
#import "LTSNewsAndNoticeModel.h"
#import "LTSMessageModel.h"
#import "LTSMoreNoticeViewController.h"
#import "LTSMoreNewsViewController.h"
#import "LTSMoreMessageViewController.h"
#import "LTSNewsAndNoticeDetailViewController.h"
#define CycleScrollViewHeight (Screen_Width * (204 / 375.0))
@interface LTSHomeViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;
/*业务介绍*/
@property (nonatomic,strong)UIButton *businessBtn;
/**经典案例*/
@property (nonatomic,strong)UIButton *exampleBtn;
/**表格*/
@property (nonatomic,strong) UITableView *tableView;
/**公告内容label*/
@property (nonatomic,strong) UILabel *noticeContentLabel;
/**消息内容label*/
@property (nonatomic,strong) UILabel *messageContentLabel;
//页
@property(nonatomic,assign)NSInteger page;
//行
@property(nonatomic,assign)NSInteger rows;
/**公告数据数组*/
@property (nonatomic,strong) NSMutableArray *noticeDatas;
/**新闻数据数组*/
@property (nonatomic,strong) NSMutableArray *newsDatas;
/**消息数据数组*/
@property (nonatomic,strong) NSMutableArray *messageDatas;

@end

@implementation LTSHomeViewController

-(NSMutableArray *)noticeDatas
{
    if (!_noticeDatas) {
        _noticeDatas  = [[NSMutableArray alloc] init];
    }
    return _noticeDatas;
}
-(NSMutableArray *)newsDatas
{
    if (!_newsDatas) {
        _newsDatas  = [[NSMutableArray alloc] init];
    }
    return _newsDatas;
}
-(NSMutableArray *)messageDatas
{
    if (!_messageDatas) {
        _messageDatas  = [[NSMutableArray alloc] init];
    }
    return _messageDatas;
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = NO;
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//       [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
//        @strongify(self)
//        LTSBaseWebViewControlle *webView = [LTSBaseWebViewControlle new];
//        webView.url = [NSURL URLWithString:@"http://192.168.55.37:8080/accountPlatform/account/front/main/home.jsp"];
//        [self.navigationController pushViewController:webView animated:YES];
//
//    }];
        // Do any additional setup after loading the view.
    
    
    
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
            LTSNewsAndNoticeModel *model = _noticeDatas[0];
            //去掉左右两边的空格和换行符
            _noticeContentLabel.text = [model.mainTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//            _noticeContentLabel.text = [model.mainTitle stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];

            NSLog(@"noticeData数组数量：%ld",self.noticeDatas.count);
        }else{
            NSLog(@"error:%@",error);
        }
    }];
    
    //新闻数据
    [LTSDBManager POST:[kLTSDBBaseUrl stringByAppendingString:KLTSDBNewsAndNotice] params:@{@"type":@"N",@"page":[NSNumber numberWithInteger:_page],@"rows":[NSNumber numberWithInteger:_rows]} block:^(id responseObject, NSError *error) {
        if(responseObject) {
//            NSLog(@"responseObject:%@",responseObject);
            NSArray *tempArray = responseObject[@"rows"];
            for (NSDictionary *dict in tempArray) {
                LTSNewsAndNoticeModel *model = [LTSNewsAndNoticeModel modelWithDict:dict];
                
                [self.newsDatas addObject:model];
                
                
            }
            [_tableView reloadData];
            NSLog(@"newsDatas数组数量：%ld",self.newsDatas.count);
        }else{
            NSLog(@"error:%@",error);
        }
    }];
    
    //消息数据
    if (![[LTSUserDefault objectForKey:@"organ_flag"] isEqual:@0] && [LTSUserDefault objectForKey:Login_Token]) {
       
//        [LTSDBManager POST:[kLTSDBBaseUrl stringByAppendingString:KLTSDBMessage] params:@{@"cif_account":[LTSUserDefault objectForKey:@"cif_account"]} block:^(id responseObject, NSError *error) {
//            NSLog(@"-----------------%@",responseObject);
//            NSArray *tempArray = responseObject[@"row"];
//            for (NSDictionary *dict in tempArray) {
//                LTSMessageModel *model = [LTSMessageModel modelWithDict:dict];
//                [self.messageDatas addObject:model];
//            }
//            NSLog(@"messageData数组数量：%ld",self.messageDatas.count);
//            //去掉左右两边的空格和换行符
//            LTSMessageModel *model = _messageDatas[0];
//            _messageContentLabel.text = [model.messageTitle stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//        }];

    }

}

- (void)initUI{
//    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
//    [self.view addSubview:self.scrollView];
    
    UIView *baseView = [[UIView alloc] init];
    baseView.backgroundColor = lineBGColor;
    baseView.frame = CGRectMake(0, 0, SCREEN_W, CycleScrollViewHeight+44+10*3+100+44*2);
    [self.view addSubview:baseView];
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Screen_Width, CycleScrollViewHeight) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    [baseView addSubview:cycleScrollView];
    cycleScrollView.localizationImageNamesGroup = @[@"home_pic_1.jpg",@"home_pic_2.jpg",@"home_pic_3.jpg",@"home_pic_4.jpg"];
    self.cycleScrollView = cycleScrollView;
    
    
    self.businessBtn = ({UIButton *button = [UIButton new];
        [button setTitle:@"业务介绍" forState:UIControlStateNormal];
        [button setTitleColor:DarkText forState:UIControlStateNormal];
        button.titleLabel.font =[UIFont systemFontOfSize:16];
        [baseView addSubview:button];
        button.backgroundColor = [UIColor whiteColor];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.mas_equalTo(self.cycleScrollView.mas_bottom).with.offset(0);
            make.width.mas_equalTo(Screen_Width/2);
            make.height.mas_equalTo(44);
        }];
        button;
    });
    
    self.exampleBtn = ({UIButton *button = [UIButton new];
        [button setTitle:@"经典案例" forState:UIControlStateNormal];
        [button setTitleColor:DarkText forState:UIControlStateNormal];
        button.titleLabel.font =[UIFont systemFontOfSize:16];
        [baseView addSubview:button];
        button.backgroundColor = [UIColor whiteColor];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(self.cycleScrollView.mas_bottom).with.offset(0);
            make.width.mas_equalTo(Screen_Width/2);
            make.height.mas_equalTo(44);
        }];
        button;
    });
    
    
    //业务介绍和经典案例中间那条线
    {
        UIView *line = [UIView new];
        line.backgroundColor = lineBGColor;
        [baseView addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(baseView.mas_centerX);
            make.top.mas_equalTo(self.cycleScrollView.mas_bottom).with.offset(0);
            make.width.mas_equalTo(1);
            make.height.mas_equalTo(44);
        }];
    }
    
    
    NSArray *images = @[@"icon_zaidanbao",@"icon_zhibaorz",@"icon_zhibaofrz",@"icon_danbaotixi"];
    NSArray *titles = @[@"再担保",@"直保融资",@"直保非融资",@"担保体系"];
    NSArray *urls = @[@"R",@"F",@"N",@""];
    
    UIView *contentView = [UIView new];
    [baseView addSubview:contentView];
    contentView.backgroundColor = [UIColor whiteColor];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.businessBtn.mas_bottom).with.offset(10);
        make.right.left.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    
    for (NSInteger i = 0; i<4; i++) {
        UIButton *button = [UIButton new];
        button.frame = CGRectMake(Screen_Width/4 * i, 0, Screen_Width/4, 100);
        [button setImage:[UIImage imageNamed:images[i]] forState:UIControlStateNormal];
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:LightDarkText forState:UIControlStateNormal];
        [contentView addSubview:button];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button verticalImageAndTitle:10];
        @weakify(self)
        [[button rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self)
            
            NSURL *url = [NSURL URLWithString:[[[kLTSDBBaseUrl stringByAppendingString:kLTSDBCoreBusiness] stringByAppendingFormat:@"?productCode=%@",urls[i]] stringByAppendingFormat:@"&cif_account=%@",[LTSUserDefault objectForKey:@"cif_account"]]];
            LTSBaseWebViewControlle *webView = [LTSBaseWebViewControlle new];
            webView.url = url;

            if (i == 3) {
                NSURL *url = [NSURL URLWithString:[kLTSDBBaseUrl stringByAppendingString:kLTSDBCoreBusiness]];
                webView.url = url;

            }
            [self.navigationController pushViewController:webView animated:YES];
            
        }];
        
        if (i!=3) {
            UIView *line = [UIView new];
            line.backgroundColor = lineBGColor;
            [contentView addSubview:line];
            line.frame = CGRectMake(Screen_Width/4 * (i+1), 0, 0.5, 100);
            
        }
    }
    
    //公告
    UIView *noticeView = [[UIView alloc] init];
    noticeView.backgroundColor = [UIColor whiteColor];
    [baseView addSubview:noticeView];
    [noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(contentView.mas_bottom).with.offset(10);
        make.width.mas_equalTo(SCREEN_W);
        make.height.mas_equalTo(44);
    }];
    UIImageView *noticeImageView = [[UIImageView alloc] init];
    noticeImageView.image = [UIImage imageNamed:@"icon_notice"];
    [noticeView addSubview:noticeImageView];
    [noticeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(noticeView);
        make.left.mas_equalTo(noticeView).with.offset(12);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    UIImageView *arrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_more"]];
    [noticeView addSubview:arrowImage];
    [arrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(noticeView).with.offset(-10);
        make.centerY.mas_equalTo(noticeView);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    UILabel *noticeContentLabel = [[UILabel alloc] init];
    self.noticeContentLabel = noticeContentLabel;
    [noticeView addSubview:noticeContentLabel];
    noticeContentLabel.backgroundColor = [UIColor whiteColor];
    noticeContentLabel.textAlignment = NSTextAlignmentCenter;
    noticeContentLabel.textColor = HexColor(@"#333333");
    noticeContentLabel.font = [UIFont systemFontOfSize:14];
    [noticeContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(noticeView);
        make.height.mas_equalTo(noticeView);
        make.left.mas_equalTo(noticeImageView.mas_right).with.offset(7);
        make.right.mas_equalTo(arrowImage.mas_left);
    }];
    //公告手势
    UITapGestureRecognizer *noticeTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(noticeTap:)];
    noticeTap.numberOfTapsRequired = 1;
    noticeTap.numberOfTouchesRequired = 1;
    [noticeView addGestureRecognizer:noticeTap];
    
    
    //公告和消息中间那条线
    {
        UIView *line2 = [UIView new];
        line2.backgroundColor = lineBGColor;
        [baseView addSubview:line2];
        [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(noticeView.mas_bottom).with.offset(0);
            make.width.mas_equalTo(SCREEN_W);
            make.height.mas_equalTo(1);
        }];
    }
    
    //消息
    UIView *messageView = [[UIView alloc] init];
    messageView.backgroundColor = [UIColor whiteColor];
    [baseView addSubview:messageView];
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(noticeView.mas_bottom).with.offset(0.8);
        make.width.mas_equalTo(SCREEN_W);
        make.height.mas_equalTo(44);
    }];
    UIImageView *messageImageView = [[UIImageView alloc] init];
    messageImageView.image = [UIImage imageNamed:@"icon_message"];
    [messageView addSubview:messageImageView];
    [messageImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(messageView);
        make.left.mas_equalTo(messageView).with.offset(12);
        make.width.mas_equalTo(25);
        make.height.mas_equalTo(25);
    }];
    UIImageView *messageArrowImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_more"]];
    [messageView addSubview:messageArrowImage];
    [messageArrowImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(messageView).with.offset(-10);
        make.centerY.mas_equalTo(messageView);
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
    }];
    UILabel *messageContentLabel = [[UILabel alloc] init];
    self.messageContentLabel = messageContentLabel;
    [messageView addSubview:messageContentLabel];
    messageContentLabel.backgroundColor = [UIColor whiteColor];
    messageContentLabel.textAlignment = NSTextAlignmentCenter;
    messageContentLabel.textColor = HexColor(@"#333333");
    messageContentLabel.font = [UIFont systemFontOfSize:14];
    [messageContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(messageView);
        make.height.mas_equalTo(messageView);
        make.left.mas_equalTo(messageImageView.mas_right).with.offset(7);
        make.right.mas_equalTo(messageArrowImage.mas_left);
    }];
    //消息手势
    UITapGestureRecognizer *messageTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(messageTap:)];
    messageTap.numberOfTapsRequired = 1;
    messageTap.numberOfTouchesRequired = 1;
    [messageView addGestureRecognizer:messageTap];

    //个人登录和随便看看隐藏 消息 控件
//    if ([[LTSUserDefault objectForKey:@"organ_flag"] isEqual:@0] || ![LTSUserDefault objectForKey:Login_Token]) {
        [messageView removeFromSuperview];
        baseView.frame = CGRectMake(0, 0, SCREEN_W, CycleScrollViewHeight+44+10*3+100+44*1);

//    }
    
    
    //公司新闻
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H- 44) style:UITableViewStyleGrouped];
    //自动调整滚动视图适配view设置，默认为YES
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = baseView;
    _tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tableView];
//    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.view);
//        make.width.mas_equalTo(self.view);
//        make.height.mas_equalTo(SCREEN_H);
//    }];
    //注册表格
    [_tableView registerClass:[LTSCompanyNewsCell class] forCellReuseIdentifier:@"newsCell"];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"cell数：%ld",self.newsDatas.count);
    return self.newsDatas.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *ident = @"newsCell";
    LTSCompanyNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:ident forIndexPath:indexPath];
    //模型赋值
    LTSNewsAndNoticeModel *model = _newsDatas[indexPath.row];
    cell.model = model;

    return cell;
}
//行高
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 86;
}


//组头
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, 30)];
    
    UILabel *headerLabel = [[UILabel alloc] init];
    headerLabel.text = @"公司新闻";
    headerLabel.font = [UIFont systemFontOfSize:16];
    headerLabel.backgroundColor = [UIColor whiteColor];
    [headerView addSubview:headerLabel];
    [headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView);
        make.left.mas_equalTo(headerView).with.offset(10);
        make.height.mas_equalTo(headerView);
        make.width.mas_equalTo(100);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.backgroundColor = [UIColor grayColor];
    [headerView addSubview:imageView];
    imageView.image = [UIImage imageNamed:@"more"];
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(headerView);
        make.right.mas_equalTo(headerView.mas_right).with.offset(-10);
        make.width.height.mas_equalTo(30);
    }];
    //获取更多新闻手势
    UITapGestureRecognizer *moreNewsTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(moreNewsTap:)];
    moreNewsTap.numberOfTapsRequired = 1;
    moreNewsTap.numberOfTouchesRequired = 1;
    [headerView addGestureRecognizer:moreNewsTap];
    imageView.userInteractionEnabled = YES;
    
    return headerView;
}
//组头高度(一定要实现这个方法，设置的组头才能显示出来)
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
//设置组尾高度为 -CGFLOAT_MIN,以此来取消组头，设置为0不管用
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10.0;
}

-(void)noticeTap:(UITapGestureRecognizer *)tap{
    NSLog(@"点击了公告");
    LTSMoreNoticeViewController *moreNoticeVc = [LTSMoreNoticeViewController new];
    [self.navigationController pushViewController:moreNoticeVc animated:YES];
}

-(void)messageTap:(UITapGestureRecognizer *)tap{
    NSLog(@"点击了消息");
}

-(void)moreNewsTap:(UITapGestureRecognizer *)tap{
    NSLog(@"点击了获取更多新闻");
    LTSMoreNewsViewController *newsVc = [LTSMoreNewsViewController new];
    [self.navigationController pushViewController:newsVc animated:YES];

}
//点击了cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    LTSNewsAndNoticeDetailViewController *detailVc = [LTSNewsAndNoticeDetailViewController new];
    LTSNewsAndNoticeModel *model = _newsDatas[indexPath.row];
    detailVc.detailTitle = model.mainTitle;
    detailVc.detailContext = model.context;
    detailVc.detailDate = model.publicDate;
    detailVc.detailPubUser = model.publicUserName;
    detailVc.imageString  = model.imageString;
    detailVc.naviTitle = @"新闻详情";
    [self.navigationController pushViewController:detailVc animated:YES];
}



//业务介绍按钮点击事件
- (void)addEvents{
    @weakify(self)
    [[self.businessBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        LTSBaseWebViewControlle *webView = [LTSBaseWebViewControlle new];
        webView.url = [NSURL URLWithString:[[kLTSDBBaseUrl stringByAppendingString:kLTSDBBusinessIntroduction] stringByAppendingFormat:@"?cif_account=%@",[LTSUserDefault objectForKey:@"cif_account"]]];
        [self.navigationController pushViewController:webView animated:YES];
    }];
    
    [[self.exampleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        LTSBaseWebViewControlle *webView = [LTSBaseWebViewControlle new];
        webView.url = [NSURL URLWithString:[[kLTSDBBaseUrl stringByAppendingString:kLTSDBClassicCase] stringByAppendingFormat:@"?cif_account=%@",[LTSUserDefault objectForKey:@"cif_account"]]];
        [self.navigationController pushViewController:webView animated:YES];
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
