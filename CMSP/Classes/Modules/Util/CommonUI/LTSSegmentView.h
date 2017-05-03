//
//  LTSSegmentView.h
//  SAIFAMC
//
//  Created by 李棠松 on 16/8/17.
//  Copyright © 2016年 leetangsong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,LTSSegmentViewStyle){
   ///导航不滚动
    LTSSegmentViewStyle1,
    ///导航滚动
    LTSSegmentViewStyle2
};

typedef void(^LTSSegmentViewSelectIndexBlock)(NSUInteger index);

@interface LTSSegmentView : UIView

@property (nonatomic, strong) UIScrollView *tabView;

@property (nonatomic,strong)NSArray *viewControllers;

@property (nonatomic,strong)NSArray *titles;

@property (nonatomic,strong)UIScrollView *scrollView;

@property (nonatomic,assign)NSInteger selectIndex;

@property (nonatomic, copy) LTSSegmentViewSelectIndexBlock segmentViewSelectIndexBlock;

@property (nonatomic,strong)UIImage *indicatorImage;

@property (nonatomic,strong)UIColor *selectedColor;

@property (nonatomic,strong)UIColor *unSelectedColor;

@property (nonatomic,assign)LTSSegmentViewStyle style;

@property (nonatomic,strong)UIViewController *currentViewController;

@property (nonatomic,assign)NSInteger currentSelectIndex;
//@property (nonatomic,assign)BOOL indicatorHiddenWhenApper;
-(void)configTabTitles:(NSArray *)tabTitles;

- (void)configViewControllers:(NSArray *)viewControllers titles:(NSArray *)titles;
- (void)configViewControllers:(NSArray *)viewControllers titles:(NSArray *)titles style:(LTSSegmentViewStyle)style;

@end
