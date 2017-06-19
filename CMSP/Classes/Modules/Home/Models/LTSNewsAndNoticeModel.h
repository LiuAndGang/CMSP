//
//  LTSNewsAndNoticeModel.h
//  CMSP
//
//  Created by 刘刚 on 2017/5/23.
//  Copyright © 2017年 李棠松. All rights reserved.


//注：公告和新闻的数据模型

#import <Foundation/Foundation.h>

@interface LTSNewsAndNoticeModel : NSObject
/**标题*/
@property(nonatomic,copy) NSString * mainTitle;
/**内容*/
@property(nonatomic,copy) NSString * context;
/**发布人名字*/
@property(nonatomic,copy) NSString * publicUserName;
/**发布时间*/
@property(nonatomic,copy) NSString * publicDate;
/**新闻图片*/
@property(nonatomic,copy) NSString * imageString;



+(LTSNewsAndNoticeModel *)modelWithDict:(NSDictionary *)dict;

@end
