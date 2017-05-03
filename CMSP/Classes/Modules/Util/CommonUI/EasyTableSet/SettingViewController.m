//
//  SettingViewController.m
//  QuWorking
//
//  Created by xiaojia on 15/4/23.
//  Copyright (c) 2015年 eim. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingCell.h"


@interface SettingViewController ()

@end

@implementation SettingViewController

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (SettingGroup *)addGroup
{
    SettingGroup *group = [SettingGroup group];
    [self.groups addObject:group];
    return group;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (id)init
{
    return [super initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidAppear:(BOOL)animated {}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.tableView.backgroundColor = RGBCOLOR(239, 239, 239);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.sectionHeaderHeight = 10;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.rowHeight = CellRowHeight;
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SettingGroup *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingCell *cell = [SettingCell cellWithTableView:tableView];
    SettingGroup *group = self.groups[indexPath.section];
    cell.item = group.items[indexPath.row];
    cell.indexPath = indexPath;
    return cell;
}

#pragma mark - 代理
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    SettingGroup *group = self.groups[section];
    return group.footer;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SettingGroup *group = self.groups[section];
    return group.header;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 1.取出模型
    SettingGroup *group = self.groups[indexPath.section];
    SettingItem *item = group.items[indexPath.row];
    
    // 2.操作
    if (item.operation) {
        
    }
    
    // 3.跳转
    if ([item isKindOfClass:[SettingArrowItem class]]) {
        SettingArrowItem *arrowItem = (SettingArrowItem *)item;
        if (arrowItem.destVcClass) {
            UIViewController *destVc = [[arrowItem.destVcClass alloc] init];
            destVc.title = arrowItem.title;
            [self.navigationController pushViewController:destVc animated:YES];
        }
    }
}

@end
