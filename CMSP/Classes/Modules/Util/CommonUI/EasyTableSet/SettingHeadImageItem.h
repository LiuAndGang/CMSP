//
//  SettingHeadImageItem.h
//  CMSP
//
//  Created by 李棠松 on 2016/12/8.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#import "SettingItem.h"

@interface SettingHeadImageItem : SettingItem

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *urlString;

+ (instancetype)itemWithTitle:(NSString *)title defaultImageName:(NSString *)imageName;
@end
