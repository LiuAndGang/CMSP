//
//  SettingHeadImageItem.m
//  CMSP
//
//  Created by 李棠松 on 2016/12/8.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#import "SettingHeadImageItem.h"

@implementation SettingHeadImageItem
+(instancetype)itemWithTitle:(NSString *)title defaultImageName:(NSString *)imageName{
    SettingHeadImageItem *item = [self itemWithTitle:title];
    item.imageName = imageName;
    
    return item;
}
@end
