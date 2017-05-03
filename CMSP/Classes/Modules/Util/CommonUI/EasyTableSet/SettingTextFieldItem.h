//
//  SettingTextFieldItem.h
//  QuWorking
//
//  Created by 刘宇健 on 16/1/8.
//  Copyright © 2016年 HuikeSpace. All rights reserved.
//

#import "SettingItem.h"

typedef void(^TextInputBlock)(NSString *text);

@interface SettingTextFieldItem : SettingItem
@property(nonatomic,getter=isSecureTextEntry) BOOL secureTextEntry;  
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *placeHolder;
@property (nonatomic, copy) TextInputBlock textInputBlock;

@end
