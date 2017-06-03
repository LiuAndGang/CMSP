//
//  LTSMessageModel.h
//  CMSP
//
//  Created by 刘刚 on 2017/5/31.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTSMessageModel : NSObject
/**消息ID*/
@property(nonatomic,copy) NSString * messageId;
/**项目ID*/
@property(nonatomic,copy) NSString * projectId;
/**客服系统标识*/
@property(nonatomic,copy) NSString * clientId;
/**消息标题*/
@property(nonatomic,copy) NSString * messageTitle;
/**消息内容*/
@property(nonatomic,copy) NSString * context;
/**消息状态*/
@property(nonatomic,copy) NSString * status;
/**消息日期*/
@property(nonatomic,copy) NSString * messageDate;

+(LTSMessageModel *)modelWithDict:(NSDictionary *)dict;

@end
