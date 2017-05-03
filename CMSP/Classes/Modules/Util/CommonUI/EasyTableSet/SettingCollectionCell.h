//
//  SettingCollectionCell.h
//  QuWorking
//
//  Created by xiaojia on 15/4/24.
//  Copyright (c) 2015年 eim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingItem.h"
#import "SettingItem.h"
#import "SettingArrowItem.h"
#import "SettingSwitchItem.h"
#import "SettingLabelItem.h"
#import "SettingCheckBoxItem.h"

//#define CellRowHeight 40

@interface SettingCollectionCell : UICollectionViewCell

@property (strong, nonatomic) SettingItem *item;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
