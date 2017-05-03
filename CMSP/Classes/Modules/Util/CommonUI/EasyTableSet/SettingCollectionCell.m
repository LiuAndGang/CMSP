//
//  SettingCollectionCell.m
//  QuWorking
//
//  Created by xiaojia on 15/4/24.
//  Copyright (c) 2015年 eim. All rights reserved.
//

#import "SettingCollectionCell.h"
#import "SettingCell.h"

#import "Masonry.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

#define SubTitleFont [UIFont systemFontOfSize:14]

@interface SettingCollectionCell()

//主标题
@property (nonatomic, weak) UILabel *title;

//副标题
@property (nonatomic, weak) UILabel *subTitle;

/**
 *  箭头
 */
@property (strong, nonatomic) UIImageView *arrowView;
/**
 *  checkBox
 */
@property (strong, nonatomic) UIButton *checkBox;

/**
 *  开关
 */
@property (strong, nonatomic) UISwitch *switchView;

/**
 *  中间文字显示
 */
@property (strong, nonatomic) UILabel *labelView;

/**
 *  提醒数字
 */
//@property (strong, nonatomic) BadgeButton *badgeButton;

@property (nonatomic, weak) UITableView *tableView;

//背景图片
@property (nonatomic, weak) UIImageView *bgView;

//选择中的行背景
@property (nonatomic, weak) UIImageView *selectedBgView;

@end

@implementation SettingCollectionCell

//checkBox视图
- (UIButton *)checkBox
{
    return _checkBox ? _checkBox :

    ({
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.selected = YES;
        [button setImage:[UIImage imageNamed:@"checkBox_false"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"checkBox_true"] forState:UIControlStateSelected];
        
        //选择和反选checkBox
        [[button rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(UIButton *x) {
            x.selected = !x.selected;
        }];
        
        [self.contentView addSubview:button];
        
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-5);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        button;
    });
    
}

//箭头视图
- (UIImageView *)arrowView
{
    return _arrowView ? _arrowView :
 
    ({
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"user_info_right_icon"]];
        
        [self.contentView addSubview:arrowView];
        
        [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-3);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(CellArrowWidth, CellArrowHeight));
        }];
        
        arrowView;
    });
    
}

//开关
-(UISwitch *)switchView
{
    return _switchView ? _switchView :
    
    ({
        UISwitch* switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
        [self.contentView addSubview:switchView];
        
        [switchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-3);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(CellArrowWidth, CellArrowHeight));
        }];
        switchView;
    });
}

//显示在中间的标题
-(UILabel *)labelView
{
    return _labelView ? _labelView :
    
    ({
        UILabel *label = [[UILabel alloc] init];
        label = [[UILabel alloc] init];
        //label.textColor = NavColor;
        label.font = [UIFont boldSystemFontOfSize:13];
        
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
        }];
        label;
    });
}

//副标题
-(UILabel *)subTitle
{
    return  _subTitle ? _subTitle :
    
    ({
        UILabel *label = [[UILabel alloc] init];
        label.font = SubTitleFont;
        label.textColor = [UIColor grayColor];
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).with.offset(-20);
            make.centerY.equalTo(self.contentView);
        }];
        label;
    });
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        //主标题
        UILabel *titel = [[UILabel alloc] init];
        titel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:titel];
        self.title = titel;
        
        [titel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).with.offset(15);
            make.centerY.equalTo(self.contentView);
        }];

        //横分割线
        CGFloat lineH = 0.3;
        CGFloat lineY = CellRowHeight - lineH;
        CGFloat lineW = Screen_Height * 0.5;
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, lineY , lineW, lineH)];
        bottomLine.backgroundColor = RGBCOLOR(219, 219, 219);
        [self.contentView addSubview:bottomLine];
        
        //竖分割线
        CGFloat rLinH = CellRowHeight;
        CGFloat rLinY = 0;
        CGFloat rLinW = 0.3;
        CGFloat rlinX = Screen_Width * 0.5 - rLinW;
        UIView *rightLine = [[UIView alloc] initWithFrame:CGRectMake(rlinX, rLinY, rLinW, rLinH)];
        rightLine.backgroundColor = RGBCOLOR(219, 219, 219);
        [self.contentView addSubview:rightLine];
    }
    return self;
}

- (void)setItem:(SettingItem *)item
{
    _item = item;
    
    // 1.设置数据
    [self setUpData];
    
    // 2.设置右边的控件
    [self setUpRightView];
}

-(void)setUpData
{
    self.title.text = self.item.title;
}

- (void)setUpRightView
{
    if ([self.item isKindOfClass:[SettingCheckBoxItem class]])
    { // 右边是开关
        [self checkBox];
        self.labelView.text = nil;
        self.subTitle.text = nil;
        //self.accessoryView = nil;
    }
    else if ([self.item isKindOfClass:[SettingArrowItem class]])
    { // 右边是箭头
        [self arrowView];
        self.subTitle.text = self.item.subtitle;
        
    }else if([self.item isKindOfClass:[SettingSwitchItem class]]){
        
        [self switchView];
        
    }else if([self.item isKindOfClass:[SettingLabelItem class]]){
        self.labelView.text = self.item.title;
        //self.textLabel.text = nil;
        //self.accessoryView = nil;
    }
    else { // 右边没有东西
        self.labelView.text = nil;
        //self.accessoryView = nil;
        self.checkBox = nil;
        self.arrowView = nil;
    }
}


@end
