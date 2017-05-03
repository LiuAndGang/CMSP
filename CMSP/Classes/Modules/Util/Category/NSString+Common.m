//
//  NSString+Common.m
//  Coding_iOS
//
//  Created by 王 原闯 on 14-7-31.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import "NSString+Common.h"
#import <CommonCrypto/CommonDigest.h>
#import "sys/utsname.h"

@implementation NSString (Common)
//
//- (CGSize )calculateSizeWithMaxSize:(CGSize )size content:(NSString *)content
//{
//    
//    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:content];
//    //    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];      [paragraphStyle setLineSpacing:10];
//    //    [attributedString addAttribute:NSParagraphStyleAttributeName value: range:NSMakeRange(0, [self.contentLabel.text length])];
//    [attributedString addAttribute:NSFontAttributeName value:self.contentLabel.font range:NSMakeRange(0, [content length])];
//    CGRect rect = [attributedString boundingRectWithSize:CGSizeMake(self.contentView.frame.size.width - 2 * 15, 10000) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading context:nil];
//
//    return CGSizeMake(0, 0);
//}

//+(NSString *):(NSNumber *)addTime{
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateStyle:NSDateFormatterMediumStyle];
//    [formatter setTimeStyle:NSDateFormatterShortStyle];
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[addTime doubleValue]/1000];
////    if (pae == 0) {
////        [formatter setDateFormat:@"YYYY-MM-dd"];
////    }
////    else{
//        [formatter setDateFormat:@"YYYY-MM-dd  HH:MM:ss"];
////    }
//    NSString *time = [formatter stringFromDate:confromTimesp];
//    return time;
//}
//

+ (NSString *)stringWithUTCDateStr:(NSString *)utcStr  andDateFormatter:(NSString *)formatter{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    
    NSDate *dateFormatted = [dateFormatter dateFromString:utcStr];
    //输出格式
    [dateFormatter setDateFormat:formatter];
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    return dateString;
}

+ (NSString *)replaceUnicode:(NSString *)unicodeStr
{
    
    NSString *tempStr1 = [unicodeStr stringByReplacingOccurrencesOfString:@"\\u"withString:@"\\U"];
    NSString *tempStr2 = [tempStr1 stringByReplacingOccurrencesOfString:@"\""withString:@"\\\""];
    NSString *tempStr3 = [[@"\""stringByAppendingString:tempStr2]stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString* returnStr = [NSPropertyListSerialization propertyListFromData:tempData
                                                           mutabilityOption:NSPropertyListImmutable
                                                                     format:NULL
                                                           errorDescription:NULL];
    
    return [returnStr stringByReplacingOccurrencesOfString:@"\\r\\n"withString:@"\n"];
}

- (NSString *)URLEncoding
{
    NSString * result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault,
                                                                                              (CFStringRef)self,
                                                                                              NULL,
                                                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                              kCFStringEncodingUTF8 ));
    return result;
}

- (NSString *)URLDecoding
{
    NSMutableString * string = [NSMutableString stringWithString:self];
    [string replaceOccurrencesOfString:@"+"
                            withString:@" "
                               options:NSLiteralSearch
                                 range:NSMakeRange(0, [string length])];
    return [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}


- (NSString *)md5Str
{
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}

- (NSString*)sha1Str
{
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

- (NSURL *)urlWithCodePath{
    NSString *urlStr;
    if (!self || self.length <= 0) {
        return nil;
    }else{
        if (![self hasPrefix:@"http"]) {
            //urlStr = [NSString stringWithFormat:@"%@%@", kNetPath_Code_Base, self];
        }else{
            urlStr = self;
        }
        return [NSURL URLWithString:urlStr];
    }
}

-(BOOL)containsEmoji{
    if (!self || self.length <= 0) {
        return NO;
    }
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}
#pragma mark emotion_monkey
+ (NSDictionary *)emotion_monkey_dict {
    static NSDictionary *_emotion_monkey_dict;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _emotion_monkey_dict = @{@"coding_emoji_01": @"哈哈",
                                 @"coding_emoji_02": @"吐",
                                 @"coding_emoji_03": @"压力山大",
                                 @"coding_emoji_04": @"忧伤",
                                 @"coding_emoji_05": @"坏人",
                                 @"coding_emoji_06": @"酷",
                                 @"coding_emoji_07": @"哼",
                                 @"coding_emoji_08": @"你咬我啊",
                                 @"coding_emoji_09": @"内急",
                                 @"coding_emoji_10": @"32个赞",
                                 @"coding_emoji_11": @"加油",
                                 @"coding_emoji_12": @"闭嘴",
                                 @"coding_emoji_13": @"wow",
                                 @"coding_emoji_14": @"泪流成河",
                                 @"coding_emoji_15": @"NO!",
                                 @"coding_emoji_16": @"疑问",
                                 @"coding_emoji_17": @"耶",
                                 @"coding_emoji_18": @"生日快乐",
                                 @"coding_emoji_19": @"求包养",
                                 @"coding_emoji_20": @"吹泡泡",
                                 @"coding_emoji_21": @"睡觉",
                                 @"coding_emoji_22": @"惊讶",
                                 @"coding_emoji_23": @"Hi",
                                 @"coding_emoji_24": @"打发点咯",
                                 @"coding_emoji_25": @"呵呵",
                                 @"coding_emoji_26": @"喷血",
                                 @"coding_emoji_27": @"Bug",
                                 @"coding_emoji_28": @"听音乐",
                                 @"coding_emoji_29": @"垒码",
                                 @"coding_emoji_30": @"我打你哦",
                                 @"coding_emoji_31": @"顶足球",
                                 @"coding_emoji_32": @"放毒气",
                                 @"coding_emoji_33": @"表白",
                                 @"coding_emoji_34": @"抓瓢虫",
                                 @"coding_emoji_35": @"下班",
                                 @"coding_emoji_36": @"冒泡"};
    });
    return _emotion_monkey_dict;
}
- (NSString *)emotionMonkeyName{
    return [NSString emotion_monkey_dict][self];
}

+ (NSString *)sizeDisplayWithByte:(CGFloat)sizeOfByte{
    NSString *sizeDisplayStr;
    if (sizeOfByte < 1024) {
        sizeDisplayStr = [NSString stringWithFormat:@"%.2f bytes", sizeOfByte];
    }else{
        CGFloat sizeOfKB = sizeOfByte/1024;
        if (sizeOfKB < 1024) {
            sizeDisplayStr = [NSString stringWithFormat:@"%.2f KB", sizeOfKB];
        }else{
            CGFloat sizeOfM = sizeOfKB/1024;
            if (sizeOfM < 1024) {
                sizeDisplayStr = [NSString stringWithFormat:@"%.2f M", sizeOfM];
            }else{
                CGFloat sizeOfG = sizeOfKB/1024;
                sizeDisplayStr = [NSString stringWithFormat:@"%.2f G", sizeOfG];
            }
        }
    }
    return sizeDisplayStr;
}

- (NSString *)trimWhitespace
{
    NSMutableString *str = [self mutableCopy];
    CFStringTrimWhitespace((__bridge CFMutableStringRef)str);
    return str;
}

- (BOOL)isEmpty
{
    return [[self trimWhitespace] isEqualToString:@""];
}

//判断是否为整形
- (BOOL)isPureInt{
    NSScanner* scan = [NSScanner scannerWithString:self];
    int val;
    return[scan scanInt:&val] && [scan isAtEnd];
}

//判断是否为浮点形
- (BOOL)isPureFloat{
    NSScanner* scan = [NSScanner scannerWithString:self];
    float val;
    return[scan scanFloat:&val] && [scan isAtEnd];
}

- (NSString *)stringByTrimmingLeftCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    for (location = 0; location < length; location++) {
        if (![characterSet characterIsMember:charBuffer[location]]) {
            break;
        }
    }
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

- (NSString *)stringByTrimmingRightCharactersInSet:(NSCharacterSet *)characterSet {
    NSUInteger location = 0;
    NSUInteger length = [self length];
    unichar charBuffer[length];
    [self getCharacters:charBuffer];
    for (length = [self length]; length > 0; length--) {
        if (![characterSet characterIsMember:charBuffer[length - 1]]) {
            break;
        }
    }
    return [self substringWithRange:NSMakeRange(location, length - location)];
}

//转换拼音
- (NSString *)transformToPinyin {
    if (self.length <= 0) {
        return self;
    }
    NSMutableString *tempString = [NSMutableString stringWithString:self];
    CFStringTransform((CFMutableStringRef)tempString, NULL, kCFStringTransformToLatin, false);
    tempString = (NSMutableString *)[tempString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]];
    return [tempString uppercaseString];
}

//字符串 去掉各种字符
- (NSString *)contactCharacterSetWithCharactersInString
{
    NSString *noQianzhui = [self formatPhoneNum:self];
    NSCharacterSet *doNotWant = [NSCharacterSet characterSetWithCharactersInString:@"@ －（）-().·[]{}（#%-*+=_）\\|~(＜＞$%^&*)_+"];
    NSString *trimmedString = [noQianzhui stringByTrimmingCharactersInSet:doNotWant];
    NSString *tempString = [trimmedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    return tempString;
    
}

- (NSString *)formatPhoneNum:(NSString *)phone
{
    if ([phone hasPrefix:@"86"]) {
        NSString *formatStr = [phone substringWithRange:NSMakeRange(2, [phone length]-2)];
        return formatStr;
    }else if ([phone hasPrefix:@"+86"])
    {
        if ([phone hasPrefix:@"+86·"]||[phone hasPrefix:@"+86 "]) {
            NSString *formatStr = [phone substringWithRange:NSMakeRange(4, [phone length]-4)];
            return formatStr;
        }else if([phone hasPrefix:@"+86  "]||[phone hasPrefix:@"+86··"]){
            NSString *formatStr = [phone substringWithRange:NSMakeRange(5, [phone length]-5)];
            return formatStr;
        }else{
            NSString *formatStr = [phone substringWithRange:NSMakeRange(3, [phone length]-3)];
            return formatStr;
        }
    }
    
    return phone;
    
}

- (CGSize)getSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    CGSize resultSize = CGSizeZero;
    if (self.length <= 0) {
        return resultSize;
    }
    if (IOS7_OR_LATER) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        
        NSDictionary * attributes = @{NSFontAttributeName:font,
                                      NSParagraphStyleAttributeName:paragraphStyle};
        
        resultSize = [self boundingRectWithSize:size
                                        options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:attributes
                                        context:nil].size;
    } else {
#if __IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_7_0
        resultSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName:font}];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [paragraphStyle setLineSpacing:2.0];
        
        [attributedStr addAttribute:NSParagraphStyleAttributeName
                              value:paragraphStyle
                              range:NSMakeRange(0, [self length])];
        resultSize = [attributedStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
        
#endif
        resultSize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:NSLineBreakByWordWrapping];
    }
    return resultSize;
    
}

- (CGFloat)getHeightWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self getSizeWithFont:font constrainedToSize:size].height;
}
- (CGFloat)getWidthWithFont:(UIFont *)font constrainedToSize:(CGSize)size{
    return [self getSizeWithFont:font constrainedToSize:size].width;
}



- (BOOL)IsEnglish
{
    for(int i=0; i< [self length];i++){
        int a = [self characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff)
            return NO;
    }
    return YES;
}

+(id)toJsonDict:(NSString *)string
{
    NSData *stringData = [(NSString *)string dataUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    
    id jsonData = [NSJSONSerialization JSONObjectWithData:stringData options:NSJSONReadingMutableLeaves error:&error];
    
  
    return jsonData;
}



@end

@implementation NSString (Number)

+(NSString *)stringWithDoubleInDecimalStyle:(double)num
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    return [formatter stringFromNumber:[NSNumber numberWithDouble:num]];
}
+(NSString *)stringWithDoubleInDecimalStyleKeekTwoDecimalPlaces:(double)num withDecimal:(NSInteger)count
{
    
    NSString *str = [NSString stringWithFormat:@"%@%@f",@"%",[NSString stringWithFormat:@".%ld",(long)num]];
    NSString *first = [NSString stringWithFormat:str,num];
    NSNumber *second = @([first doubleValue]);
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSString *doubleString = [formatter stringFromNumber:second];
    
    NSString *finalString = @"格式错误";
//    NSArray *stringArray = [doubleString componentsSeparatedByString:@"."];
    
//    if (stringArray.count == 1) {
////        finalString = [NSString stringWithFormat:@"%@.00",[stringArray firstObject]];
//    }else{
//        
//        NSString *secondString = stringArray[1];
//        
//        if (secondString.length == 1) {
//            finalString = [NSString stringWithFormat:@"%@.%@0",[stringArray firstObject],[stringArray[1] substringToIndex: 1]];
//        }else{
//            
//            finalString = [NSString stringWithFormat:@"%@.%@",[stringArray firstObject],[stringArray[1] substringToIndex:2]];
//        }
//    }
    //保留两位小数
    return finalString;
}


+(NSString *)stringWithDoubleInDecimalStyleKeekTwoDecimalPlaces:(double)num
{
    
    
    NSString *first = [NSString stringWithFormat:@"%.2f",num];
    NSNumber *second = @([first doubleValue]);
    
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterDecimalStyle;
    formatter.generatesDecimalNumbers = YES;
    formatter.maximumFractionDigits = num;
    NSString *doubleString = [formatter stringFromNumber:second];
    
    NSString *finalString = @"格式错误";
    NSArray *stringArray = [doubleString componentsSeparatedByString:@"."];
    
    if (stringArray.count == 1) {
        finalString = [NSString stringWithFormat:@"%@.00",[stringArray firstObject]];
    }else{
        
        NSString *secondString = stringArray[1];
        
        if (secondString.length == 1) {
            finalString = [NSString stringWithFormat:@"%@.%@0",[stringArray firstObject],[stringArray[1] substringToIndex: 1]];
        }else{
            
            finalString = [NSString stringWithFormat:@"%@.%@",[stringArray firstObject],[stringArray[1] substringToIndex:2]];
        }
    }
    //保留两位小数
    return finalString;
}


+ (NSMutableAttributedString *)moneyStyle:(double)num color:(UIColor *)color
{
    NSMutableAttributedString *moneyString =  [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ %@",[NSString stringWithDoubleInDecimalStyleKeekTwoDecimalPlaces:num],@"元"]];
    
    NSDictionary *attrsDic = @{NSForegroundColorAttributeName: color ? : DrakGrayColor,
                 NSFontAttributeName : [UIFont systemFontOfSize:18]};
    [moneyString addAttributes:attrsDic range:NSMakeRange(0, moneyString.length - 1)];
    attrsDic = @{NSForegroundColorAttributeName: DrakGrayColor,
                               NSFontAttributeName : [UIFont systemFontOfSize:18]};
    [moneyString addAttributes:attrsDic range:NSMakeRange(moneyString.length - 1, 1)];
    
    return moneyString;
}

- (NSString *)bigMoneyStyle
{
    
    if ([self floatValue] < 10000) {
        
        return [NSString stringWithFormat:@"%@元",[NSString stringWithDoubleInDecimalStyle:[self floatValue]]];
        
    }else if( [self floatValue] >= 10000  && [self floatValue] < 100000000) {
        
        NSMutableString *newString = [[NSMutableString alloc] initWithString:self];
        
        [newString insertString:@"." atIndex:self.length - 4];
//        NSString *lastFourNumber = [self substringFromIndex:self.length - 4];
//        
//        NSString *newNumber = [NSString ] [self substringToIndex:self.length - 4]
        
        return [NSString stringWithFormat:@"%@万",[NSString stringWithDoubleInDecimalStyle:[newString floatValue]]];
        
    }else if([self floatValue] >= 100000000){
        
        NSMutableString *newString = [[NSMutableString alloc] initWithString:self];
        
        [newString insertString:@"." atIndex:self.length - 8];
        
        return [NSString stringWithFormat:@"%@亿",[NSString stringWithDoubleInDecimalStyle:[newString floatValue]]];

        
    }
    
    return self;
}
/**
 *  验证  字符串 是否包含 一个大写一个小写字符 数字
 */
- (BOOL)validateNumber
{
    
    
    NSString *number =   @"^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])[a-zA-Z0-9].{7,15}$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [numberPre evaluateWithObject:self];
}
@end

