//
//  SettingViewController.h
//  QuWorking
//
//  Created by xiaojia on 15/4/23.
//  Copyright (c) 2015年 eim. All rights reserved.//

#import <UIKit/UIKit.h>
#import "SettingArrowItem.h"
#import "SettingGroup.h"
#import "SettingSwitchItem.h"
#import "SettingLabelItem.h"
#import "SettingCheckBoxItem.h"

@interface SettingViewController : UITableViewController
@property (strong, nonatomic) NSMutableArray *groups;

//添加分组
- (SettingGroup *)addGroup;

@end
