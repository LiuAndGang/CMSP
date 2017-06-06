//
//  LTSCompanyNewsCell.m
//  CMSP
//
//  Created by 刘刚 on 2017/5/22.
//  Copyright © 2017年 李棠松. All rights reserved.
//

#import "LTSCompanyNewsCell.h"
#import "LTSNewsAndNoticeModel.h"
#import "UIImageView+WebCache.h"
@implementation LTSCompanyNewsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //图片
        UIImageView *newsImageView = [[UIImageView alloc] init];
        self.newsImageView = newsImageView;
        [self.contentView addSubview:newsImageView];
        newsImageView.backgroundColor = [UIColor redColor];
        [newsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(self.contentView).with.offset(10);
            make.width.mas_equalTo(86);
            make.height.mas_equalTo(66);
        }];
        
        //标题
        UILabel *titleLabel = [[UILabel alloc] init];
        self.titleLabel = titleLabel;
        titleLabel.font = [UIFont systemFontOfSize:14];
        titleLabel.textColor = HexColor(@"#333333");
        [self.contentView addSubview:titleLabel];
//        titleLabel.backgroundColor = [UIColor greenColor];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(newsImageView).with.offset(6);
            make.left.mas_equalTo(newsImageView.mas_right).with.offset(10);
            make.height.mas_equalTo(16);
            make.right.mas_equalTo(self.contentView).with.offset(-10);
        }];
        
        //内容
        UILabel *detailLabel = [[UILabel alloc] init];
        self.detailLabel = detailLabel;
        detailLabel.numberOfLines = 2;
        [self.contentView addSubview:detailLabel];
//        detailLabel.backgroundColor = [UIColor greenColor];
        detailLabel.textColor = HexColor(@"#838383");
        detailLabel.font = [UIFont systemFontOfSize:10];
        [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(titleLabel.mas_bottom).with.offset(6);
            make.left.mas_equalTo(titleLabel);
            make.height.mas_equalTo(25);
            make.right.mas_equalTo(self.contentView).with.offset(-10);
        }];
        
        //日期
        UILabel *dateLabel = [[UILabel alloc] init];
        self.dateLabel = dateLabel;
        dateLabel.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:dateLabel];
        dateLabel.font = [UIFont systemFontOfSize:9];
        detailLabel.textColor = HexColor(@"#aaaaaa");
//        dateLabel.backgroundColor = [UIColor grayColor];
        [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(detailLabel.mas_bottom).with.offset(6);
            make.right.mas_equalTo(self.contentView).with.offset(-10);
            make.width.mas_equalTo(120);
            make.height.mas_equalTo(15);
        }];
    }
    return self;
}

-(void)setModel:(LTSNewsAndNoticeModel *)model
{
//    self.model = model;
    _titleLabel.text = model.mainTitle;
    _detailLabel.text = [model.context stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    //切割日期后边的不必要字符串
    NSRange range = [model.publicDate rangeOfString:@" 00:00:00.0"];
    _dateLabel.text = [model.publicDate substringToIndex:range.location];
    
    [_newsImageView sd_setImageWithURL:[NSURL URLWithString:model.imageString] placeholderImage:[UIImage imageNamed:@"newspic"]];
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
