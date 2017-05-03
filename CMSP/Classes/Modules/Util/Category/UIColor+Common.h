//
//  UIColor+Common.h
//  Join-Share
//
//  Created by leetangsong_macbk on 16/4/21.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Common)


+ (UIColor*) colorWithHexString:(NSString *)hexString;

+ (UIColor *) colorWithHexString:(NSString *)hexString alpha:(float)opacity;

@end
