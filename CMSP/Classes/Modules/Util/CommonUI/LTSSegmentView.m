//
//  LTSSegmentView.m
//  SAIFAMC
//
//  Created by 李棠松 on 16/8/17.
//  Copyright © 2016年 leetangsong. All rights reserved.
//

#import "LTSSegmentView.h"
#define TabViewHeight 40
#define TabItemNormalColor SecondaryText
#define TabItemSelectedColor ThemeColor

@interface LTSSegmentView()<UIScrollViewDelegate>
{
    NSInteger count;
}





@property (nonatomic, strong)  NSArray *tabItems;

@property (nonatomic, strong) UIView *indicator;

@property (nonatomic, assign) CGFloat indicatorOriginalX;

@property (nonatomic,strong)UIImageView *indicatorImageView;

@end
@implementation LTSSegmentView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = BGColorGray;
        self.tabView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, TabViewHeight)];
        [self addSubview:self.tabView];
        self.tabView.backgroundColor = [UIColor whiteColor];
        self.selectedColor = OrangeColor;
        
    }
    return self;
}

- (void)configViewControllers:(NSArray *)viewControllers titles:(NSArray *)titles style:(LTSSegmentViewStyle)style{
    _style = style;
    [self configViewControllers:viewControllers titles:titles];
    
}

-(void)configViewControllers:(NSArray *)viewControllers titles:(NSArray *)titles{
    if (!viewControllers.count) {
        return;
    }
    //    UIViewController *parentsController = [self findViewController];
    self.viewControllers = viewControllers;
    self.currentViewController = viewControllers[0];
    self.titles = titles;
    [self initUI];
    [self configTabTitles:titles];
    
}

- (void)configTabTitles:(NSArray *)tabTitles{
    NSMutableArray *items = [NSMutableArray array];
    count = tabTitles.count;
    
    
    for(int i = 0; i < tabTitles.count ; i++) {
        //[parentsController addChildViewController:controller];
        
        UIButton *tabItem = ({  UIButton *button = [[UIButton alloc] init];
            
            [button setTitle:tabTitles[i] forState:UIControlStateNormal];
            button.tag = i;
            if (i == 0) {
                button.selected = YES;
            }
            CGFloat buttonX = (self.frame.size.width / count) * i;
            CGFloat buttonY = 0;
            CGFloat buttonW = self.frame.size.width / count;
            CGFloat buttonH = TabViewHeight;
            
            button.frame = CGRectMake(buttonX,buttonY,buttonW,buttonH);
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:DarkText forState:UIControlStateNormal];
            [button setTitleColor:OrangeColor forState:UIControlStateSelected];
            
            
            
            
            [button addTarget:self action:@selector(tabItemDidClick:) forControlEvents:UIControlEventTouchUpInside];
            [items addObject:button];
            button;
        });
        [self.tabView addSubview:tabItem];
        
        if (i!=tabTitles.count-1) {
            
            //分割线
            UIView *line = ({ UIView *view = [[UIView alloc] init];
                
                view.backgroundColor = LightGrayColor;
                
                CGFloat lineHeight = self.tabView.frame.size.height-20;
                CGFloat lineWidth = 0.5;
                CGFloat lineX =  (i + 1) * (self.tabView.frame.size.width / count);
                CGFloat lineY = 10;
                
                view.frame = CGRectMake(lineX, lineY, lineWidth, lineHeight);
                view;
            });
//            [self.tabView addSubview:line];
            
        }
       
    }
    self.tabItems = items;
    //指示器
    self.indicator = ({ UIView *view = [[UIView alloc] init];
        
        CGFloat lineHeight = 1.5;
        CGFloat lineWidth = self.tabView.frame.size.width / count;
        CGFloat lineY = self.tabView.frame.size.height - lineHeight;
        CGFloat lineX =((self.tabView.frame.size.width / count) - lineWidth) * 0.5;
        self.indicatorOriginalX = lineX;
        
        view.frame = CGRectMake(lineX, lineY, lineWidth, lineHeight);
        view.backgroundColor = OrangeColor;
        view;
    });
    [self.tabView addSubview:self.indicator];
    
    
    UIView *lineBottom = [UIView new];
    lineBottom.backgroundColor = LightGrayColor;
    [self.tabView addSubview:lineBottom];
    lineBottom.frame = CGRectMake(0, TabViewHeight-0.5, Screen_Width, 0.5);
    
    [self setSelectIndex:0];
}

-(void)tabItemDidClick:(UIButton *)tabItem{
    CGFloat scrollViewWith = self.frame.size.width;
    [self endEditing:YES];
    if (self.scrollView) {
        [self.scrollView setContentOffset:CGPointMake(tabItem.tag * scrollViewWith, 0) animated:YES];
    }
    else{
        for (UIButton *item in self.tabItems) {
            
            item.selected = NO;
        }
        
        tabItem.selected = YES;
        
        if(self.segmentViewSelectIndexBlock){
            self.segmentViewSelectIndexBlock(tabItem.tag);
        }
        
        
        if (self.indicatorImageView) {
            __block  CGRect itemFrame = tabItem.frame;
            __block  CGRect indicFrame = self.indicatorImageView.frame;
            [UIView animateWithDuration:0.2 animations:^{
                indicFrame.origin.x = itemFrame.origin.x;
                self.indicatorImageView.frame = indicFrame;
                
            }];
        }
        else {
            __block  CGRect itemFrame = tabItem.frame;
            __block  CGRect indicFrame = self.indicator.frame;
            [UIView animateWithDuration:0.2 animations:^{
                indicFrame.origin.x = itemFrame.origin.x;
                self.indicator.frame = indicFrame;
                
            }];
        }
        
    }
    
}


#pragma mark -------------------- ScrollView delegate ----------------------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetX = scrollView.contentOffset.x;
    
    
    
    [self.indicator setX:self.indicatorOriginalX + offsetX / count];
    
    if (CGRectGetMaxX(self.indicator.frame) ) {
        
        NSUInteger selectedIndex = offsetX / self.frame.size.width;
        
        for (UIButton *button in self.tabItems) {
            button.selected = NO;
        }
        
        UIButton *button = self.tabItems[selectedIndex];
        button.selected = YES;
        self.currentSelectIndex = selectedIndex;
        self.currentViewController = self.viewControllers[selectedIndex];
    
        if(self.segmentViewSelectIndexBlock){
            self.segmentViewSelectIndexBlock(selectedIndex);
        }
    }
    
}

- (void)initUI{
    
    self.scrollView = ({UIScrollView *scrollView = [UIScrollView new];
        [self addSubview:scrollView];
        scrollView.pagingEnabled = YES;
        scrollView.delegate = self;
        scrollView.bounces = NO;
        
        CGFloat originY;
        CGFloat height;
        if (self.titles.count>1) {
            originY =  CGRectGetMaxY(self.tabView.frame);
            height = CGRectGetHeight(self.frame)-CGRectGetHeight(self.tabView.frame);
        }
        else{
            self.tabView.hidden = YES;
            originY = 0;
            height = CGRectGetHeight(self.frame);
        }
        
        scrollView.frame = CGRectMake(0, originY, CGRectGetWidth(self.frame), height);
        scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame)*self.viewControllers.count, CGRectGetHeight(self.scrollView.frame));
        scrollView;});
    
    
    for (NSInteger i = 0; i<self.viewControllers.count; i++) {
        UIViewController *viewController = self.viewControllers[i];
        viewController.view.frame = CGRectMake(CGRectGetWidth(self.frame)*i, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.scrollView.frame));
        [self.scrollView addSubview:viewController.view];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat height;
    CGFloat originY;
    if (self.titles.count>1) {
        originY =  CGRectGetMaxY(self.tabView.frame);
        height = CGRectGetHeight(self.frame)-CGRectGetHeight(self.tabView.frame);
    }
    else{
        self.tabView.hidden = YES;
        originY = 0;
        height = CGRectGetHeight(self.frame);
    }
    
    self.scrollView.frame = CGRectMake(0, originY, CGRectGetWidth(self.frame), height);
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame)*self.viewControllers.count, CGRectGetHeight(self.scrollView.frame));
    [self.scrollView layoutIfNeeded];

}

- (void)setSelectedColor:(UIColor *)selectedColor{
    _selectedColor = selectedColor;
    for (UIButton *tabItem in self.tabItems) {
        
        [tabItem setTitleColor:selectedColor forState:UIControlStateSelected];
    }
    
}
- (void)setUnSelectedColor:(UIColor *)unSelectedColor{
    _unSelectedColor = unSelectedColor;
    for (UIButton *tabItem in self.tabItems) {
        
        [tabItem setTitleColor:unSelectedColor forState:UIControlStateNormal];
    }
}
- (void)setIndicatorImage:(UIImage *)indicatorImage{
    [self.indicator removeFromSuperview];
    self.indicator = nil;
    CGSize size = indicatorImage.size;
    CGFloat lineWidth = self.tabView.frame.size.width / count;
    CGFloat lineY = self.tabView.frame.size.height - size.height;
    CGFloat lineX =((self.tabView.frame.size.width / count) - lineWidth) * 0.5;
    
    self.indicatorOriginalX = lineX;
    self.indicatorImageView = [[UIImageView alloc]initWithImage:indicatorImage];
    self.indicatorImageView.frame = CGRectMake(lineX, lineY, lineWidth, size.height);
    
    [self.tabView addSubview:self.indicatorImageView];
    
}
- (void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    
    [self tabItemDidClick:self.tabItems[selectIndex]];
    
    
}
@end
