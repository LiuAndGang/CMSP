//
//  LTSSetGesturePwdViewController.m
//  CMSP
//
//  Created by 李棠松 on 2016/12/8.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#import "LTSSetGesturePwdViewController.h"
#import "JinnLockViewController.h"
@interface LTSSetGesturePwdViewController ()<JinnLockViewControllerDelegate>
@property (nonatomic, strong) SettingView *tableView;

@property (nonatomic, strong) SettingItem *changePwdItem;

@property (nonatomic, strong) SettingSwitchItem *stateItem;
@end

@implementation LTSSetGesturePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.title = @"手势密码";
    // Do any additional setup after loading the view.
}
- (void)initUI{
    self.tableView = ({ SettingView *tableView = [[SettingView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        tableView.backgroundColor = BGColorGray;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.sectionHeaderHeight = 8;
        tableView.rowHeight = 44;
        tableView.bottomLineLeftOffset = 0;
        [self.view addSubview:tableView];
        [tableView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        tableView;
    });
    
    [self setTableViewGroup1];

}
- (void)setTableViewGroup1{
     @weakify(self)
    
    SettingItem *item2 = [SettingArrowItem itemWithTitle:@"修改手势密码"];
    item2.operation = ^(id data){
        @strongify(self)
        JinnLockViewController *lockVC = [[JinnLockViewController alloc] initWithDelegate:self type:JinnLockTypeModify appearMode:JinnLockAppearModePush];
        lockVC.title = @"修改手势密码";
        [self.navigationController pushViewController:lockVC animated:YES];
        
    };
    self.changePwdItem = item2;
    
    SettingSwitchItem *item1 = [SettingSwitchItem itemWithTitle:@"开启手势密码"];
    item1.open = [JinnLockTool isGestureUnlockEnabled];
    item1.switchValueStateBlock = ^(bool isOpen){
       @strongify(self)
         [self setTableViewState:[JinnLockTool isGestureUnlockEnabled]];
        if (isOpen) {
        
            JinnLockViewController *lockViewController = [[JinnLockViewController alloc] initWithDelegate:self type:JinnLockTypeCreate appearMode:JinnLockAppearModePush];
            [self.navigationController pushViewController:lockViewController animated:YES];
            
        }else{
            JinnLockViewController *lockViewController = [[JinnLockViewController alloc] initWithDelegate:self type:JinnLockTypeRemove appearMode:JinnLockAppearModePush];
            [self.navigationController pushViewController:lockViewController animated:YES];

        }

    };
    
    self.stateItem = item1;
    
    [self setTableViewState:[JinnLockTool isGestureUnlockEnabled]];
}

- (void)setTableViewState:(BOOL)isOpen
{
    SettingGroup *itemGroup = [SettingGroup group];
    
    self.tableView.groups = [@[itemGroup] mutableCopy];
    self.stateItem.open =[JinnLockTool isGestureUnlockEnabled];
    if (isOpen) {
        itemGroup.items = @[self.stateItem,self.changePwdItem];
        //        slef.tableView reloadRowsAtIndexPaths:@[] withRowAnimation:(UITableViewRowAnimation)animation NS_AVAILABLE_IOS(3_0);
        
        [self.tableView reloadData];
    }else{
        itemGroup.items = @[self.stateItem];
        [self.tableView reloadData];
    }
}

#pragma mark - JinnLockViewControllerDelegate

- (void)passcodeDidCreate:(NSString *)passcode
{
    [self setTableViewState:[JinnLockTool isGestureUnlockEnabled]];
}

- (void)passcodeDidRemove
{
    [self setTableViewState:[JinnLockTool isGestureUnlockEnabled]];
}

- (void)passcodeDidModify:(NSString *)passcode{
   
}

- (void)passcodeDidVerify:(NSString *)passcode{
   
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
