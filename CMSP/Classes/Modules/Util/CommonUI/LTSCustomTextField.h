//
//  LTSCustomTextField.h
//  CMSP
//
//  Created by 李棠松 on 2016/12/1.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger,LTSCustomTextFieldBorderType){
    LTSCustomTextFieldBorderTypeNone = 0,
    LTSCustomTextFieldBorderTypeBottom
};
@interface LTSCustomTextField : UITextField
///边框类型
@property (nonatomic,assign)LTSCustomTextFieldBorderType borderType;


/**
 左边没有试图条件下 字的偏移
 */
- (void)setLeftOffset:(CGFloat)offset;

/**
 创建一个左边图片的textField

 @param icon 图片名字
 @return textField
 */
+ (instancetype)textFieldWithleftImageIcon:(NSString *)icon;

- (void)setLeftTitleText:(NSString *)title;

@end
