/***************************************************************************************************
 **  Copyright © 2016年 Jinn Chang. All rights reserved.
 **  Giuhub: https://github.com/jinnchang
 **
 **  FileName: JinnLockIndicator.m
 **  Description: 解锁密码指示器
 **
 **  History
 **  -----------------------------------------------------------------------------------------------
 **  Author: jinnchang
 **  Date: 16/4/28
 **  Version: 1.0.0
 **  Remark: Create
 **************************************************************************************************/

#import "JinnLockIndicator.h"
#import "JinnLockConfig.h"
#import "JinnLockCircle.h"

@interface JinnLockIndicator ()

@property (nonatomic, strong) NSMutableArray *circleArray;
@property (nonatomic, strong) NSMutableArray *selectedCircleArray;
@property (nonatomic, assign) CGFloat        circleMargin;

@end

@implementation JinnLockIndicator

#pragma mark - Init

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self setup];
        [self createCircles];
    }
    
    return self;
}

- (void)setup
{
    self.backgroundColor     = [UIColor clearColor];
    self.clipsToBounds       = YES;

    self.circleArray         = [NSMutableArray array];
    self.selectedCircleArray = [NSMutableArray array];
    self.circleMargin        = kIndicatorSideLength / 15;
}

- (void)createCircles
{
    for (int i = 0; i < 9; i++)
    {
        float x = (kIndicatorWidth +kIndicatorMargin)*(i%3);
        float y = (kIndicatorWidth +kIndicatorMargin)*(i/3);
        
        JinnLockCircle *circle = [[JinnLockCircle alloc] initWithDiameter:kIndicatorWidth];
        [circle setTag:kIndicatorLevelBase + i];
        [circle updateCircleState:kIndicatorDefalutState];
        [circle setFrame:CGRectMake(x, y, kIndicatorWidth, kIndicatorWidth)];
        [self.circleArray addObject:circle];
        [self addSubview:circle];
    }
}

#pragma mark - Public

- (void)showPasscode:(NSString *)passcode
{
    [self reset];
    
    NSMutableArray *numbers = [[NSMutableArray alloc] initWithCapacity:passcode.length];
    for (int i = 0; i < passcode.length; i++)
    {
        NSRange range = NSMakeRange(i, 1);
        NSString *numberStr = [passcode substringWithRange:range];
        NSNumber *number = [NSNumber numberWithInt:numberStr.intValue];
        [numbers addObject:number];
        [self.circleArray[number.intValue] updateCircleState:kIndicatorSelectedState];
        [self.selectedCircleArray addObject:self.circleArray[number.intValue]];
    }
    
    [self setNeedsDisplay];
}

- (void)reset
{
    for (JinnLockCircle *circle in self.circleArray)
    {
        [circle updateCircleState:kIndicatorDefalutState];
    }
    
    [self.selectedCircleArray removeAllObjects];
}

#pragma mark - Draw

- (void)drawRect:(CGRect)rect
{
    if (self.selectedCircleArray.count == 0)
    {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, kIndicatorTrackWidth);
    [JINN_LOCK_COLOR_SELECTED set];
    
    CGPoint addLines[9];
    int count = 0;
    for (JinnLockCircle *circle in self.selectedCircleArray)
    {
        CGPoint point = CGPointMake(circle.center.x, circle.center.y);
        addLines[count++] = point;
    }
    
    CGContextAddLines(context, addLines, count);
    CGContextStrokePath(context);
}

@end
