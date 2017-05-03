/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: JinnLockCircle.h
 **  Description: 圆圈
 **
 **  History
 **  -----------------------------------------------------------------------------------------------
 **  Author: jinnchang
 **  Date: 16/4/28
 **  Version: 1.0.0
 **  Remark: Create
 **************************************************************************************************/

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, JinnLockCircleState)
{
    JinnLockCircleStateNormal = 0,//空心圆环
    JinnLockCircleStateCenterNormal ,//圆环加中心小实心圆
    JinnLockCircleStateCenterSelected , //圆环加中心小实心圆选中
    JinnLockCircleStateFillNormal ,//实心圆
    JinnLockCircleStateFillSelected,//实心圆选中
   
    
    JinnLockCircleStateError
};

@interface JinnLockCircle : UIView

@property (nonatomic, assign) JinnLockCircleState state;
@property (nonatomic, assign) CGFloat diameter;

- (instancetype)initWithDiameter:(CGFloat)diameter;
- (void)updateCircleState:(JinnLockCircleState)state;

@end
