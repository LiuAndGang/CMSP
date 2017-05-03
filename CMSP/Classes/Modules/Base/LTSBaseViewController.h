//
//  LTSBaseViewController.h
//  SAIFAMC
//
//  Created by 李棠松 on 16/8/15.
//  Copyright © 2016年 leetangsong. All rights reserved.
//

#import <UIKit/UIKit.h>



typedef NS_ENUM(NSUInteger, BackType){
    
    BackTypeToHome,
    BackTypePop
    
};

@interface LTSBaseViewController : UIViewController

@property (nonatomic,weak)UIViewController *superVC;

- (void)initData;
- (void)initUI;
- (void)addEvents;
- (void)initNav;
- (void)leftBarButtonClick;
- (void)removeViewControllerAtIndexs:(NSIndexSet*)indexSet;

@end
