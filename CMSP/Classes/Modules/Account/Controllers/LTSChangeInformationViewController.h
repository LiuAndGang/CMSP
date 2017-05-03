//
//  LTSChangeInformationViewController.h
//  SAIFAMC
//
//  Created by leetangsong_macbk on 16/4/15.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "LTSBaseViewController.h"


typedef void(^UpdateSuccessBlock)(NSString *);
@interface LTSChangeInformationViewController : LTSBaseViewController

@property (nonatomic, strong) UITextField *tf_title;
/**
 *  更新成功Block
 */
@property (nonatomic, copy) UpdateSuccessBlock updateSuccessBlck;

- (instancetype)initWithNavTitle:(NSString *)nav_title message:(NSString *)message title:(NSString *)title;

@end
