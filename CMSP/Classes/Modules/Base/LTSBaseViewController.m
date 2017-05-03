//
//  LTSBaseViewController.m
//  SAIFAMC
//
//  Created by 李棠松 on 16/8/15.
//  Copyright © 2016年 leetangsong. All rights reserved.
//

#import "LTSBaseViewController.h"

@interface LTSBaseViewController ()<UIScrollViewDelegate>

@end

@implementation LTSBaseViewController
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[UIMenuController sharedMenuController] setMenuVisible:NO animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self initNav];
    [self addEvents];
    [self initData];
    
    self.view.backgroundColor = BGColorGray;
//    self.automaticallyAdjustsScrollViewInsets = YES;
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if ([self findKeyboard]) {
        [self.view endEditing:YES];
    }
}


- (UIView *)findKeyboard
{
    UIView *keyboardView = nil;
    NSArray *windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *window in [windows reverseObjectEnumerator])//逆序效率更高，因为键盘总在上方
    {
        keyboardView = [self findKeyboardInView:window];
        if (keyboardView)
        {
            return keyboardView;
        }
    }
    return nil;
}
- (UIView *)findKeyboardInView:(UIView *)view
{
    for (UIView *subView in [view subviews])
    {
        if (strstr(object_getClassName(subView), "UIKeyboard"))
        {
            return subView;
        }
        else
        {
            UIView *tempView = [self findKeyboardInView:subView];
            if (tempView)
            {
                return tempView;
            }
        }
    }
    return nil;
}
- (void)leftBarButtonClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)removeViewControllerAtIndexs:(NSIndexSet*)indexSet{
    NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
    [viewControllers removeObjectsAtIndexes:indexSet];
    self.navigationController.viewControllers = viewControllers;
    
}
- (void)initNav{
    
}
- (UIViewController *)superVC{
    if (!_superVC) {
        if (self.navigationController.viewControllers.count>1) {
            _superVC = self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
        }
        else _superVC = nil;
        
    }
    return _superVC;
}
- (void)initUI{

}
- (void)addEvents{

}

- (void)initData{
  
}
-(void)dealloc{
   [LTSNotification removeObserver:self];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
