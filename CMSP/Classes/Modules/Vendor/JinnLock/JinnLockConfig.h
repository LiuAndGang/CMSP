/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: JinnLockConfig.h
 **  Description: 配置文件
 **
 **  History
 **  -----------------------------------------------------------------------------------------------
 **  Author: jinnchang
 **  Date: 16/4/28
 **  Version: 1.0.0
 **  Remark: Create
 **************************************************************************************************/

#import <UIKit/UIKit.h>
#import "JinnLockCircle.h"
#import "UIColor+Common.h"
#ifndef JinnLockConfig_h
#define JinnLockConfig_h
// 背景颜色
#define JINN_LOCK_COLOR_BACKGROUND [UIColor whiteColor]

// 正常主题颜色
#define JINN_LOCK_COLOR_NORMAL HexColor(@"#d6d6d9")

// 正常字颜色
#define JINN_LOCK_COLOR_NOTICENORMAL HexColor(@"#333333")

//选中时的颜色
#define JINN_LOCK_COLOR_SELECTED HexColor(@"#f75a21")
// 错误提示颜色
#define JINN_LOCK_COLOR_ERROR [UIColor redColor]

// 重设按钮颜色
#define JINN_LOCK_COLOR_BUTTON [UIColor grayColor]


/**
 *  指示器每个圆的宽度
 */
static const CGFloat kIndicatorWidth = 5.f;

/**
 *  指示器每个圆的间距
 */
static const CGFloat kIndicatorMargin = 9.f;

/**
 *  指示器大小
 */
static const CGFloat kIndicatorSideLength = kIndicatorWidth*3 + kIndicatorMargin*2;

/**
 *  指示器未选中点的类型
 */
static const JinnLockCircleState kIndicatorDefalutState = JinnLockCircleStateFillNormal;
/**
 *  指示器选中点的类型
 */
static const JinnLockCircleState kIndicatorSelectedState = JinnLockCircleStateFillSelected;


/**
 *  九宫格每个圆的间距
 */
static const CGFloat kSudokoMargin = 126/2.f-20;

/**
 *  九宫格大小每个圆的宽度
 */
static const CGFloat kSudokoWidth = 30.f;

/**
 *  九宫格大小
 */
static const CGFloat kSudokoSideLength = kSudokoMargin*2+kSudokoWidth*3;

/**
 *  九宫格未选中点的类型
 */
static const JinnLockCircleState kSudokoDefalutState = JinnLockCircleStateCenterNormal;
/**
 *  九宫格选中点的类型
 */
static const JinnLockCircleState kSudokoSelectedState = JinnLockCircleStateCenterSelected;

/**
 *  圆圈边框粗细(指示器和九宫格的一样粗细)
 */
static const CGFloat kCircleWidth = 1.f;

/**
 *  指示器轨迹粗细
 */
static const CGFloat kIndicatorTrackWidth = 0.5f;

/**
 *  九宫格轨迹粗细
 */
static const CGFloat kSudokoTrackWidth = 1.f;

/**
 *  圆圈选中效果圆圈和中心点比例
 */
static const CGFloat kCircleCenterRatio = 3.f;

/**
 *  最少连接个数
 */
static const NSInteger kConnectionMinNum = 3;

/**
 *  指示器标签基数(不建议更改)
 */
static const NSInteger kIndicatorLevelBase = 1000;

/**
 *  九宫格标签基数(不建议更改)
 */
static const NSInteger kSudokoLevelBase = 2000;

/**
 *  手势解锁开关键(不建议更改) [NSString stringWithFormat:@"%@-JinnLockGestureUnlockEnabled",@"00"]
 */
#define kJinnLockGestureUnlockEnabled  [NSString stringWithFormat:@"%@-JinnLockGestureUnlockEnabled",@"00"]

/**
 *  手势密码键(不建议更改)
 */
#define kJinnLockPasscode [NSString stringWithFormat:@"%@-kJinnLockPasscode",@"00"]
/**
 *  指纹解锁开关键(不建议更改)
 */
static NSString * const kJinnLockTouchIdUnlockEnabled = @"JinnLockTouchIdUnlockEnabled";



/**
 *  提示文本
 */
static NSString * const kJinnLockTouchIdText  = @"指纹验证";
static NSString * const kJinnLockResetText    = @"重新设置";
static NSString * const kJinnLockNewText      = @"请设置新密码";
static NSString * const kJinnLockVerifyText   = @"请输入密码";
static NSString * const kJinnLockAgainText    = @"请再次确认新密码";
static NSString * const kJinnLockNotMatchText = @"两次密码不匹配";
static NSString * const kJinnLockReNewText    = @"请重新设置新密码";
static NSString * const kJinnLockReVerifyText = @"请重新输入密码";
static NSString * const kJinnLockOldText      = @"请输入旧密码";
static NSString * const kJinnLockOldErrorText = @"密码不正确";
static NSString * const kJinnLockReOldText    = @"请重新输入旧密码";

#define JINN_LOCK_NOT_ENOUGH [NSString stringWithFormat:@"最少连接%ld个点，请重新输入", (long)kConnectionMinNum]

#endif
