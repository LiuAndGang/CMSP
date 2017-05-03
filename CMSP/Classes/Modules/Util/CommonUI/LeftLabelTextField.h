//
//  QWLeftLabelTextField.h
//  QuWorking
//
//  Created by 刘宇健 on 15/11/1.
//  Copyright © 2015年 HuikeSpace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftLabelTextField : UITextField

@property (nonatomic, copy) NSString *labelText;

-(instancetype)initWithTitle:(NSString *)title placeHolder:(NSString *)placeHolder;


@end
