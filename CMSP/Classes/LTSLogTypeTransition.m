//
//  LTSLogTypeTransition.m
//  CMSP
//
//  Created by 刘刚 on 17/4/20.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import "LTSLogTypeTransition.h"

@implementation LTSLogTypeTransition

+(NSString *)logTypeTransition{
    

    NSString *login_user_type = [LTSUserDefault objectForKey:KPath_UserLoginType];
    NSInteger type = login_user_type.intValue;
    switch (type) {
        case 1:
            login_user_type = @"11";//个人手机
            break;
        case 2:
            login_user_type = @"12";//个人邮箱
            break;
        case 3:
            login_user_type = @"";//个人登录名
            break;
        case 4:
            login_user_type = @"";//企业客户号
            break;
        case 5:
            login_user_type = @"21";//企业手机
            break;
        case 6:
            login_user_type = @"22";//企业邮箱
            break;
        case 7:
            login_user_type = @"27";//企业用户名
            break;
        case -7:
            login_user_type = @"-7";//合作机构
            break;

        default:
            break;
    }
    return login_user_type;

}

@end
