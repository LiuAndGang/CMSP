
//
//  LTSCustomButton.m
//  SAIFAMC
//
//  Created by 李棠松 on 16/8/20.
//  Copyright © 2016年 leetangsong. All rights reserved.
//

#import "LTSCustomButton.h"

@implementation LTSCustomButton


- (void)initBigbutton {
    
    self.clipsToBounds = YES;
    [self addSubview:self.touchView];
    _touchView.hidden = YES; //默认隐藏
}

- (instancetype)init {
    if (self = [super init]) {
        [self initBigbutton];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initBigbutton];
    }
    return self;
}






- (UIImageView *)touchView {
    if (!_touchView) {
        _touchView = [[UIImageView alloc] init];
        _touchView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3];
        _touchView.contentMode = UIViewContentModeScaleAspectFill; //原比例，多余部分被裁减
    }
    return _touchView;
}
- (void)setTouchColor:(UIColor *)touchColor {
    if (_touchColor != touchColor) {
        _touchColor = touchColor;
        self.touchView.backgroundColor = touchColor;
        [self setNeedsDisplay];
    }
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
        _touchView.hidden = NO;
    
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
    if (_touchView.hidden == NO) {
        _touchView.hidden = YES;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    if (_touchView.hidden == NO) {
        _touchView.hidden = YES;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self initUI];
}


-(void)initUI {
    
    //设置点击效果的黑色半透明view
    _touchView.frame = CGRectMake(0, 0, SELFWIDTH, SELFHEIGHT);
    
    
}


@end
