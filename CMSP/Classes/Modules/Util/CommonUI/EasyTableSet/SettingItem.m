//
//  SettingItem.m
//  QuWorking
//
//  Created by xiaojia on 15/4/23.
//  Copyright (c) 2015年 eim. All rights reserved.
//


#import "SettingItem.h"

@implementation SettingItem

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title
{
    SettingItem *item = [self item];
    item.icon = icon;
    item.title = title;
    return item;
}

+ (instancetype)itemWithTitle:(NSString *)title
{
    return [self itemWithIcon:nil title:title];
}



+ (instancetype)item
{
    return [[self alloc] init];
}
@end
