//
//  LTSNewsAndNoticeDetailViewController.m
//  CMSP
//
//  Created by 刘刚 on 2017/6/1.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import "LTSNewsAndNoticeDetailViewController.h"

@interface LTSNewsAndNoticeDetailViewController ()
@property (nonatomic,strong) UIButton *backBtn;
@end

@implementation LTSNewsAndNoticeDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = YES;
    self.navigationController.navigationBar.hidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.naviTitle;
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

-(void)initUI{
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_W, SCREEN_H - 64)];
    scrollView.backgroundColor = HexColor(@"#f6f6f8");
    [self.view addSubview:scrollView];
    
    //标题
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//    titleLabel.backgroundColor  = [UIColor greenColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.text = self.detailTitle;
    [scrollView addSubview:titleLabel];
    //不限制行数
    titleLabel.numberOfLines = 0;
    CGRect rect = [self.detailTitle boundingRectWithSize:CGSizeMake(SCREEN_W -10*2,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleLabel.font} context:nil];
    NSLog(@"------%f",rect.size.width);
    //自适应使用masonry的时候，不能写高度
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo((SCREEN_W - rect.size.width)*0.5);
        make.width.mas_equalTo(rect.size.width);
    }];

    
    
    //发布时间
    UILabel *dateLabel = [[UILabel alloc] init];
//    dateLabel.backgroundColor = [UIColor redColor];
    dateLabel.font = [UIFont systemFontOfSize:15];
    dateLabel.textColor = HexColor(@"#949496");
    //切割日期后边的不必要字符串
    NSRange range = [self.detailDate rangeOfString:@" 00:00:00.0"];
    dateLabel.text = [self.detailDate substringToIndex:range.location];
    
    [scrollView addSubview:dateLabel];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(10);
        make.left.mas_equalTo((SCREEN_W - rect.size.width)*0.5);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(15);
    }];
    
    //发布人
    UILabel *userLabel = [[UILabel alloc] init];
//    userLabel.backgroundColor = [UIColor greenColor];
    userLabel.font = [UIFont systemFontOfSize:15];
    userLabel.textColor = HexColor(@"#949496");
    userLabel.textAlignment = NSTextAlignmentRight;
    userLabel.text = self.detailPubUser;
    [scrollView addSubview:userLabel];
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(10);
        make.right.mas_equalTo(self.view).with.offset(-(SCREEN_W - rect.size.width)*0.5);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(15);
    }];
    
    
    //发布内容
    UILabel * contextLabel = [[UILabel alloc] init];
//    contextLabel.backgroundColor = [UIColor redColor];
    contextLabel.font = [UIFont systemFontOfSize:18];
    contextLabel.textColor = HexColor(@"#515153");
//    contextLabel.text = self.detailContext;
    [scrollView addSubview:contextLabel];
    //设置行数不限制
    contextLabel.numberOfLines = 0;
    //换行模式
    contextLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    //属性字符串来设置行间距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.detailContext];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];
    [paragraphStyle setParagraphSpacing:15];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.detailContext length])];
    [contextLabel setAttributedText:attributedString];

    //文字自适应尺寸
    CGRect rectOfContext = [attributedString.string boundingRectWithSize:CGSizeMake(SCREEN_W- 10*2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:contextLabel.font,NSParagraphStyleAttributeName:paragraphStyle} context:nil];
    
    [contextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(userLabel.mas_bottom).with.offset(10);
        make.left.mas_equalTo((SCREEN_W - rectOfContext.size.width)*0.5);
        make.width.mas_equalTo(rectOfContext.size.width);

    }];
    
    scrollView.contentSize = CGSizeMake(0, 10*4 + rect.size.height+ dateLabel.bounds.size.height + rectOfContext.size.height );

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
