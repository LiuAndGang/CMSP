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

#define CycleScrollViewHeight (Screen_Width * (204 / 375.0))
@interface LTSHomeViewController ()<SDCycleScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,strong)SDCycleScrollView *cycleScrollView;
/*业务介绍*/
@property (nonatomic,strong)UIButton *businessBtn;
/**经典案例*/
@property (nonatomic,strong)UIButton *exampleBtn;
@end

@implementation LTSHomeViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.tabBarController.tabBar.hidden = NO;
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
- (void)initUI{
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.scrollView];
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, Screen_Width, CycleScrollViewHeight) delegate:self placeholderImage:[UIImage imageNamed:@""]];
    [self.view addSubview:cycleScrollView];
    cycleScrollView.localizationImageNamesGroup = @[@"home_pic_1.jpg",@"home_pic_2.jpg",@"home_pic_3.jpg",@"home_pic_4.jpg"];
    self.cycleScrollView = cycleScrollView;
    
    
    self.businessBtn = ({UIButton *button = [UIButton new];
        [button setTitle:@"业务介绍" forState:UIControlStateNormal];
        [button setTitleColor:DarkText forState:UIControlStateNormal];
        button.titleLabel.font =[UIFont systemFontOfSize:16];
        [self.view addSubview:button];
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
        [self.view addSubview:button];
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
        [self.view addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view.mas_centerX);
            make.top.mas_equalTo(self.cycleScrollView.mas_bottom).with.offset(0);
            make.width.mas_equalTo(0.5);
            make.height.mas_equalTo(44);
        }];
    }
    
    
    NSArray *images = @[@"icon_zaidanbao",@"icon_zhibaorz",@"icon_zhibaofrz",@"icon_danbaotixi"];
    NSArray *titles = @[@"再担保",@"直保融资",@"直保非融资",@"担保体系"];
    NSArray *urls = @[@"R",@"F",@"R",@""];
    
    UIView *contentView = [UIView new];
    [self.view addSubview:contentView];
    contentView.backgroundColor = [UIColor whiteColor];
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.businessBtn.mas_bottom).with.offset(15);
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
            
            NSURL *url = [NSURL URLWithString:[[kLTSDBBaseUrl stringByAppendingString:kLTSDBCoreBusiness] stringByAppendingFormat:@"?productCode=%@",urls[i]]];
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
    

    
}


//业务介绍按钮点击事件
- (void)addEvents{
    @weakify(self)
    [[self.businessBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        LTSBaseWebViewControlle *webView = [LTSBaseWebViewControlle new];
        webView.url = [NSURL URLWithString:[kLTSDBBaseUrl stringByAppendingString:kLTSDBBusinessIntroduction]];
        [self.navigationController pushViewController:webView animated:YES];
    }];
    
    [[self.exampleBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        LTSBaseWebViewControlle *webView = [LTSBaseWebViewControlle new];
        webView.url = [NSURL URLWithString:[kLTSDBBaseUrl stringByAppendingString:kLTSDBClassicCase]];
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
