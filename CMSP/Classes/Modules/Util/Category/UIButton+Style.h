//
//  UIViewController+HUD.h
//  CMSP
//
//  Created by 李棠松 on 2016/11/30.
//  Copyright © 2016年 李棠松. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIButton (Style)


/**
 *上面图片下面文字 先设置好button的frame  在调用
 *@param spacing 图片与文字的间距
 */
- (void)verticalImageAndTitle:(CGFloat)spacing;

-(void)accountButtonStyle;

-(void)GrayRoundButtonStyle;
- (void)OrangeRoundButtonStyle;

- (void)hollowRoundButtonStyleWithColor:(UIColor *)color title:(NSString *)title;

@end
