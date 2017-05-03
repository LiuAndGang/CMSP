//
//  UIViewController+HUD.h
//  CMSP
//
//  Created by 李棠松 on 2016/11/30.
//  Copyright © 2016年 李棠松. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BarButtonType){
    /**
     *  返回
     */
    BarButtonBack,
    BarButtonClose
};


@interface UIBarButtonItem (Style)

+ (instancetype)barButtonWithType:(BarButtonType)barButtonType;

@end
