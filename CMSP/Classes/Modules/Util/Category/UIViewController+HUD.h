//
//  UIViewController+HUD.h
//  CMSP
//
//  Created by 李棠松 on 2016/11/30.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>


@interface UIViewController (HUD)

@property (nonatomic,strong)MBProgressHUD *HUD;

- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

- (void)showErrorInView:(UIView *)view hint:(NSString *)hint;

- (void)showSuccessInView:(UIView *)view hint:(NSString *)hint;

- (void)showHint:(NSString *)hint;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;




- (void)hideHud;

- (void)hideHudWithAfterDelay:(NSTimeInterval)time;


@end
