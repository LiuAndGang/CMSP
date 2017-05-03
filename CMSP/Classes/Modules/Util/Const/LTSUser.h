//
//  JSUser.h
//  SAIFAMC
//
//  Created by leetangsong_macbk on 16/4/14.
//  Copyright © 2016年 macbook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LTSUser : NSObject<NSCoding>
@property (nonatomic,assign) NSInteger userID;

@property (nonatomic,copy)NSString *userName;

@property (nonatomic,copy) NSString *nickName;

@property (nonatomic,copy) NSString *autograph;

@property (nonatomic,copy)NSString *mobilePhone;

@property (nonatomic,copy) NSString *eMail;
@property (nonatomic,copy) NSString *addressLocation;

@property (nonatomic,copy) NSString *headImage;

@property (nonatomic,copy) NSString *twoDimensionCode;
@property (nonatomic,copy) NSString *remark;

@property (nonatomic,copy)NSString *password;


@property (nonatomic,copy) NSString *sex;



+(LTSUser *)userFromData:(NSData *)data;

- (NSData *)dataFromUser;
@end
