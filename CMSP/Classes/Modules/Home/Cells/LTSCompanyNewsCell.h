//
//  LTSCompanyNewsCell.h
//  CMSP
//
//  Created by 刘刚 on 2017/5/22.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LTSNewsAndNoticeModel;

@interface LTSCompanyNewsCell : UITableViewCell


@property (nonatomic,weak)  UIImageView *newsImageView;

@property (nonatomic,weak)  UILabel *titleLabel;
@property (nonatomic,weak)  UILabel *detailLabel;
@property (nonatomic,weak)  UILabel *dateLabel;

@property (nonatomic,strong) LTSNewsAndNoticeModel *model;

@end
