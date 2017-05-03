//
//  SettingCell.h
//  QuWorking
//
//  Created by xiaojia on 15/4/23.
//  Copyright (c) 2015年 eim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingItem.h"
#import "SettingArrowItem.h"
#import "SettingSwitchItem.h"
#import "SettingLabelItem.h"
#import "SettingCheckBoxItem.h"
#import "SettingTextFieldItem.h"
#import "SettingHeadImageItem.h"
#define CellRowHeight   44
#define CellArrowHeight 18
#define CellArrowWidth  18
#define HeadImageWidth    50
#define DetailTextLabelFont   [UIFont systemFontOfSize:14]
#define TextLabelFont   [UIFont systemFontOfSize:14]

typedef enum{
    
    SettingItemDefault = 0,
    SettingArrowType,
    SettingLabelType,
    SettingSwitchType,
    SettingCheckBoxType

}SettingItemType;

typedef void(^SwtichValueStateBlock)(bool isOpen);

@class SettingItem;

@interface SettingCell : UITableViewCell

@property (nonatomic, assign)  BOOL  hasBottomLine;
@property (strong, nonatomic) SettingItem *item;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign) NSUInteger bottomLineLeftOffset;
//@property (nonatomic) SettingItemType settingStyleType;

@property (nonatomic,assign)BOOL haveRedPoint;

//switchBlock
@property (nonatomic, copy) SwtichValueStateBlock swtichValueStateBlock;
@property (nonatomic,strong) UILabel *detailLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
