//
//  SettingSwitchItem.h
//  QuWorking
//
//  Created by xiaojia on 15/4/23.
//  Copyright (c) 2015年 eim. All rights reserved.//

#import "SettingItem.h"

typedef void(^SwtichValueStateBlock)(bool isOpen);

@interface SettingSwitchItem : SettingItem

@property (nonatomic, assign, getter=isOpen)  BOOL open;

@property (nonatomic, copy) SwtichValueStateBlock switchValueStateBlock;

@end
