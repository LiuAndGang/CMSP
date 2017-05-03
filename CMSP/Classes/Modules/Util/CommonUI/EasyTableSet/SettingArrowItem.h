//
//  SettingItem.h
//  QuWorking
//
//  Created by xiaojia on 15/4/23.
//  Copyright (c) 2015年 eim. All rights reserved.
//

#import "SettingItem.h"

@interface SettingArrowItem : SettingItem
@property (assign, nonatomic) Class destVcClass;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;
+ (instancetype)itemWithTitle:(NSString *)title destVcClass:(Class)destVcClass;
@end
