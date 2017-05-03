//
//  CleanCache.h
//  baozouba
//
//  Created by qianfeng on 16/7/24.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CleanCache : NSObject
//计算文件大小
-(long long)fileSizeAtPath:(NSString*)filePath;
//获取缓存路径
-(NSString *)getCachesPath;
//计算文件夹大小
-(float)getCacheSizeAtPath:(NSString*)folderPath;
//清理缓存
+(void)clearCacheAtPath:(NSString *)path;

@end
