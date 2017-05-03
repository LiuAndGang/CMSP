//
//  MMActivityHub.h
//  MengMeng
//
//  Created by nanfang on 14-7-2.
//  Copyright (c) 2014年 LanHuEdu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ActivityHub [MMActivityHub shareActSingleton]

typedef void (^ActivityHubActionBlock) (void);

@interface MMActivityHub : UIView
{
    UIView *ActivitiViewHub;
}
@property (nonatomic, strong) ActivityHubActionBlock hubActionBlock;
//单例
+ (MMActivityHub *)shareActSingleton;

- (void)ShowHub:(NSString *)Title;

- (void)ShowHub:(NSString *)Title offSetY:(CGFloat)offSetY delay:(CGFloat)delay;

- (void)CloseHub;

- (void)clearSingleton;

@end
