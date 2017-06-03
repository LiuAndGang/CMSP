//
//  SettingView.m
//  QuWorking
//
//  Created by xiaojia on 15/4/24.
//  Copyright (c) 2015年 eim. All rights reserved.
//

#import "SettingView.h"
#import "LTSPartnersRegisterViewController.h"
#import "LTSEnterpriseRegisterViewController.h"

@interface SettingView() <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign)BOOL isSelected;
@end


@implementation SettingView

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

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    
    if (self) {
        self.backgroundColor = RGBCOLOR(239, 239, 239);
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.sectionHeaderHeight = 0;
        self.sectionFooterHeight = 0;
        self.delegate = self;
        self.dataSource = self;
        
        
        
        self.rowHeight = CellRowHeight;
        
        self.bottomLineLeftOffset = 15;
    }
    return self;
}


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = RGBCOLOR(239, 239, 239);
//        self.separatorStyle = UITableViewCellSeparatorStyleSingleLineEtched;
        self.delegate = self;
        self.dataSource = self;
        
        self.sectionHeaderHeight = 0;
        self.sectionFooterHeight = 0;

        self.rowHeight = CellRowHeight;
    }
    return self;
    
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
    cell.bottomLineLeftOffset = self.bottomLineLeftOffset;
    
    if ([self.groups[indexPath.section] items].count -1 == indexPath.row) {
        cell.hasBottomLine = NO;
        
    }else{
        cell.hasBottomLine = YES;
    }
    
    cell.tag = indexPath.row;
    return cell;
}

#pragma mark - 代理
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingGroup *group = self.groups[indexPath.section];
    SettingItem *item = group.items[indexPath.row];
    if (item.rowHeight) {
        return item.rowHeight;
    }
    return self.rowHeight;
}
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

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    SettingGroup *group = self.groups[section];
    return group.footerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    SettingGroup *group = self.groups[section];
    if (group.footerView) {
        return CGRectGetHeight(group.footerView.frame);
    }
    
    return self.sectionFooterHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return self.sectionHeaderHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    SettingCell *cell = (SettingCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    [cell layoutSubviews];
    
    // 1.取出模型
    SettingGroup *group = self.groups[indexPath.section];
    SettingItem *item = group.items[indexPath.row];
    
    // 2.操作
    if (item.operation) {
        
        if ([cell.textLabel.text isEqualToString:@"证件类型:"] ) {
            
//            if ([currentVC isKindOfClass:LTSPartnersRegisterViewController]) {
//                <#statements#>
//            }
            [[NSNotificationCenter defaultCenter] postNotificationName:@"partner" object:nil];
            NSLog(@"发送通知成功");

        }
    }
    
    // 3.跳转
    if ([item isKindOfClass:[SettingArrowItem class]]) {
        SettingArrowItem *arrowItem = (SettingArrowItem *)item;
        if (arrowItem.destVcClass) {
            UIViewController *destVc = [[arrowItem.destVcClass alloc] init];
            destVc.title = arrowItem.title;
//            [self.navigationController pushViewController:destVc animated:YES];
        }
    }
}


#pragma mark -------Getter and Setter---------
-(CGFloat)lastCellMaxY
{
    return CGRectGetMaxY([self rectForFooterInSection:self.groups.count - 1]);
}


@end
