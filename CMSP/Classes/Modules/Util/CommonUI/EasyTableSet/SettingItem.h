//
//  SettingItem.h
//  QuWorking
//
//  Created by xiaojia on 15/4/23.
//  Copyright (c) 2015年 eim. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void(^SettingItemOperation)();

@interface SettingItem : NSObject
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *badgeValue;
@property (nonatomic, strong) UIColor  *textColor;
@property (nonatomic, strong) UIColor *subtitleColor;
@property (nonatomic, assign) CGFloat rowHeight;
///**
// *  defalut 15
// */
//@property (nonatomic, assign) NSUInteger bottomLineLeftOffset;
@property (nonatomic, strong) SettingItemOperation operation;

+ (instancetype)itemWithIcon:(NSString *)icon title:(NSString *)title;
+ (instancetype)itemWithTitle:(NSString *)title;
+ (instancetype)item;
@end
