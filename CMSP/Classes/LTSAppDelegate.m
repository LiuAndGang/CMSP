//
//  LTSAppDelegate.m
//  CMSP
//
//  Created by 李棠松 on 2016/11/28.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#import "LTSAppDelegate.h"
#import "LTSTabBarController.h"
#import "LTSLoginViewController.h"
#import "LTSBaseNavigationController.h"
#import "JinnLockViewController.h"
@interface LTSAppDelegate ()<JinnLockViewControllerDelegate>
@property (nonatomic, strong) UINavigationController *navigationController;
@end

@implementation LTSAppDelegate


- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window{
    return UIInterfaceOrientationMaskPortrait;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //停留1s再进主界面---启动页
    [NSThread sleepForTimeInterval:1.0];
    
     [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];


    //是否自动登录
    BOOL isAutoLogin = [LTSUserDefault boolForKey:KPath_AutoLogin];
    
//    NSLog(@"isAutoLogin:%d",isAutoLogin);
    
    if (isAutoLogin) {

        LTSTabBarController *tabbar = [LTSTabBarController new];
        
        self.window.rootViewController = tabbar;
        
    }else{
        
        LTSLoginViewController *loginVC = [LTSLoginViewController new];
        LTSBaseNavigationController *loginNavi = [[LTSBaseNavigationController alloc]initWithRootViewController:loginVC];
        self.window.rootViewController = loginNavi;
    }


//    if (isAutoLogin && [JinnLockTool isGestureUnlockEnabled]) {
//        [self verify];
//    }
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)verify{
   
        JinnLockViewController *lockViewController = [[JinnLockViewController alloc] initWithDelegate:self
                                                                                                 type:JinnLockTypeVerify
                                                                                           appearMode:JinnLockAppearModePresent];
        self.window.rootViewController = lockViewController;
    
    
}

- (void)passcodeDidVerify:(NSString *)passcode{
    LTSTabBarController *tabbar = [LTSTabBarController new];
    
    self.window.rootViewController = tabbar;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

//app 被kill的时候执行的方法
- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    NSLog(@"%@",@"^^^^^^^^^^^^^^^^^^^^^^");
    if ([LTSUserDefault boolForKey:KPath_AutoLogin]) {
        [LTSUserDefault setBool:YES forKey:KPath_UserLoginState];
    }else{
        [LTSUserDefault setBool:NO forKey:KPath_UserLoginState];
  
    }
    
}


@end
