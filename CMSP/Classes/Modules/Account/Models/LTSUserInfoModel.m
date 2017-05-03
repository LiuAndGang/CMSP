//
//  LTSUserInfoModel.m
//  CMSP
//
//  Created by 刘刚 on 17/4/12.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import "LTSUserInfoModel.h"

@implementation LTSUserInfoModel

static LTSUserInfoModel *_userInfo = nil;
+(instancetype)shareIntance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _userInfo = [[super allocWithZone:NULL] init];
    });
    return _userInfo;
}

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    return [LTSUserInfoModel shareIntance];
}




+(LTSUserInfoModel *)modelWithDict:(NSMutableDictionary *)dict{
    
    LTSUserInfoModel *model = [LTSUserInfoModel new];
    model.login_user_type = [dict[@"用户类型"] intValue];
    model.id_kind = dict[@"证件类型"];
    model.company_name = dict[@"公司名称"];
    model.org_code = dict[@"证件号码"];
    model.real_name = dict[@"真实姓名"];
    model.mobile_phone = dict[@"手机号"];

    return model;
}


//重写打印方法
-(NSString *)description{
    NSString *string = [NSString stringWithFormat:@"真实姓名:%@ \n手机号:%@ \n用户性质:%d \n公司名称:%@ \n证件类型:%@ \n证件号码:%@",self.real_name,self.mobile_phone,self.login_user_type,self.company_name,self.id_kind,self.org_code];
    return string;
}

@end
