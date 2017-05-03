//
//  LTSAlertSheetView.m
//  SAIFAMC
//
//  Created by 李棠松 on 16/8/26.
//  Copyright © 2016年 leetangsong. All rights reserved.
//

#import "LTSAlertSheetView.h"
#import "LTSCustomButton.h"


@interface LTSAlertSheetView()<UITableViewDelegate,UITableViewDataSource>





@end
@implementation LTSAlertSheetView

- (void)initUI{
    [super initUI];
    self.alertView = [UIView new];
   
//    self.alertView.backgroundColor = [UIColor whiteColor]
    self.contentView = [UIView new];
    [self.alertView addSubview:self.contentView];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel =[UILabel new];
    [self.alertView addSubview:self.titleLabel];
    self.titleLabel.backgroundColor = [UIColor whiteColor];
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.contentView addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 44;
    [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    [self.tableView setLayoutMargins:UIEdgeInsetsZero];
    
  
  
    
   
    LTSCustomButton *cancel = [LTSCustomButton new];
    [self.alertView addSubview:cancel];

    self.cancel = cancel;
    cancel.backgroundColor = [UIColor whiteColor];
    [cancel setTitle:@"取消" forState:UIControlStateNormal];
    [cancel setTitleColor:OrangeColor forState:UIControlStateNormal];
      ViewRadius(cancel, 5);
  @weakify(self)
    [[cancel rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self)
        [self dismissWithAnimation:YES];
    }];
    
    
  
}

- (void)setDataBase:(NSArray *)dataBase{
    _dataBase = dataBase;
    
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        if (dataBase.count<7) {
            
            make.height.mas_equalTo(44*dataBase.count);
        }
        else {
            make.height.mas_equalTo(44*7);
        }
        
    }];
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        if (dataBase.count<7) {
            self.tableView.scrollEnabled = NO;
            make.height.mas_equalTo(44*dataBase.count);
        }
        else {
            make.height.mas_equalTo(44*7);
            self.tableView.scrollEnabled = YES;
        }
        
    }];
   

    
}
- (void)tap:(UITapGestureRecognizer *)tap{
    
    [self  dismissWithAnimation:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataBase.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LTSAlertSheetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[LTSAlertSheetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (self.delegate&&[self.delegate respondsToSelector:@selector(sheetView:configurCell:index:)]) {
        [self.delegate sheetView:self configurCell:cell index:indexPath.row];
    }
    if ([self.dataBase[indexPath.row] isKindOfClass:[NSString class]]) {
        cell.label.text = self.dataBase[indexPath.row];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.delegate && [self.delegate respondsToSelector:@selector(sheetView:didSelectIndex:data:)]) {
        [self.delegate sheetView:self didSelectIndex:indexPath.row data:self.dataBase[indexPath.row]];
    }
    
    [self dismissWithAnimation:YES];
    
}
- (void)configLayout{
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(Screen_Width - 20);
        make.top.mas_equalTo(0);
        make.height.mas_equalTo(40);
        
    }];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(Screen_Width - 20);
        make.top.mas_equalTo(40);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        
        
    }];
    
    [self.cancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(Screen_Width - 20);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.tableView.mas_bottom).with.offset(10);
    }];
    
    [self layoutIfNeeded];
    
    
    if (self.title.length) {
        self.titleLabel.hidden = NO;
        
        ViewRectCornerRadius(self.contentView, UIRectCornerBottomLeft | UIRectCornerBottomRight,5);
    }
    else {
        ViewRadius(self.contentView, 5);
        self.titleLabel.hidden = YES;
    }
    ViewRectCornerRadius(self.titleLabel, UIRectCornerTopLeft | UIRectCornerTopRight,5);
    
    
    
    self.alertView.frame = CGRectMake(0, Screen_Height, Screen_Width, CGRectGetMaxY(self.cancel.frame)+10);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self configLayout];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [cell setSeparatorInset:UIEdgeInsetsZero];
    [cell setLayoutMargins:UIEdgeInsetsZero];
}

- (void)setTitle:(NSString *)title{
    
    _title = title;
    self.titleLabel.text = [NSString stringWithFormat:@" %@",title];
    
//    
    UIView *view = [UIView new];
    view.backgroundColor = lineBGColor;
    [self.alertView addSubview:view];
    //    [self.a bringSubviewToFront:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(Screen_Width- 20);
        make.height.mas_equalTo(0.5);
        make.top.mas_equalTo(40);
    }];
    
   
  
    
}

-(void)showWithAnimation:(BOOL)animation{
    [self.alertWindow addSubview:self];
    [self.alertWindow makeKeyAndVisible];
    [self layoutIfNeeded];
   
    
    if (animation) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.alertView.frame;
            frame.origin.y = Screen_Height - CGRectGetMaxY(self.cancel.frame)-10;
            self.alertView.frame = frame;
        }];
    }
    else {
        CGRect frame = self.alertView.frame;
        frame.origin.y = Screen_Height - CGRectGetMaxY(self.cancel.frame)-10;
        self.alertView.frame = frame;
    }
//
    
}

- (void)dismissWithAnimation:(BOOL)animation{
    if (animation) {
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.alertView.frame;
            frame.origin.y = Screen_Height;
            self.alertView.frame = frame;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            self.alertView =nil;
            self.alertWindow =nil;
            self.backgroundView = nil;
            self.tableView = nil;
            self.cancel = nil;
            self.contentView = nil;

        }];

    }
    else {
        [self removeFromSuperview];
        self.alertView =nil;
        self.alertWindow =nil;
        self.backgroundView = nil;
        self.tableView = nil;
        self.cancel = nil;
        self.contentView = nil;


    }
}
@end





@implementation LTSAlertSheetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.label = [UILabel new];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(0);
        }];
    }
    return self;
}

@end
