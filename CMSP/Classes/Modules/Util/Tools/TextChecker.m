//
//  TextChecker.m
//  Common
//
//  Created by cameron on 14-7-4.
//  Copyright (c) 2014年 FamilyAlbum. All rights reserved.
//

#import "TextChecker.h"
#import <UIKit/UIKit.h>
@interface TextChecker ()

+ (BOOL)checkWithPattern:(NSString *)pattern text:(NSString *)text;

@end

@implementation TextChecker

+ (BOOL)checkWithPattern:(NSString *)pattern text:(NSString *)text
{
    if (!text) {
        return NO;
    }
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    return [predicate evaluateWithObject:text];
}

+ (BOOL)isEmailAddress:(NSString *)text
{
    NSString *pattern = @"^\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b$";
    return [TextChecker checkWithPattern:pattern text:text];
}

+ (BOOL)isTelephone:(NSString *)text
{
    NSString *pattern = @"^[1][34578][0-9]{9}$";
    return [TextChecker checkWithPattern:pattern text:text];
}

+ (BOOL)isNumeric:(NSString *)text
{
    NSString *pattern = @"^[1-9]\\d*$";
    return [TextChecker checkWithPattern:pattern text:text];
}

+ (BOOL)isQQ:(NSString *)text
{
    NSString *pattern = @"^[1-9][0-9]{4,}$";
    return [TextChecker checkWithPattern:pattern text:text];
}

+ (BOOL)isMSN:(NSString *)text
{
    NSString *pattern = @"^\\w+@hotmail\\.com$";
    return [TextChecker checkWithPattern:pattern text:text];
}

+ (BOOL)isEmptyOrNil:(NSString *)text
{
    BOOL b = (!text || text.length == 0);
    return b;
}

+ (BOOL)isPasswordLegal:(NSString *)text
{
    NSString *pattern  =@"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,20}$";
    return [TextChecker checkWithPattern:pattern text:text];
}

+ (BOOL)isURLString:(NSString *)text
{
    //        NSString *pattern = @"\\b(([\\w-]+://?|www[.])[^\\s()<>]+(?:\\([\\w\\d]+\\)|([^[:punct:]\\s]|/)))";
    //        return [TextChecker checkWithPattern:pattern text:text];
    if (!text) return NO;
    BOOL canOpen = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:text]];
    return canOpen;
}
//邮箱
+ (BOOL)isValidateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [TextChecker checkWithPattern:emailRegex text:email];
}
//手机号码验证
+ (BOOL)isValidateMobile:(NSString *)mobile
{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    return [TextChecker checkWithPattern:phoneRegex text:mobile];
}
//车牌号验证
+ (BOOL)isValidateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    return [TextChecker checkWithPattern:carRegex text:carNo];
}
//车型
+ (BOOL)isValidateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    return [TextChecker checkWithPattern:CarTypeRegex text:CarType];
}
//用户名
+ (BOOL)isValidateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    return [TextChecker checkWithPattern:userNameRegex text:name];
}
//密码
+ (BOOL)isValidatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    return [TextChecker checkWithPattern:passWordRegex text:passWord];
}
//昵称
+ (BOOL)isValidateNickname:(NSString *)nickname
{
    NSString *nicknameRegex = @"^[\u4e00-\u9fa5]{4,8}$";
    return [TextChecker checkWithPattern:nicknameRegex text:nickname];
}
//身份证号
+ (BOOL)isValidateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    return [TextChecker checkWithPattern:regex2 text:identityCard];
}


@end
