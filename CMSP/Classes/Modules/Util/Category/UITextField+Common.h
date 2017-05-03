//
//  UITextField+Common.h
//  CMSP
//
//  Created by 李棠松 on 2016/12/1.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSInteger,LTSDirection)
{
    LTSDirectionTop,
    LTSDirectionLeft,
    LTSDirectionRight,
    LTSDirectionDown
};
@interface UITextField (Common)


-(void)addLineAtDirection:(LTSDirection)direction;
-(void)addLineAtDirection:(LTSDirection)direction leftOffset:(CGFloat)leftOffset;

@end


@interface UITextField (AttributedPlaceholder)
///自定义颜色的placeholder
- (void)setCustomPlaceholder:(NSString *)placeholder;
@end
