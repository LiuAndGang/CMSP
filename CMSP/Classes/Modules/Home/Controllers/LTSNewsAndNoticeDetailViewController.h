//
//  LTSNewsAndNoticeDetailViewController.h
//  CMSP
//
//  Created by 刘刚 on 2017/6/1.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import "LTSBaseViewController.h"

@interface LTSNewsAndNoticeDetailViewController : LTSBaseViewController
/**详情标题*/
@property (nonatomic,copy) NSString *detailTitle;
/**详情内容*/
@property (nonatomic,copy) NSString *detailContext;
/**详情日期*/
@property (nonatomic,copy) NSString *detailDate;
/**发布人*/
@property(nonatomic,copy) NSString * detailPubUser;
/**大图*/
@property (nonatomic,copy) NSString *imageString;

/**导航标题*/
@property(nonatomic,copy) NSString * naviTitle;

/**公告页面传过来的参数，用来去掉公告详情的大图，和新闻详情做区分*/
@property (nonatomic,assign) int tap;


@end







