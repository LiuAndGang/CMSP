//
//  LTSCustomTextField.m
//  CMSP
//
//  Created by 李棠松 on 2016/12/1.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#import "LTSCustomTextField.h"

@interface LTSCustomTextField()

//底部的线条
@property (nonatomic, strong) UIView  *view_underLine;

@property (nonatomic,strong)UILabel *titleLabel;
@end
@implementation LTSCustomTextField
- (void)setLeftOffset:(CGFloat)offset{
    UIView *view = [UIView new];
    view.frame = CGRectMake(0, 0, offset, 20);
    self.leftView = view;
    self.leftViewMode = UITextFieldViewModeAlways;
}

- (void)setLeftTitleText:(NSString *)title{
    self.textAlignment = NSTextAlignmentRight;
    CGFloat width = [title getWidthWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(1000, 20)];
    self.titleLabel.frame = CGRectMake(0, 0, width+10, 40);
}

+ (instancetype)textFieldWithleftImageIcon:(NSString *)icon{
    LTSCustomTextField *textField = [LTSCustomTextField new];
    textField.font = [UIFont systemFontOfSize:14];
    textField.textColor = DarkText;
    UIImage *image = [UIImage imageNamed:icon];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.contentMode = UIViewContentModeCenter;
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    UIView *bgView = [UIView new];
    bgView.frame = CGRectMake(0, 0, image.size.width+10, image.size.height);
    [bgView addSubview:imageView];
    textField.leftView = bgView;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
     
    return textField;

}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *lable = [UILabel new];
        lable.font = [UIFont systemFontOfSize:14];
        lable.textColor = DarkText;
        
        self.leftView = lable;
        self.leftViewMode = UITextFieldViewModeAlways;
        _titleLabel = lable;
    }
    return _titleLabel;
}

- (void)setBorderType:(LTSCustomTextFieldBorderType)borderType{
    _borderType = borderType;
    if (!borderType) {
        return;
    }
    if (borderType == LTSCustomTextFieldBorderTypeBottom) {
        [self view_underLine];
    }
}

- (UIView *)view_underLine{
    if (!_view_underLine) {
        _view_underLine = [[UIView alloc] init];
        _view_underLine.backgroundColor = LightGrayColor;
        [self addSubview:_view_underLine];
        
    }
    return _view_underLine;
}

-(BOOL)becomeFirstResponder
{
    [super becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        _view_underLine.backgroundColor = ThemeColor;
    }];
    
    return YES;
}

-(BOOL)resignFirstResponder
{
    [super resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        _view_underLine.backgroundColor = LightGrayColor;
    }];
    return YES;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
   
    [_view_underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(0);
        make.height.mas_equalTo(0.5);
    }];
    {
        CGRect frame = _titleLabel.frame;
        frame.size.height = CGRectGetHeight(self.frame);
        _titleLabel.frame = frame;
    }
    
}
@end
