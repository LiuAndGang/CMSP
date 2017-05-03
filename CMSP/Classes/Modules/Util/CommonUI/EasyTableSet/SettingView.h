//
//  SettingView.h
//  QuWorking
//
//  Created by xiaojia on 15/4/24.
//  Copyright (c) 2015年 eim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingGroup.h"
#import "SettingCell.h"

@interface SettingView : UITableView

@property (strong, nonatomic) NSMutableArray *groups;

@property (assign,readonly,nonatomic) CGFloat lastCellMaxY;

//@property (nonatomic,strong) SettingCell *settingCell;

/**
 *  defalut 15
 */
@property (nonatomic, assign) NSUInteger bottomLineLeftOffset;


- (SettingGroup *)addGroup;

@end
