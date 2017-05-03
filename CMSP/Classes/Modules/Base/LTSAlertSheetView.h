//
//  LTSAlertSheetView.h
//  SAIFAMC
//
//  Created by 李棠松 on 16/8/26.
//  Copyright © 2016年 leetangsong. All rights reserved.
//

#import "LTSBaseAlertView.h"
@class LTSAlertSheetView;
@class LTSAlertSheetCell;
@protocol LTSAlertSheetViewDelegate <NSObject>
- (void)sheetView:(LTSAlertSheetView *)sheetView configurCell:(LTSAlertSheetCell *)cell index:(NSInteger)index;

- (void)sheetView:(LTSAlertSheetView *)sheetView didSelectIndex:(NSInteger)index  data:(id)data;

@end

@interface LTSAlertSheetView : LTSBaseAlertView
@property (nonatomic,strong)LTSCustomButton *cancel;
@property (nonatomic,strong)UITableView *tableView;
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,weak)id<LTSAlertSheetViewDelegate> delegate;
@property (nonatomic,strong)NSArray *dataBase;
@property (nonatomic,strong)UIView *contentView;
@property (nonatomic,strong)NSString *title;

- (void)configLayout;

@end


@interface LTSAlertSheetCell : UITableViewCell

@property (nonatomic,strong)UILabel *label;

@end
