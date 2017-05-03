//
//  LTSDBClickManager.m
//  SAIFAMC
//
//  Created by leetangsong_macbk on 16/4/13.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "LTSDBClickManager.h"
#import "LTSAppDelegate.h"
#import "LTSTabBarController.h"
//#import "JSLoginViewController.h"
//#import "JSChangePassWordViewController.h"
#import "LTSBaseNavigationController.h"
@implementation LTSDBClickManager


+ (instancetype)sharedManager{
    static LTSDBClickManager *_sharedClient = nil;
    static dispatch_once_t onceToken;
   
    dispatch_once(&onceToken, ^{
        
       
        
        NSString *baseUrl = kLTSDBBaseUrl;
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        _sharedClient.securityPolicy.allowInvalidCertificates=YES;
        _sharedClient.securityPolicy.validatesDomainName=NO;
        
        //关闭缓存避免干扰测试
        
        _sharedClient.requestSerializer.cachePolicy=NSURLRequestReloadIgnoringLocalCacheData;
        
        
        
//        _sharedClient.securityPolicy.SSLPinningMode = AFSSLPinningModeCertificate;
        _sharedClient.requestSerializer = [AFJSONRequestSerializer new];
        _sharedClient.responseSerializer =[AFHTTPResponseSerializer serializer];
        _sharedClient.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];
        
        _sharedClient.requestSerializer.HTTPMethodsEncodingParametersInURI = [NSSet setWithArray:@[@"POST", @"GET", @"HEAD"]];
        
        
    });
    
//    if (LTSUserDes.token.length) {
//        
//        
//        NSArray *strs =   [LTSUserDes.token componentsSeparatedByString:@"_"];
//        _sharedClient.sessionID = [strs lastObject];
//        [_sharedClient.requestSerializer setValue:[@"JSESSIONID=" stringByAppendingString:_sharedClient.sessionID] forHTTPHeaderField:@"Cookie"];
//        [_sharedClient.requestSerializer setValue:LTSUserDes.token forHTTPHeaderField:@"token"];
//        
//    }
    
    
    return _sharedClient;
    
}

#pragma mark - Requests



- (NSURLSessionDataTask *)POST:(NSString *)path params:(NSDictionary *)parameters block:(LTSDBClickResponseBlock)block{
   
    //    self.hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow.rootViewController.view animated:YES];
    
    NSParameterAssert(block);
    NSURLSessionDataTask *task;
    NSMutableDictionary *params = parameters ? [parameters mutableCopy] : [NSMutableDictionary new];
//    params[@"appCode"] = @"ucg_appinterface";
   
    
    
   task = [self POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
       [self getTokenAndSession:responseObject];
       NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
       
       
       NSError *jsonError;
        id res = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
       if (!jsonError) {
           block(res,nil);
//           NSLog(@"%@",res);
       }
       else{
           block(str,nil);
//           NSLog(@"%@",str);
       }
       
     
       
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       NSLog(@"%@",error);
       block(nil,error);
   }];
    
    NSLog(@"%@", task.currentRequest.URL);
    return task;
    
    
}


- (NSURLSessionDataTask *)GET:(NSString *)path params:(NSDictionary *)parameters block:(LTSDBClickResponseBlock)block{
    //   __block MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].keyWindow.rootViewController.view animated:YES];
   
    NSParameterAssert(block);
    NSURLSessionDataTask *task;
    NSMutableDictionary *params = parameters ? [parameters mutableCopy] : [NSMutableDictionary new];
//   params[@"appCode"] = @"ucg_appinterface";
    
   
    
    
   
    
    task = [self GET:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self getTokenAndSession:responseObject];
        NSLog(@"%@",responseObject);
        block(responseObject,nil);
//         [self resultCode:responseObject];
        //        [hud hide:YES];
        //        hud = nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil,error);
        //        [hud hide:YES];
        //        hud = nil;
    }];
    NSLog(@"%@", task.currentRequest.URL);
    return task;
}




//文件
- (NSURLSessionDataTask *)UP_POST:(NSString *)path params:(NSDictionary *)parameters andFileName:(NSString*)fileName progress:( void (^)(NSProgress *))uploadProgress type:(NSString *)type dataName:(NSString *)name mimeType:(NSString *)mimeType data:fileData block:(LTSDBClickResponseBlock)block{
   
    NSParameterAssert(block);
    NSURLSessionDataTask *task;
    NSMutableDictionary *params = parameters ? [parameters mutableCopy] : [NSMutableDictionary new];
    // params[@"token"] = self.token;
//    params[@"appCode"] = @"ucg_appinterface";
    
    task = [self POST:path parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
            NSString *filename ;
            if (type.length) {
              filename  = [NSString stringWithFormat:@"%@.%@",fileName,type];
            }else{
                filename = fileName;
            }
            [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
        
    } progress:uploadProgress  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        
        NSError *jsonError;
        id res = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&jsonError];
        NSLog(@"%@",res);
        [self getTokenAndSession:responseObject];
        
        block(res,nil);
        
//        [self resultCode:responseObject];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        block(nil,error);
    }];
    
    NSLog(@"%@", task.currentRequest.URL);
    return task;
    
}



//- (void)resultCode:(id)responseObject{
//    if ([responseObject[@"success"] isEqual:@0]) {
//       
//        if (![responseObject[@"resultCode"] isKindOfClass:[NSNull class]]) {
//            
//        
//        LTSTabBarController *tabbar = nil;
//        if ([JSAAppDelegated.window.rootViewController isKindOfClass:[JSTabBarController class]]) {
//           tabbar = (JSTabBarController*)JSAAppDelegated.window.rootViewController;
//            
//            
//        }
//        
//        //密码过期需要强制修改密码
//        if ([responseObject[@"resultCode"] isEqualToString:@"updatePassword"]) {
//             [ActivityHub ShowHub:@"密码过期需要强制修改密码"];
//            UINavigationController *currentVC = tabbar.selectedViewController;
//            [currentVC pushViewController:[JSChangePassWordViewController new] animated:YES];
//            
//            
//            
//        }
//        //使用系统初始化密码 需要修改密码
//        if ([responseObject[@"resultCode"] isEqualToString:@"isInitPwd"]) {
//            [ActivityHub ShowHub:@"使用系统初始化密码 需要修改密码"];
//            UINavigationController *currentVC = tabbar.selectedViewController;
//            [currentVC pushViewController:[JSChangePassWordViewController new] animated:YES];
//        }
//        //校验用户token失败，需从新登陆
//        if ([responseObject[@"resultCode"] isEqualToString:@"loadError"]) {
//            
//            [ActivityHub ShowHub:@"校验用户token失败，需从新登陆"];
//           
//            JSLoginViewController *login = [JSLoginViewController new];
//            JSBaseNavigationController *loginNavi = [[JSBaseNavigationController alloc]initWithRootViewController:login];
//            [tabbar presentViewController:loginNavi animated:YES completion:^{
//                JSAAppDelegated.window.rootViewController = loginNavi;
//            }];
//        }
//        //密码错误，需从新登陆
//        if ([responseObject[@"resultCode"] isEqualToString:@"reload"]) {
//            [ActivityHub ShowHub:@"密码错误，需从新登陆"];
//           
//            JSLoginViewController *login = [JSLoginViewController new];
//            JSBaseNavigationController *loginNavi = [[JSBaseNavigationController alloc]initWithRootViewController:login];
//            [tabbar presentViewController:loginNavi animated:YES completion:^{
//                JSAAppDelegated.window.rootViewController = loginNavi;
//            }];
//        }
//        
//      }
//    }
//}

- (void)getTokenAndSession:(id)responseObject{
    
//    if (responseObject[@"token"]) {
//        JSUser *user = JSUserDes;
//        user.token = responseObject[@"token"];
//        [JSUserDefault setObject:[user dataFromUser]  forKey:KPath_UserDes];
////        NSArray *strs =   [JSUserDes.token componentsSeparatedByString:@"_"];
////        self.sessionID = [strs lastObject];
//    }
    
}



- (void)checkVersionWithBlock:(CheckVersionBlock)block{

    AFHTTPSessionManager *manager  = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@"http://api.fir.im/apps/"]];
    
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    param[@"bundle_id"] = @"com.workhc.JoinShare";
    param[@"api_token"] = @"f39025245827e7b14edec421bc650168";
    param[@"type"] = @"ios";
    [manager GET:@"latest/572076fd00fc74468e000007" parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        dic[@"versionShort"] = responseObject[@"versionShort"];
        dic[@"changelog"] = responseObject[@"changelog"];
        dic[@"update_url"] = responseObject[@"update_url"];
        block(dic);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}


@end
