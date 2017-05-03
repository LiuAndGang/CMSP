//
//  NSString+Common.h
//  Coding_iOS
//
//  Created by 王 原闯 on 14-7-31.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Common)

/**
 *  验证  字符串 是否包含 一个大写一个小写字符 数字
 */
- (BOOL)validateNumber;

- (NSString *)getServerTime;  //  得到客户服务时间
+ (NSString *)userAgentStr;


- (NSString *)URLEncoding;
- (NSString *)URLDecoding;
- (NSString *)md5Str;
- (NSString*)sha1Str;
- (NSURL *)urlWithCodePath;

+ (NSString *)stringWithUTCDateStr:(NSString *)utcStr  andDateFormatter:(NSString *)formatter;
- (CGSize )calculateSizeWithMaxSize:(CGSize )size content:(NSString *)content;

//- (NSString *)stringByRemoveHtmlTag;

-(BOOL)containsEmoji;

- (NSString *)emotionMonkeyName;

+ (NSString *)sizeDisplayWithByte:(CGFloat)sizeOfByte;



+ (NSString *)replaceUnicode:(NSString *)unicodeStr;

- (NSString *)trimWhitespace;
- (BOOL)isEmpty;
//判断是否为整形
- (BOOL)isPureInt;
//判断是否为浮点形
- (BOOL)isPureFloat;

//转换拼音 
- (NSString *)transformToPinyin;

- (NSString *)contactCharacterSetWithCharactersInString;

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size;
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

- (BOOL)IsEnglish;

+(id)toJsonDict:(NSString *)string;

@end

@interface NSString (Number)

+(NSString *)stringWithDoubleInDecimalStyle:(double)num;

+(NSString *)stringWithDoubleInDecimalStyleKeekTwoDecimalPlaces:(double)num withDecimal:(NSInteger)count;

+(NSString *)stringWithDoubleInDecimalStyleKeekTwoDecimalPlaces:(double)num;

+ (NSMutableAttributedString *)moneyStyle:(double)num color:(UIColor *)color;



- (NSString *)bigMoneyStyle;

@end

