//
//  UIView+Common.h
//  Coding_iOS
//
//  Created by 王 原闯 on 14-8-6.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EaseLoadingView, EaseBlankPageView, MulticolorView, EaseActLoadingView;

typedef NS_ENUM(NSInteger, EaseBlankPageType)
{
    
    BlankEmptyDepartment,
    BlankEmptyTemplate,
    BlankEmptyData,
    BlankEmptySelectedMainElement
    
    
};
typedef NS_OPTIONS(NSInteger,Direction)
{
    DirectionTop,
    DirectionLeft,
    DirectionRight,
    DirectionDown
};
@interface UIView (Common)


- (void)setY:(CGFloat)y;
- (void)setX:(CGFloat)x;
- (void)setOrigin:(CGPoint)origin;
- (void)setHeight:(CGFloat)height;
- (void)setWidth:(CGFloat)width;
- (void)setSize:(CGSize)size;


// 视图bounds的宽度
- (CGFloat)width;

// 视图bounds的高度
- (CGFloat)height;

// 视图的frame原点的x分量
- (CGFloat)left;

// 视图的frame原点的y分量
- (CGFloat)top;

// 设置视图的frame原点的x分量
- (void)setLeft:(CGFloat)x;

// 设置视图的frame原点的y分量
- (void)setTop:(CGFloat)x;

-(void)addLineAtDirection:(Direction)direction;
-(void)addLineAtDirection:(Direction)direction leftOffset:(CGFloat)leftOffset;

- (UIViewController *)findViewController;

- (UIView *)addBackViewToSupview:(CGRect)rect;
+ (UIView *)headerView:(CGFloat)y;

- (void)setCenterY:(CGFloat)y;
- (void)setCenterX:(CGFloat)x;

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andMidden:(BOOL)hasMidden;
- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andMidden:(BOOL)hasMidden andColor:(UIColor *)color;
- (void)addYLineLeft:(BOOL)hasLeft andMidden:(BOOL)hasMidden andRight:(BOOL)hasRight;
- (void)addYLineLeft:(BOOL)hasLeft andRigh:(BOOL)hasRight andMidden:(BOOL)hasMidden andColor:(UIColor *)color;

- (void)removeViewWithTag:(NSInteger)tag;

- (UIView *)lineViewWithPointYY:(CGFloat)pointY;
- (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color;

- (void)addGradientLayerWithColors:(NSArray *)cgColorArray;
- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )aPoint endPoint:(CGPoint)endPoint;

#pragma mark LoadingView
@property (strong, nonatomic) EaseLoadingView *loadingView;
- (void)beginLoading;
- (void)endLoading;

#pragma mark LoadActingView
@property (strong, nonatomic) EaseActLoadingView *loadingActView;
- (void)beginActLoading;
- (void)endActLoading;


#pragma mark BlankPageView
@property (strong, nonatomic) EaseBlankPageView *blankPageView;
- (void)configBlankPage:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;
@end

//   自定义的动画
//@interface EaseLoadingView : UIView
//@property (strong, nonatomic) MulticolorView *loopView;
//@property (assign, nonatomic, readonly) BOOL isLoading;
//@property (assign, nonatomic, readonly) NSInteger angle;
//- (void)startAnimating;
//- (void)stopAnimating;

//   自定义ActIndicator 系统 的动画
@interface EaseActLoadingView : UIView
@property (strong, nonatomic) UIActivityIndicatorView *indicatorView;
@property (assign, nonatomic, readonly) BOOL isLoading;
- (void)startActIndicatorAnimating;
- (void)stopActIndicatorAnimating;

@end

#pragma mark EaseBlankPageView
@interface EaseBlankPageView : UIView
@property (strong, nonatomic) UIImageView *fillView;
@property (strong, nonatomic) UILabel *tipLabel;
@property (strong, nonatomic) UIButton *reloadButton;
@property (assign, nonatomic) EaseBlankPageType curType;
@property (copy, nonatomic) void(^reloadButtonBlock)(id sender);
@property (copy, nonatomic) void(^loadAndShowStatusBlock)();
@property (copy, nonatomic) void(^clickButtonBlock)(EaseBlankPageType curType);
- (void)configWithType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void(^)(id sender))block;

@end


