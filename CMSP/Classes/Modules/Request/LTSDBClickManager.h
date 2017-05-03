//
//  LTSDBClickManager.h
//  SAIFAMC
//
//  Created by leetangsong_macbk on 16/4/13.
//  Copyright © 2016年 macbook. All rights reserved.
//



typedef void(^LTSDBClickResponseBlock)(id responseObject,NSError *error);


typedef void (^CheckVersionBlock)(NSDictionary *dic);
@interface LTSDBClickManager : AFHTTPSessionManager
@property (nonatomic,copy)NSString *token;
///hah
@property (nonatomic,copy)NSString *sessionID;


+ (instancetype)sharedManager;

- (NSURLSessionDataTask *)POST:(NSString *)path
                        params:(NSDictionary *)parameters
                         block:(LTSDBClickResponseBlock)block;
- (NSURLSessionDataTask *)GET:(NSString *)path
                       params:(NSDictionary *)parameters
                        block:(LTSDBClickResponseBlock)block;


- (NSURLSessionDataTask *)UP_POST:(NSString *)path params:(NSDictionary *)parameters andImageName:(NSString*)imageName dataName:(NSString *)name mimeType:(NSString *)mimeType datas:(NSArray<NSData *>*)datas block:(LTSDBClickResponseBlock)block;

///文件  image/png
- (NSURLSessionDataTask *)UP_POST:(NSString *)path params:(NSDictionary *)parameters andFileName:(NSString*)fileName progress:(void (^)(NSProgress * ))uploadProgress type:(NSString *)type dataName:(NSString *)name mimeType:(NSString *)mimeType data:fileData block:(LTSDBClickResponseBlock)block;



- (void)checkVersionWithBlock:(CheckVersionBlock)block;

@end
