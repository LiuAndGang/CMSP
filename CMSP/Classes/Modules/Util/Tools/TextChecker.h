//
//  TextChecker.h
//  Common
//
//  Created by cameron on 14-7-4.
//  Copyright (c) 2014年 FamilyAlbum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextChecker : NSObject

+ (BOOL)isEmailAddress:(NSString *)text;
+ (BOOL)isTelephone:(NSString *)text;
+ (BOOL)isNumeric:(NSString *)text;
+ (BOOL)isEmptyOrNil:(NSString *)text;
+ (BOOL)isQQ:(NSString *)text;
+ (BOOL)isMSN:(NSString *)text;
+ (BOOL)isPasswordLegal:(NSString *)text;
+ (BOOL)isURLString:(NSString *)text;
//邮箱
+ (BOOL)isValidateEmail:(NSString *)email;
//手机号码验证
+ (BOOL)isValidateMobile:(NSString *)mobile;
//车牌号验证
+ (BOOL)isValidateCarNo:(NSString *)carNo;
//车型
+ (BOOL)isValidateCarType:(NSString *)CarType;
//用户名
+ (BOOL)isValidateUserName:(NSString *)name;
//密码
+ (BOOL)isValidatePassword:(NSString *)passWord;
//昵称
+ (BOOL)isValidateNickname:(NSString *)nickname;
//身份证号
+ (BOOL)isValidateIdentityCard: (NSString *)identityCard;

+ (void)openVersionURLString;

@end
