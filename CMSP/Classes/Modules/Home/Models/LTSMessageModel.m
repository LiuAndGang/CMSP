//
//  LTSMessageModel.m
//  CMSP
//
//  Created by 刘刚 on 2017/5/31.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import "LTSMessageModel.h"

@implementation LTSMessageModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _messageId = value;
    }else if ([key isEqualToString:@"title"]){
        _messageTitle = value;
    }
}

+(LTSMessageModel *)modelWithDict:(NSDictionary *)dict{
    
    LTSMessageModel *model = [LTSMessageModel new];
    [model setValuesForKeysWithDictionary:dict];
    return  model;
}

@end
