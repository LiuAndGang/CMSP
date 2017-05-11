//
//  URLConst.h
//  CMSP
//
//  Created by 李棠松 on 2016/12/7.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#ifndef URLConst_h
#define URLConst_h

//http://183.62.44.126:11801 正式库
//http://192.168.2.117:8080  测试库

#define kLTSDBBaseUrl  @"http://oss.utrustfrg.com:11801/accountPlatform/"
//#define kLTSDBBaseUrl  @"http://192.168.2.117:8080/accountPlatform/"


#pragma mark  ---- 登录 ----
//登录  auth_login_acct	用户类型，3:个人用户名 ; 7:企业用户名；2个人邮箱 ，6企业邮箱
//logName	登录名
//password	密码
#define kLTSDBLogin @"accountUserInterAction!login.action"

//登出
#define KLTSDBLogout @"accountUserInterAction!logout.action"

//注册
#define kLTSDBRegUser @"accountUserInterAction!regUser.action"

//获取用户详情
#define KLTSDBGainUserInfo @"accountUserInterAction!selectAccountUser.action"

//修改客户信息
#define KLTSDBChangeUserInfo @"accountUserInterAction!updateAccountUser.action"

#pragma mark ---- 首页 ----
///业务介绍
#define kLTSDBBusinessIntroduction  @"account/front/main/businessIntroduction.jsp"
///经典案例
#define kLTSDBClassicCase  @"account/front/main/caseIntroduction.jsp"

///再担保  等等 传参数 productCode  (R-再担保) (F-直保融资) (N-直保非融资)(无参-担保体系)
#define kLTSDBCoreBusiness @"account/front/main/coreBusiness.jsp"

//项目
#define KLTSDBProject @"account/front/main/myProject.jsp"

//免责声明
#define KLTSDBDisclaimer @"account/front/main/disclaimer.jsp"

//关于
#define KLTSDBComponyIntro @"account/front/main/about.jsp"

#endif /* URLConst_h */
