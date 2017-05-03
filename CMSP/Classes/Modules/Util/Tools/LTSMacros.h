//
//  LTSMacros.h
//  SAIFAMC
//
//  Created by 李棠松 on 16/8/14.
//  Copyright © 2016年 leetangsong. All rights reserved.
//

#ifndef LTSMacros_h
#define LTSMacros_h
//** 沙盒路径 ***********************************************************************************
#define PATH_OF_APP_HOME    NSHomeDirectory()
#define PATH_OF_TEMP        NSTemporaryDirectory()
#define PATH_OF_DOCUMENT   [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
/* ****************************************************************************************************************** */
/** DEBUG LOG **/
#ifdef DEBUG
#define NSLog(format, ...) printf("\n[%s] %s [第%d行] %s\n", __TIME__, __FUNCTION__, __LINE__, [[NSString stringWithFormat:format, ## __VA_ARGS__] UTF8String]);
#else
#define NSLog(format, ...)
#endif

/** DEBUG RELEASE **/
#if DEBUG

#endif



#define MCRelease(x)            x = nil

#pragma mark - Frame (宏 x, y, width, height)
#define X(v)                    (v).frame.origin.x
#define Y(v)                    (v).frame.origin.y
#define WIDTH(v)                (v).frame.size.width
#define HEIGHT(v)               (v).frame.size.height
#define BWIDTH(v)               (v).bounds.size.width
#define BHEIGHT(v)              (v).bounds.size.height

#define IMAGEWIDTH(v)           (v).size.width
#define IMAGEHEIGHT(v)          (v).size.height


#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)

//  ********************************************        ******************************************* //
//#define USERGETINFOSAVE_DEFAULTS [NSUserDefaults standardUserDefaults]

// App Frame
#define Application_Frame       [[UIScreen mainScreen] applicationFrame]

// App Frame Height&Width
#define Screen_Height        [[UIScreen mainScreen] bounds].size.height
#define Screen_Width         [[UIScreen mainScreen] bounds].size.width

// 判断手机类型  ipad类型
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
// 是否高清屏
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_MAX_LENGTH (MAX(Main_Screen_Width, Main_Screen_Height))
#define SCREEN_MIN_LENGTH (MIN(Main_Screen_Width, Main_Screen_Height))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)

// 系统控件默认高度
#define kStatusBarHeight        (20.f)
#define kTopBarHeight           (44.f)
#define kTopBarWithStatusHeight (64.f)
#define kBottomBarHeight        (49.f)
#define kEffectiveViewHeight    (Screen_Height-64)
#define kTabbarEffectiveViewHeight (Screen_Height-113)
#define kPaddingLeftWidth 10.f

#define kTCellHeight ((IS_IPHONE_6P||IS_IPAD)?kBottomBarHeight:kTopBarHeight)

#define NLSystemVersionGreaterOrEqualThan(version) ([[[UIDevice currentDevice] systemVersion] floatValue] >= version)
#define IOS7_OR_LATER NLSystemVersionGreaterOrEqualThan(7.0)
#define IOS9_OR_LATER NLSystemVersionGreaterOrEqualThan(9.0)
#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

// 是否iPhone5
#define isiPhone5               ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? \
CGSizeEqualToSize(CGSizeMake(640, 1136), \
[[UIScreen mainScreen] currentMode].size) : \
NO)
/* ***************************************************************** */
#pragma mark - Funtion Method (宏 方法)

// PNG JPG 图片路径
#define PNGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"png"]
#define JPGPATH(NAME)           [[NSBundle mainBundle] pathForResource:[NSString stringWithUTF8String:NAME] ofType:@"jpg"]
#define PATH(NAME, EXT)         [[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]

// 加载图片
#define PNGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"png"]]
#define JPGIMAGE(NAME)          [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:@"jpg"]]
#define IMAGE(NAME, EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]
#define IMAGE(NAME, EXT)        [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:(NAME) ofType:(EXT)]]

// 字体大小(常规/粗体)
#define BOLDSYSTEMFONT(FONTSIZE)[UIFont boldSystemFontOfSize:FONTSIZE]
#define SYSTEMFONT(FONTSIZE)    [UIFont systemFontOfSize:FONTSIZE]
#define FONT(NAME, FONTSIZE)    [UIFont fontWithName:(NAME) size:(FONTSIZE)]

// 颜色(RGB)
#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

// RGB颜色转换（16进制->10进制）
#define HexColor(hex)   [UIColor colorWithHexString:hex alpha:1]
#define UIColorFromRGB(rgbValue)\
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:1.0]

#define UIColorFromRGBA(rgbValue, a) \
\
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 \
alpha:a]

//  app 整体色调 颜色值
#define WholeColor UIColorFromRGB(0x3CB371) //RGBCOLOR(28, 144, 238)//
#define ViewBackColor RGBCOLOR(235, 235, 241)
#define RedIconColor UIColorFromRGB(0xCD2626)

/// View 圆角和加边框
#define ViewBorderRadius(View, Radius, BorderWidth, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(BorderWidth)];\
[View.layer setBorderColor:[Color CGColor]]

/// View 圆角
#define ViewRectCornerRadius(View, UIRectCorner,Radius)\
{\
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:View.bounds byRoundingCorners:UIRectCorner cornerRadii:CGSizeMake(Radius, Radius)];\
CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];\
maskLayer.frame = View.bounds;\
maskLayer.path = maskPath.CGPath;\
View.layer.mask = maskLayer;\
}
#define ViewRadius(View, Radius)\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES]

// View 阴影
#define ViewBordershadow(View, Radius, Width, Ity)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:NO];\
[View.layer setShadowColor:[[UIColor blackColor] CGColor]];\
[View.layer setShadowOffset:CGSizeMake(0.f, Width)];\
[View.layer setShadowOpacity:Ity];\
[View.layer setShadowRadius:Width]

// **********   GCD 线程   延迟调用   **********   //
#define Dispatch_AfterCall(time, method) \
\
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(time * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{method;});
// 当前版本
//#define FSystemVersion          ([[[UIDevice currentDevice] systemVersion] floatValue])
//#define DSystemVersion          ([[[UIDevice currentDevice] systemVersion] doubleValue])
//#define SSystemVersion          ([[UIDevice currentDevice] systemVersion])
//应用程序的名字  和  版本
#define AppDisplayName          [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define AppDisplayVersion       [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"]

// 当前语言
#define CURRENTLANGUAGE         ([[NSLocale preferredLanguages] objectAtIndex:0])

// UIView - viewWithTag
#define VIEWWITHTAG(_OBJECT, _TAG)\
\
[_OBJECT viewWithTag : _TAG]

// 本地化字符串
/** NSLocalizedString宏做的其实就是在当前bundle中查找资源文件名“Localizable.strings”(参数:键＋注释) */
//  本地 国际化语言
#define LocalizedTitle(v) NSLocalizedString(v, @"")
/** NSLocalizedStringFromTable宏做的其实就是在当前bundle中查找资源文件名“xxx.strings”(参数:键＋文件名＋注释) */
#define AppLocalString(x, ...)  NSLocalizedStringFromTable(x, @"someName", nil)

#if TARGET_OS_IPHONE
/** iPhone Device */
#endif

#if TARGET_IPHONE_SIMULATOR
/** iPhone Simulator */
#endif

// ARC
#if __has_feature(objc_arc)
/** Compiling with ARC */
#else
/** Compiling without ARC */
#endif

#define kAppDelegate (LTSAppDelegate *)[UIApplication sharedApplication].delegate

#define NSStringFromInt(int)        [NSString stringWithFormat:@"%ld", (long)int]
#define NSStringFromFloat(float)    [NSString stringWithFormat:@"%f", float]
#define NSStringFromStr(str)        [NSString stringWithFormat:@"%@", str]
//#define NSNumberFromFloat(float)        [NSNumber numberWithFloat:float]
//#define NSNumberFromInt(int)        [NSNumber numberWithInt:int]

//计算线条宽度函数
#define LineWidth(CGFloat) CGFloat / [UIScreen mainScreen].scale

//#define dividingLineColor [UIColor colorWithWhite:0.05 alpha:0.3]  //  颜色值
#define loadingBackGround [UIColor colorWithWhite:0.1 alpha:0.7]
#define loadingBackRadius 3.f

#define APPKeyWindow ([[UIApplication sharedApplication] keyWindow])
#define WEAKSELF typeof(self) __weak weakSelf = self;

#define ESWeak(var, weakVar) __weak __typeof(&*var) weakVar = var
#define ESStrong_DoNotCheckNil(weakVar, _var) __typeof(&*weakVar) _var = weakVar
#define ESStrong(weakVar, _var) ESStrong_DoNotCheckNil(weakVar, _var); if (!_var) return;

#define ESWeak_(var) ESWeak(var, weak_##var);
#define ESStrong_(var) ESStrong(weak_##var, _##var);

/** defines a weak `self` named `__weakSelf` */
#define ESWeakSelf      ESWeak(self, __weakSelf);
/** defines a strong `self` named `_self` from `__weakSelf` */
#define ESStrongSelf    ESStrong(__weakSelf, _self);

//链接颜色
#define kLinkAttributes     @{(__bridge NSString *)kCTUnderlineStyleAttributeName : [NSNumber numberWithBool:YES],(NSString *)kCTForegroundColorAttributeName : (__bridge id)UIColorFromRGB(0x4682B4).CGColor}
#define kLinkAttributesActive       @{(NSString *)kCTUnderlineStyleAttributeName : [NSNumber numberWithBool:YES],(NSString *)kCTForegroundColorAttributeName : (__bridge id)UIColorFromRGB(0x696969).CGColor}

#endif /* LTSMacros_h */
