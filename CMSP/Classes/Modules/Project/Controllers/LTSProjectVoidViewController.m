//
//  LTSProjectVoidViewController.m
//  CMSP
//
//  Created by 刘刚 on 2017/6/2.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import "LTSProjectVoidViewController.h"

@interface LTSProjectVoidViewController ()

@end

@implementation LTSProjectVoidViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = lineBGColor;
    
    UIImageView *myImageView = [[UIImageView alloc] init];
//    myImageView.backgroundColor = OrangeColor;
    [self.view addSubview:myImageView];
    myImageView.image = [UIImage imageNamed:@"project-def-tips"];
    [myImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(58);
        make.width.height.mas_equalTo(200);
        make.centerX.mas_equalTo(self.view.mas_centerX);
    }];
    
    
    UILabel *topLabel = [[UILabel alloc] init];
    [self.view addSubview:topLabel];
//    topLabel.backgroundColor = OrangeColor;
    topLabel.textColor = HexColor(@"#797979");
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.font = [UIFont systemFontOfSize:18];
    topLabel.text = @"注册为企业或合作机构用户";
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(myImageView.mas_bottom).with.offset(23);
//        make.width.mas_equalTo(self.view);
        make.centerX.mas_equalTo(self.view);
//        make.height.mas_equalTo(30);
    }];
    
    UILabel *bottomLabel = [[UILabel alloc] init];
    [self.view addSubview:bottomLabel];
//    bottomLabel.backgroundColor = OrangeColor;
    bottomLabel.textColor = HexColor(@"#797979");
    bottomLabel.text = @"您可以发起在线项目申请";
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(topLabel.mas_bottom).with.offset(10);
//        make.width.mas_equalTo(self.view);
        make.centerX.mas_equalTo(self.view);
//        make.height.mas_equalTo(30);
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
