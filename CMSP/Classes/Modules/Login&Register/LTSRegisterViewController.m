//
//  LTSRegisterViewController.m
//  CMSP
//
//  Created by 李棠松 on 2016/12/6.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#import "LTSRegisterViewController.h"
#import "LTSPersonalRegisterViewController.h"
#import "LTSEnterpriseRegisterViewController.h"
#import "LTSPartnersRegisterViewController.h"
#import "LTSSegmentView.h"

@interface LTSRegisterViewController ()

@property (nonatomic,strong)LTSSegmentView *segmentView;

@end

@implementation LTSRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
}
- (void)initUI{
    self.segmentView = [[LTSSegmentView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.segmentView];
    self.segmentView.selectedColor = HexColor(@"#f75a21");
    self.segmentView.unSelectedColor = DarkText;
    self.segmentView.tabView.backgroundColor = BGColorGray;
    LTSPersonalRegisterViewController *personal =[LTSPersonalRegisterViewController new];
    LTSPartnersRegisterViewController *partner= [LTSPartnersRegisterViewController new];
    LTSEnterpriseRegisterViewController *enterprise= [LTSEnterpriseRegisterViewController new];
    _segmentView.segmentViewSelectIndexBlock = ^(NSUInteger index){
        partner.curIndex = index;
        enterprise.curIndex = index;
    };
    [self addChildViewController:personal];
    [self addChildViewController:partner];
    [self addChildViewController:enterprise];
    [self.segmentView configViewControllers:@[partner,enterprise] titles:@[@"合作机构",@"企业"]];
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
