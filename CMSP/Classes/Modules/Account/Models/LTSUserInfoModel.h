//
//  LTSUserInfoModel.h
//  CMSP
//
//  Created by 刘刚 on 17/4/12.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTSUserInfoModel : NSObject

/**用户类型*/
@property (nonatomic,assign) int login_user_type;
/**证件类型*/
@property (nonatomic,copy) NSString *id_kind;
/**公司名称*/
@property (nonatomic,copy) NSString *company_name;
/**证件号码*/
@property (nonatomic,copy) NSString *org_code;
/**联系人*/
@property (nonatomic,copy) NSString *real_name	;
/**手机号码*/
@property (nonatomic,copy) NSString *mobile_phone;

+(instancetype)shareIntance;
+(instancetype)allocWithZone:(struct _NSZone *)zone;
+(LTSUserInfoModel *)modelWithDict:(NSMutableDictionary *)dict;


@end
