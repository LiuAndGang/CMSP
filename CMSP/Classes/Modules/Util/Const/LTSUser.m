//
//  JSUser.m
//  SAIFAMC
//
//  Created by leetangsong_macbk on 16/4/14.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import "LTSUser.h"

@implementation LTSUser

MJCodingImplementation

- (instancetype)init
{
    self = [super init];
    if (self) {
       self.headImage = @"";

    }
    return self;
}

+(LTSUser *)userFromData:(NSData *)data{
    if (!data) {
        return [LTSUser new];
    }
    
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}



- (void)setSex:(NSString *)sex{
    _sex = sex;
    if ([sex isEqualToString:@"sex_1"]) {
        _sex = @"女";
    }
    else _sex = @"男";
}


- (NSData *)dataFromUser{
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}
@end
