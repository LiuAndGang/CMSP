//
//  UIViewController+HUD.h
//  CMSP
//
//  Created by 李棠松 on 2016/11/30.
//  Copyright © 2016年 李棠松. All rights reserved.
//


#import "UIButton+Style.h"

@implementation UIButton (Style)


- (void)verticalImageAndTitle:(CGFloat)spacing
{
//    self.titleLabel.backgroundColor = [UIColor greenColor];
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    CGSize textSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalHeight = (imageSize.height + titleSize.height + spacing);
    self.imageEdgeInsets = UIEdgeInsetsMake(- (totalHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalHeight - titleSize.height), 0);
    
}

-(void)accountButtonStyle;
{
    [self setBackgroundColor:RGBCOLOR(28, 37, 73)];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

-(void)GrayRoundButtonStyle;
{
    [self setBackgroundColor:LightGrayColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
}

-(void)OrangeRoundButtonStyle{
    [self setBackgroundColor:OrangeColor];
    self.layer.cornerRadius = 5;
    self.layer.masksToBounds = YES;
    
}


- (void)hollowRoundButtonStyleWithColor:(UIColor *)color title:(NSString *)title
{
    [self setTitleColor:ThemeColor forState:UIControlStateNormal];
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = ThemeColor.CGColor;
    [self setTitle:title forState:UIControlStateNormal];
    self.layer.cornerRadius = 5;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
}


@end
