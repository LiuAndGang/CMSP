//
//  SettingCell.m
//  QuWorking
//
//  Created by xiaojia on 15/4/23.
//  Copyright (c) 2015年 eim. All rights reserved.
//

#import "SettingCell.h"
#import "Masonry.h"
#import "LTSCustomTextField.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface SettingCell()

@property (nonatomic,strong)UIView *redView;
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
 *  箭头
 */
@property (strong, nonatomic) UIImageView *arrowView;


@property (strong, nonatomic) LTSCustomTextField *textField;


//顶部的线，只有一个Cell有
@property (nonatomic, strong) UIView *topLine;


//背景图片
@property (nonatomic, weak) UIImageView *bgView;

//选择中的行背景
@property (nonatomic, weak) UIImageView *selectedBgView;

//底部分割线
@property (nonatomic, weak) UIView *bottomLine;


//头像
@property (nonatomic, strong)UIImageView *headImageView;
/**
 *  提醒数字暂时没用
 */
//@property (strong, nonatomic) BadgeButton *badgeButton;
@end

@implementation SettingCell


//checkBox视图
- (UIButton *)checkBox
{
    if (_checkBox == nil) {
        _checkBox = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _checkBox.selected = YES;
        [_checkBox setImage:[UIImage imageNamed:@"checkBox_false"] forState:UIControlStateNormal];
        [_checkBox setImage:[UIImage imageNamed:@"checkBox_true"] forState:UIControlStateSelected];
        
        //选择和反选checkBox

        [[_checkBox rac_signalForControlEvents:(UIControlEventTouchUpInside)] subscribeNext:^(UIButton *x) {
            x.selected = !x.selected;
        }];
        
        [self.contentView addSubview:_checkBox];
        
        [_checkBox mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mas_right).with.offset(-10);
            make.centerY.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(30, 30));
        }];
        
    }
    return _checkBox;
}

- (UILabel *)detailLabel{
    if (!_detailLabel) {
        _detailLabel  = [UILabel new];
        [self.contentView addSubview:_detailLabel];
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView.mas_centerY);
            make.right.mas_equalTo(-15);
        }];
        
    }
    return _detailLabel;
}
//箭头视图
//- (UIImageView *)arrowView
//{
//    if (_arrowView == nil) {
//        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_arrow"]];
//        
//        [self.contentView addSubview:_arrowView];
//        _arrowView.contentMode = UIViewContentModeCenter;
//        [_arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.right.equalTo(self.mas_right).with.offset(-15);
//            make.centerY.equalTo(self);
//            make.size.mas_equalTo(CGSizeMake(CellArrowWidth, CellArrowHeight));
//        }];
//    }
//    return _arrowView;
//}

//开关
-(UISwitch *)switchView
{
    if (!_switchView) {
        _switchView = [[UISwitch alloc] initWithFrame:CGRectMake(0, 0,50, 50)];
        _switchView.onTintColor = ThemeColor;
        _switchView.on = NO;
        
        @weakify(self)
        [[_switchView rac_signalForControlEvents:UIControlEventValueChanged] subscribeNext:^(UISwitch *switchView) {
            
            @strongify(self)
            if ([self.item isKindOfClass:[SettingSwitchItem class]]) {
                SettingSwitchItem *item = (SettingSwitchItem *)self.item;
                if (item.switchValueStateBlock) {
                    item.switchValueStateBlock(switchView.isOn);

                }
            }
//            if(self.swtichValueStateBlock){
//                self.swtichValueStateBlock(switchView.isOn);
//            }
        }];
    }
    return _switchView;
}

//标题
-(UILabel *)labelView
{
    if (!_labelView) {
        _labelView = [[UILabel alloc] init];
        //_labelView.textColor = NavColor;
        _labelView.font = [UIFont boldSystemFontOfSize:13];
        _labelView.textColor = ThemeColor;
        
        [self.contentView addSubview:_labelView];
        [_labelView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self);
            
        }];
    }
    return _labelView;
}

-(LTSCustomTextField *)textField
{
    if (!_textField) {
        _textField = [[LTSCustomTextField alloc] init];
        _textField.textColor = DarkText;
        [_textField setCustomPlaceholder:@"必填"];
        _textField.font = [UIFont systemFontOfSize:14];
        
        [self.contentView addSubview:_textField];
        [_textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.contentView);
            make.left.equalTo(self.contentView).with.offset(15);
            make.right.equalTo(self.contentView.mas_right).with.offset(-15);
            make.height.mas_equalTo(40);
        }];
        
        SettingTextFieldItem *item_tf = (SettingTextFieldItem *)self.item;
        [[_textField rac_textSignal] subscribeNext:^(id x) {
            item_tf.text =x;
            if(item_tf.textInputBlock){
                item_tf.textInputBlock(x);
            }
        }];
    }
    return _textField;
}
- (UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"headerDefault"]];
        [self.contentView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.right.mas_equalTo(-5);
            make.size.mas_equalTo(CGSizeMake(HeadImageWidth, HeadImageWidth));
        }];
        ViewRadius(_headImageView, HeadImageWidth/2.0);
    }
    return _headImageView;
}

//- (BadgeButton *)badgeButton
//{
//    if (_badgeButton == nil) {
//        _badgeButton = [[BadgeButton alloc] init];
//    }
//    return _badgeButton;
//}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"setting";
    SettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[SettingCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
        cell.tableView = tableView;
//        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
//        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        _arrowView = self.arrowView;
        self.hasBottomLine = YES;
        
        // 标题
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.textColor = DarkText;
        self.textLabel.highlightedTextColor = self.textLabel.textColor;
        self.textLabel.font = TextLabelFont;
        
        //分割线
        UIView *bottomLine = [[UIView alloc] init];
        bottomLine.backgroundColor = lineBGColor;
        self.bottomLine = bottomLine;
        [self addSubview:bottomLine];
        
        //顶部线
        self.topLine = [[UIView alloc] init];
        self.topLine.backgroundColor = LineColor;
        [self addSubview:self.topLine];
        
//        [bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(bottomLine.superview.mas_bottom).with.offset(-10);
//            make.height.mas_equalTo(lineH);
//            make.width.mas_equalTo(Screen_Width);
//            make.centerX.equalTo(bottomLine.superview);
//        }];
        
        
        //设置子标题的属性
        self.detailLabel.font = DetailTextLabelFont;
        
        // 4.设置颜色
        @weakify(self)
        [RACObserve(_item, textColor) subscribeNext:^(UIColor *color) {
            @strongify(self)
            self.textLabel.textColor = color;
            self.detailLabel.textColor = color;
        }];
        
        
//        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self);
//            make.right.equalTo(self).with.offset(-20);
//        }];
        
          // 创建背景
//        UIImageView *bgView = [[UIImageView alloc] init];
//        self.backgroundView = bgView;
//        self.bgView = bgView;
//        
//        UIImageView *selectedBgView = [[UIImageView alloc] init];
//        self.selectedBackgroundView = selectedBgView;
//        self.selectedBgView = selectedBgView;
    }
   
    return self;
}

- (void)setItem:(SettingItem *)item
{
    _item = item;
    
    // 1.设置数据
    [self setupData];
    
    // 2.设置右边的控件
    [self setupRightView];
}
//
//- (void)setIndexPath:(NSIndexPath *)indexPath
//{
//    _indexPath = indexPath;
//    
//    // 设置背景的图片
//    int totalRows = [self.tableView numberOfRowsInSection:indexPath.section];
//    NSString *bgName = nil;
//    NSString *selectedBgName = nil;
//    if (totalRows == 1) { // 这组就1行
//        bgName = @"common_card_background";
//        selectedBgName = @"common_card_background_highlighted";
//    } else if (indexPath.row == 0) { // 首行
//        bgName = @"common_card_top_background";
//        selectedBgName = @"common_card_top_background_highlighted";
//    } else if (indexPath.row == totalRows - 1) { // 尾行
//        bgName = @"common_card_bottom_background";
//        selectedBgName = @"common_card_bottom_background_highlighted";
//    } else { // 中行
//        bgName = @"common_card_middle_background";
//        selectedBgName = @"common_card_middle_background_highlighted";
//    }
//    self.bgView.image = [UIImage resizedImageWithName:bgName];
//    self.selectedBgView.image = [UIImage resizedImageWithName:selectedBgName];
//}
//
/**
 *  设置数据
 */
- (void)setupData
{
    // 1.图标
    if (self.item.icon) {
        self.imageView.image = [UIImage imageNamed:self.item.icon];
    }
    
    // 2.标题
    self.textLabel.text = self.item.title;
    
    // 3.子标题
    self.detailLabel.text = self.item.subtitle;
    self.detailLabel.textColor = self.item.subtitleColor ? : LightGrayColor;
    
    // 4.设置字体颜色
    //self.textLabel.textColor = self.item.textColor ?   self.item.textColor : QWColor(115, 115, 115);
    //self.detailLabel.textColor = self.item.textColor ? self.item.textColor : QWColor(115, 115, 115);
}

/**
 *  设置右边的控件
 */
- (void)setupRightView
{
//    if (self.item.badgeValue) {
//        self.badgeButton.badgeValue = self.item.badgeValue;
//        self.accessoryView = self.badgeButton;
    if ([self.item isKindOfClass:[SettingCheckBoxItem class]])
    { // 右边是checkBox
        [self checkBox];
        self.arrowView = nil;
        self.labelView.text = nil;
        self.accessoryView = nil;
//    }
//    else if ([self.item isKindOfClass:[SettingArrowItem class]])
//    { // 右边是箭头
////        [self arrowView];
////        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
////        self.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Arrow"]];
//        [self.detailLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
//            make.centerY.equalTo(self.contentView.mas_centerY);
//            make.right.mas_equalTo(-5);
//        }];
//        self.checkBox = nil;
//        self.labelView.text = nil;
//        //self.accessoryView = nil;
    
    }else if([self.item isKindOfClass:[SettingSwitchItem class]]){
      // 右边是开关
        self.accessoryView = self.switchView;
        
        SettingSwitchItem *item = (SettingSwitchItem *)self.item;
        self.switchView.on = item.open;
        self.labelView.text = nil;
        self.arrowView = nil;
        self.checkBox = nil;
        
    }else if([self.item isKindOfClass:[SettingLabelItem class]]){
      // 中间是文字
        self.checkBox = nil;
        self.arrowView = nil;
        self.labelView.text = self.item.title;
        self.textLabel.text = nil;
        self.accessoryView = nil;
    }else if([self.item isKindOfClass:[SettingTextFieldItem class]]){
        
        SettingTextFieldItem *item_tf = (SettingTextFieldItem *)self.item;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self textField];
        
        [self.textField setCustomPlaceholder:item_tf.placeHolder];
        self.textField.text = item_tf.text;
        self.textField.secureTextEntry = item_tf.secureTextEntry;
        if (item_tf.title.length) {
            [self.textField setLeftTitleText:item_tf.title];
        }
        
        self.checkBox = nil;
        self.arrowView = nil;
        self.labelView.text = nil;
        self.accessoryView = nil;
        
    }else if ([self.item isKindOfClass:[SettingHeadImageItem class]]){
        self.accessoryView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_arrow"]];
        [self headImageView];
        self.checkBox = nil;
        self.labelView.text = nil;
    }
    
    else {
     // 右边没有东西
        self.labelView.text = nil;
        self.accessoryView = nil;
        self.checkBox = nil;
        self.arrowView = nil;
    }
}

- (void)setHaveRedPoint:(BOOL)haveRedPoint{
    _haveRedPoint = haveRedPoint;
    
    if (!self.redView) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor redColor];
        view.layer.masksToBounds = YES;
        view.layer.cornerRadius = 8/2.0;
        [self.textLabel addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(8);
            make.top.mas_equalTo(-2);
            make.size.mas_equalTo(CGSizeMake(8, 8));
        }];
        self.redView = view;

    }
    self.redView.hidden = !_haveRedPoint;
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    CGFloat lineH = GloBalLineWidth;
    self.bottomLine.frame = CGRectMake(self.bottomLineLeftOffset, self.frame.size.height - lineH, self.frame.size.width, lineH);
//    self.topLine.frame = CGRectMake(0, 0, self.frame.size.width, lineH);
    
    if (self.tag == 0) {
        self.topLine.hidden = NO;
    }else{
        self.topLine.hidden = YES;
    }
    
    if (self.hasBottomLine) {
        self.bottomLine.hidden = NO;
    }else{
        self.bottomLine.hidden = YES;
    }

}

@end
