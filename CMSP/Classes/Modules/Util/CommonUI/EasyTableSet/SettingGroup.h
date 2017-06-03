//
//  SettingGroup.h
//  QuWorking
//
//  Created by xiaojia on 15/4/23.
//  Copyright (c) 2015年 eim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SettingGroup : NSObject
@property (copy, nonatomic) NSString *header;
@property (copy, nonatomic) NSString *footer;
@property (nonatomic,strong)UIView *footerView;

@property (strong, nonatomic) NSArray *items;

+ (instancetype)group;
@end
