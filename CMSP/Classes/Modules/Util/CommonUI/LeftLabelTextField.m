//
//  QWLeftLabelTextField.m
//  QuWorking
//
//  Created by 刘宇健 on 15/11/1.
//  Copyright © 2015年 HuikeSpace. All rights reserved.
//

#import "LeftLabelTextField.h"

@interface LeftLabelTextField()

@property (nonatomic, strong) UIView  *view_underLine;
@property (nonatomic, strong) UILabel *lb_title;

@end

@implementation LeftLabelTextField


-(instancetype)initWithTitle:(NSString *)title placeHolder:(NSString *)placeHolder
{
    self = [super init];
    if (self) {
        self.lb_title.text = title;
        self.placeholder = placeHolder;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.font = [UIFont systemFontOfSize:14];
        
        UIView *view_left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 90, 40)];
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftView = view_left;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        
        self.lb_title = ({ UILabel *label = [[UILabel alloc] init];
            [view_left addSubview:label];
            label.font = [UIFont systemFontOfSize:14];
            label.frame = CGRectMake(5, -5, 70, 50);
            label.textAlignment = NSTextAlignmentLeft;
            label;
        });
        
        self.view_underLine = ({ UIView *view = [[UIView alloc] init];
            
            CGFloat labelH = GloBalLineWidth;
            [self addSubview:view];
            //            [view mas_makeConstraints:^(MASConstraintMaker *make) {
            //                make.bottom.equalTo(self.mas_bottom).with.offset(-2);
            //                make.height.mas_equalTo(labelH);
            //                make.left.equalTo(self);
            //                make.right.equalTo(self.mas_right);
            //            }];
            view.backgroundColor = BGColorGray;
            view;
        });
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat labelH = GloBalLineWidth;
    self.view_underLine.frame = CGRectMake(0, self.frame.size.height - 3, self.frame.size.width, labelH);
}

-(void)awakeFromNib
{
    self.font = [UIFont systemFontOfSize:14];
    
    UIView *view_left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 120, 40)];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = view_left;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.lb_title = ({ UILabel *label = [[UILabel alloc] init];
        [view_left addSubview:label];
        label.font = [UIFont systemFontOfSize:14];
        label.frame = CGRectMake(5, -5, 120, 50);
        label.textAlignment = NSTextAlignmentLeft;
        label;
    });
    
    self.view_underLine = ({ UIView *view = [[UIView alloc] init];
        
        CGFloat labelH = GloBalLineWidth;
        [self addSubview:view];
        //        [view mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.bottom.equalTo(self.mas_bottom).with.offset(-2);
        //            make.height.mas_equalTo(labelH);
        //            make.left.equalTo(self);
        //            make.right.equalTo(self.mas_right);
        //        }];
        view.backgroundColor = BGColorGray;
        view;
    });
    
}

-(void)setLabelText:(NSString *)labelText
{
    _labelText = labelText;
    self.lb_title.text = labelText;
}

-(BOOL)becomeFirstResponder
{
    [super becomeFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.view_underLine.backgroundColor = ThemeColor;
    }];
    
    return YES;
}

-(BOOL)resignFirstResponder
{
    [super resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.view_underLine.backgroundColor = lineBGColor;
    }];
    return YES;
}



@end
