//
//  LTSNoticeCell.h
//  CMSP
//
//  Created by Drosea10 on 2017/6/14.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTSNewsAndNoticeModel;

@interface LTSNoticeCell : UITableViewCell

@property (nonatomic,weak)  UILabel *titleLabel;
@property (nonatomic,weak)  UILabel *detailLabel;
@property (nonatomic,weak)  UILabel *dateLabel;

@property (nonatomic,strong) LTSNewsAndNoticeModel *model;


@end
