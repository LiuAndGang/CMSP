//
//  UITextField+Common.m
//  CMSP
//
//  Created by 李棠松 on 2016/12/1.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#import "UITextField+Common.h"

@implementation UITextField (Common)
-(void)addLineAtDirection:(LTSDirection)LTSDirection leftOffset:(CGFloat)leftOffset
{
    //    if (!self.lineView) {
    //        self.lineView.backgroundColor = lineBGColor;
    //    }
    switch (LTSDirection) {
        case LTSDirectionDown: {
            //            self.lineView.frame = CGRectMake(0, self.frame.size.height - GloBalLineWidth, self.frame.size.width, 5);
            UIView *lineView = [[UIView alloc] init];
            [self addSubview:lineView];
            lineView.backgroundColor = lineBGColor;
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self);;
                make.left.equalTo(self).with.offset(leftOffset);
                make.right.equalTo(self);
                make.height.mas_equalTo(GloBalLineWidth);
            }];
        }
            break;
            
        case LTSDirectionTop: {
            UIView *lineView = [[UIView alloc] init];
            [self addSubview:lineView];
            lineView.backgroundColor = lineBGColor;
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.left.equalTo(self).with.offset(leftOffset);
                make.right.equalTo(self);
                make.height.mas_equalTo(GloBalLineWidth);
            }];
            
        }
            break;
            
        case LTSDirectionLeft: {
            UIView *lineView = [[UIView alloc] init];
            [self addSubview:lineView];
            lineView.backgroundColor = lineBGColor;
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.height.mas_equalTo(GloBalLineWidth);
            }];
            
        }
            
            break;
            
        default:
            break;
    }
    
}



-(void)addLineAtDirection:(LTSDirection)LTSDirection
{
    //    if (!self.lineView) {
    //        self.lineView.backgroundColor = lineBGColor;
    //    }
    switch (LTSDirection) {
        case LTSDirectionDown: {
            //            self.lineView.frame = CGRectMake(0, self.frame.size.height - GloBalLineWidth, self.frame.size.width, 5);
            UIView *lineView = [[UIView alloc] init];
            [self addSubview:lineView];
            lineView.backgroundColor = lineBGColor;
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self);;
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.height.mas_equalTo(GloBalLineWidth);
            }];
        }
            break;
            
        case LTSDirectionTop: {
            UIView *lineView = [[UIView alloc] init];
            [self addSubview:lineView];
            lineView.backgroundColor = lineBGColor;
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.height.mas_equalTo(GloBalLineWidth);
            }];
            
        }
            break;
            
        case LTSDirectionLeft: {
            UIView *lineView = [[UIView alloc] init];
            [self addSubview:lineView];
            lineView.backgroundColor = lineBGColor;
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.height.mas_equalTo(GloBalLineWidth);
            }];
            
        }
            
            break;
            
        default:
            break;
    }
    
}


@end


@implementation UITextField (AttributedPlaceholder)


- (void)setCustomPlaceholder:(NSString *)placeholder{
    NSAttributedString *placeHolderStr= [[NSAttributedString alloc]initWithString:placeholder attributes:@{NSForegroundColorAttributeName:LightGrayColor}];
    self.attributedPlaceholder = placeHolderStr;
    
}
@end
