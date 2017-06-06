//
//  LTSNewsAndNoticeModel.m
//  CMSP
//
//  Created by 刘刚 on 2017/5/23.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import "LTSNewsAndNoticeModel.h"

@implementation LTSNewsAndNoticeModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"title"]) {
        _mainTitle  = value;
    }else if ([key isEqualToString:@"files"]){
        _imageString = value;
    }
    
}

+(LTSNewsAndNoticeModel *)modelWithDict:(NSDictionary *)dict
{
    
    LTSNewsAndNoticeModel *model = [LTSNewsAndNoticeModel new];
    [model setValuesForKeysWithDictionary:dict];
//    model.mainTitle = dict[@"title"];
//    model.context = dict[@"context"];
//    model.publicUserName = dict[@"publicUserName"];
//    model.publicDate  = dict[@"publicDate"];
    
    return  model;
}

@end
