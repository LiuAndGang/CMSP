//
//  LTSNewsAndNoticeDetailViewController.m
//  CMSP
//
//  Created by 刘刚 on 2017/6/1.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import "LTSNewsAndNoticeDetailViewController.h"
//#import "CoreText/CoreText.h"
#import "UILabel+Alignment.h"
#import "UIImageView+WebCache.h"

@interface LTSNewsAndNoticeDetailViewController ()
@property (nonatomic,strong) UIButton *backBtn;
/**大图*/
@property (nonatomic,strong) UIImageView *bigImageView;
/**大图的自适应高度*/
@property (nonatomic,assign) CGFloat bigImageHeight;
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
    //换行模式 --- 以字符为单位换行
    titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    //不限制行数
    titleLabel.numberOfLines = 0;
    CGRect rect = [self.detailTitle boundingRectWithSize:CGSizeMake(SCREEN_W -10*2,CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:titleLabel.font} context:nil];
//    NSLog(@"------%f",rect.size.width);
    //自适应使用masonry的时候，不能写高度
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo((SCREEN_W - rect.size.width)*0.5);
        make.width.mas_equalTo(rect.size.width);
    }];

    
    
    //来源
    UILabel *fromLabel = [[UILabel alloc] init];
//    dateLabel.backgroundColor = [UIColor redColor];
    fromLabel.font = [UIFont systemFontOfSize:15];
    fromLabel.textColor = HexColor(@"#949496");
    fromLabel.text = [NSString stringWithFormat:@"来源:%@",@""];
    [scrollView addSubview:fromLabel];
    [fromLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(10);
        make.left.mas_equalTo((SCREEN_W - rect.size.width)*0.5);
        make.height.mas_equalTo(20);
    }];
    
    //发布人
    UILabel *userLabel = [[UILabel alloc] init];
//    userLabel.backgroundColor = [UIColor greenColor];
    userLabel.font = [UIFont systemFontOfSize:15];
    userLabel.textColor = HexColor(@"#949496");
    userLabel.textAlignment = NSTextAlignmentRight;
    //切割日期后边的不必要字符串
    NSRange range = [self.detailDate rangeOfString:@" 00:00:00.0"];
    userLabel.text = [self.detailDate substringToIndex:range.location];
    
    [scrollView addSubview:userLabel];
    [userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(10);
        make.right.mas_equalTo(self.view).with.offset(-(SCREEN_W - rect.size.width)*0.5);
        make.height.mas_equalTo(20);

    }];
    
    if (!self.tap) {//如果tap为真，则说明是公告页面传过来的数据，则不创建大图UI
        //新闻或公告大图
        UIImageView *bigImageView = [[UIImageView alloc] init];
        self.bigImageView = bigImageView;
        bigImageView.backgroundColor = [UIColor greenColor];
        [scrollView addSubview:bigImageView];
        
        //获取网络图片的真实大小
//        __block CGFloat bigImageHeight = 0;
        self.bigImageHeight = 0;
        [bigImageView sd_setImageWithURL:[NSURL URLWithString:self.imageString] placeholderImage:[UIImage imageNamed:@"newspic"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
            CGSize size = image.size;
            self.bigImageHeight = size.height;
        }];
        
        //获取占位图的大小
        //    CGSize localImageSize = [UIImage imageNamed:@"newspic"].size;
        
        [bigImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(fromLabel.mas_bottom).with.offset(10);
            make.left.mas_equalTo(10);
            make.width.mas_equalTo(SCREEN_W - 20);
        }];
 
    }
    
    
    //发布内容
    UILabel * contextLabel = [[UILabel alloc] init];
//    contextLabel.backgroundColor = [UIColor redColor];
    contextLabel.font = [UIFont systemFontOfSize:18];
    contextLabel.textColor = HexColor(@"#515153");
    [scrollView addSubview:contextLabel];
    //设置行数不限制
    contextLabel.numberOfLines = 0;
    //换行模式 --- 以字符为单位换行
    contextLabel.lineBreakMode = NSLineBreakByCharWrapping;
    
    //属性字符串来设置行间距
//    NSLog(@"--------self.detailContext----------%@",self.detailContext);

    
    NSString *detailContext = [self.detailContext stringByReplacingOccurrencesOfString:@" 粤担函[2016]36号\r\n 关于印发《广东省企业债券省级风险缓释基金使用管理办法》的通知\r\n " withString:@"粤担函[2016]36号关于印发《广东省企业债券省级 "];
    
//    NSLog(@"--------detailContext----------%@",detailContext);
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:detailContext];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:8];
    [paragraphStyle setParagraphSpacing:15];
    //设置文本两端对齐
    paragraphStyle.alignment = NSTextAlignmentJustified;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [detailContext length])];

    
    //设置字间距
//    long number = 1.5f;
//    //CFNumberRef添加字间距
//    CFNumberRef num = CFNumberCreate(kCFAllocatorDefault,kCFNumberSInt8Type,&number);    [attributedString addAttribute:(id)kCTKernAttributeName value:(__bridge id)num range:NSMakeRange(0,[attributedString length])];
//    //清除CFNumberRef
//    CFRelease(num);
    
    //文字自适应尺寸
    CGRect rectOfContext = [attributedString.string boundingRectWithSize:CGSizeMake(SCREEN_W- 15*2, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:contextLabel.font,NSParagraphStyleAttributeName:paragraphStyle} context:nil];
    
    [contextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (!self.tap) {
            make.top.mas_equalTo(self.bigImageView.mas_bottom).with.offset(10);
        
        }else{//如果tap为真，说明为公告详情页，则隐藏大图，改变控件约束
            make.top.mas_equalTo(userLabel.mas_bottom).with.offset(10);

        }
        
        make.left.mas_equalTo((SCREEN_W - rectOfContext.size.width)*0.5);
        make.width.mas_equalTo(rectOfContext.size.width);
       
    }];
    
    
    //设置字间距
    CGFloat margin = (SCREEN_W - rectOfContext.size.width) / (contextLabel.text.length - 1);
    //    CGFloat margin = 5;
    NSNumber *number = [NSNumber numberWithFloat:margin];
    [attributedString addAttribute:NSKernAttributeName value:number range:NSMakeRange(0, contextLabel.text.length)];
    [contextLabel setAttributedText:attributedString];

    
    
//    if (![self.imageString isEqualToString:@""]) {
        scrollView.contentSize = CGSizeMake(0, 10*5 + rect.size.height+ fromLabel.bounds.size.height + rectOfContext.size.height + self.bigImageHeight);
//    }else{
//        scrollView.contentSize = CGSizeMake(0, 10*5 + rect.size.height+ fromLabel.bounds.size.height + rectOfContext.size.height + localImageSize.height);
//
//    }
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
