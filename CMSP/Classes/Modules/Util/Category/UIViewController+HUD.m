//
//  UIViewController+HUD.m
//  CMSP
//
//  Created by 李棠松 on 2016/11/30.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#import "UIViewController+HUD.h"

#import <objc/runtime.h>
#import "JQIndicatorView.h"
static const void *HttpRequestHUDKey = &HttpRequestHUDKey;


@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
    
}
- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    [self createHUDWithView:view image:@"hudbg" hint:hint];
    JQIndicatorView *indicatorView = [[JQIndicatorView alloc]initWithType:JQIndicatorTypeBounceSpot2 tintColor:[UIColor whiteColor]size:CGSizeMake(50, 50)];
    [self.HUD.customView addSubview:indicatorView];
    indicatorView.center = CGPointMake(35, 30);
    [indicatorView startAnimating];
    [self hideHud];

}

- (void)showErrorInView:(UIView *)view hint:(NSString *)hint{
    if (self.HUD) {
        UIImage *image = [[UIImage imageNamed:@"hudFail"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        self.HUD.customView = imageView;
        self.HUD.label.text = hint;
        self.HUD.bezelView.color = OrangeColorAlpha(0.85);
    }
    else [self createHUDWithView:view image:@"hudFail" hint:hint];
    [self hideHud];

    
}


- (void)showSuccessInView:(UIView *)view hint:(NSString *)hint{
    if (self.HUD) {
        UIImage *image = [[UIImage imageNamed:@"hudSuccess"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
        self.HUD.customView = imageView;
        self.HUD.label.text = hint;
        
    }
    else [self createHUDWithView:view image:@"hudSuccess" hint:hint];
    [self hideHud];

}


- (void)createHUDWithView:(UIView *)view image:(NSString *)imageName hint:(NSString *)hint{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.font = [UIFont systemFontOfSize:16];
    hud.label.text = hint;
    hud.mode = MBProgressHUDModeCustomView;
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    hud.animationType = MBProgressHUDAnimationFade;
    hud.minSize = CGSizeMake(170,150);
    hud.customView = imageView;
    
    hud.contentColor = [UIColor whiteColor];
    
    hud.bezelView.color = OrangeColorAlpha(0.85);
    
    hud.removeFromSuperViewOnHide = YES;
    
    [self setHUD:hud];

}

- (void)hideHud{
   [[self HUD] hideAnimated:YES afterDelay:1];
}
- (void)hideHudWithAfterDelay:(NSTimeInterval)time{
    [[self HUD] hideAnimated:YES afterDelay:time];

}

@end
