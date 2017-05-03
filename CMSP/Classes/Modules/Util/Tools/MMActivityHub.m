//
//  MMActivityHub.m
//  MengMeng
//
//  Created by nanfang on 14-7-2.
//  Copyright (c) 2014年 LanHuEdu. All rights reserved.
//

#import "MMActivityHub.h"

@implementation MMActivityHub

static MMActivityHub *shareMMActivityHub = nil;

- (void)clearSingleton
{
    shareMMActivityHub = nil;
}

+ (MMActivityHub *)shareActSingleton{
    @synchronized(self){
        if(shareMMActivityHub == nil){
            shareMMActivityHub = [[self alloc] init];
        }
    }
    return shareMMActivityHub;
}

+(id)allocWithZone:(NSZone *)zone{
    @synchronized(self){
        if (shareMMActivityHub == nil) {
            shareMMActivityHub = [super allocWithZone:zone];
            return  shareMMActivityHub;
        }
    }
    return nil;
}

//展示View
- (void)ShowHub:(NSString *)Title
{
    
    if (!self->ActivitiViewHub) {
        
        NSInteger IntCount = 0;  //中文字符串的 个数
        
        for(int i = 0; i < [Title length]; i++) {
            int a = [Title characterAtIndex:i];
            if( a > 0x4e00 && a < 0x9fff){
                IntCount++;
            }
        }
        
        CGFloat ActivityWidth = IntCount*15 + (Title.length - IntCount)*8 + 55.f;
        CGFloat maxWidth = Screen_Width-60.f;
        
        CGRect Rect = CGRectMake(0, 0, ActivityWidth>maxWidth?maxWidth:ActivityWidth, ActivityWidth>maxWidth?80:65);
        
        self->ActivitiViewHub = [[UIView alloc] initWithFrame:Rect];
        self->ActivitiViewHub.center = CGPointMake(Screen_Width/2, Screen_Height/2.f+30.f);
        self->ActivitiViewHub.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
        ViewBordershadow(self->ActivitiViewHub, 2.f, 3.f, .5);
        [APPKeyWindow addSubview:self->ActivitiViewHub];
        
        Rect.size.width -= 15;
        Rect.origin.x = 7.5;
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:Rect];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = SYSTEMFONT(16);
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel setNumberOfLines:2];
        titleLabel.text = Title;
        [self->ActivitiViewHub addSubview:titleLabel];
        
        [UIView animateWithDuration:0.1 animations:^{
            [self->ActivitiViewHub setTransform:CGAffineTransformMakeScale(1.f, 1.f)];
        }completion:^(BOOL finished){
            [UIView animateWithDuration:0.2 animations:^{
                [self->ActivitiViewHub setTransform:CGAffineTransformMakeScale(1.f, 1.f)];
            } completion:^(BOOL finished){
                [UIView animateWithDuration:0.1 animations:^{
                    [self->ActivitiViewHub setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
                }completion:^(BOOL finished){
                    [self performSelector:@selector(CloseHub) withObject:nil afterDelay:2.5];
                }];
            }];
        }];
    }
}


- (void)ShowHub:(NSString *)Title offSetY:(CGFloat)offSetY delay:(CGFloat)delay
{
    if (!self->ActivitiViewHub) {
        
        NSInteger IntCount = 0;  //中文字符串的 个数
        
        for(int i = 0; i < [Title length]; i++) {
            int a = [Title characterAtIndex:i];
            if( a > 0x4e00 && a < 0x9fff){
                IntCount++;
            }
        }
        
        CGFloat ActivityWidth = IntCount*15 + (Title.length - IntCount)*8 + 55.f;
        CGFloat maxWidth = Screen_Width-60.f;
        
        CGRect Rect = CGRectMake(0, 0, ActivityWidth>maxWidth?maxWidth:ActivityWidth, ActivityWidth>maxWidth?80:65);
        
        self->ActivitiViewHub = [[UIView alloc] initWithFrame:Rect];
        self->ActivitiViewHub.center = CGPointMake(Screen_Width/2, Screen_Height/2.f+10.f + 200);
        self->ActivitiViewHub.backgroundColor = [UIColor colorWithWhite:0.1 alpha:0.8];
        ViewBordershadow(self->ActivitiViewHub, 2.f, 3.f, .5);
        [APPKeyWindow addSubview:self->ActivitiViewHub];
        
        Rect.size.width -= 15;
        Rect.origin.x = 7.5;
        UILabel * titleLabel = [[UILabel alloc] initWithFrame:Rect];
        titleLabel.textColor = [UIColor whiteColor];
        titleLabel.font = SYSTEMFONT(16);
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [titleLabel setNumberOfLines:2];
        titleLabel.text = Title;
        [self->ActivitiViewHub addSubview:titleLabel];
        
        [UIView animateWithDuration:0.1 animations:^{
            [self->ActivitiViewHub setTransform:CGAffineTransformMakeScale(1.f, 1.f)];
        }completion:^(BOOL finished){
            [UIView animateWithDuration:0.2 animations:^{
                [self->ActivitiViewHub setTransform:CGAffineTransformMakeScale(1.f, 1.f)];
            } completion:^(BOOL finished){
                [UIView animateWithDuration:0.1 animations:^{
                    [self->ActivitiViewHub setTransform:CGAffineTransformMakeScale(1.0, 1.0)];
                }completion:^(BOOL finished){
                    [self performSelector:@selector(CloseHub) withObject:nil afterDelay:delay];
                }];
            }];
        }];
    }

}

//关闭
- (void)CloseHub
{
    [UIView animateWithDuration:0.1 animations:^{
        [self->ActivitiViewHub setTransform:CGAffineTransformMakeScale(1.f, 1.f)];
    } completion:^(BOOL finished){
        [UIView animateWithDuration:0.3 animations:^{
            [self->ActivitiViewHub setTransform:CGAffineTransformMakeScale(1.f, 1.f)];
            self->ActivitiViewHub.alpha = 0.1;
        } completion:^(BOOL finished){
            [self->ActivitiViewHub removeFromSuperview]; self->ActivitiViewHub = nil;
            [self removeFromSuperview];
            if (_hubActionBlock) {
                _hubActionBlock();
                _hubActionBlock = nil;
            }
        }];
    }];
}


@end
