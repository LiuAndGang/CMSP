//
//  UIView+Common.m
//  Coding_iOS
//
//  Created by 王 原闯 on 14-8-6.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import "UIView+Common.h"
#import <objc/runtime.h>
#import "UIButton+Style.h"

#define kTagLineViewW 1006
#define kTagLineView 1007
#define kTagYLineView 1008



@implementation UIView (Common)
static char LoadingViewKey, BlankPageViewKey, LoadingActViewKey;
- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}
- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size.width = size.width;
    frame.size.height = size.height;
    self.frame = frame;
}


- (CGFloat)width
{
    return self.bounds.size.width;
}

- (CGFloat)height
{
    return self.bounds.size.height;
}

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setLeft:(CGFloat)x
{
    CGRect oldFrame = self.frame;
    CGRect newFrame = CGRectMake(x, oldFrame.origin.y, oldFrame.size.width, oldFrame.size.height);
    self.frame = newFrame;
}




- (void)setTop:(CGFloat)y
{
    CGRect oldFrame = self.frame;
    CGRect newFrame = CGRectMake(oldFrame.origin.x, y, oldFrame.size.width, oldFrame.size.height);
    self.frame = newFrame;
}


#pragma Line
//- (void)setLineView:(LineView *)lineView{
//    [self willChangeValueForKey:@"LineViewKey"];
//    objc_setAssociatedObject(self, &LineViewKey,
//                             lineView,
//                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    [self didChangeValueForKey:@"LineViewKey"];
//}
//
//- (LineView *)lineView{
//    return objc_getAssociatedObject(self, &LineViewKey);
//}

-(void)addLineAtDirection:(Direction)direction leftOffset:(CGFloat)leftOffset
{
    //    if (!self.lineView) {
    //        self.lineView.backgroundColor = lineBGColor;
    //    }
    switch (direction) {
        case DirectionDown: {
            //            self.lineView.frame = CGRectMake(0, self.frame.size.height - GloBalLineWidth, self.frame.size.width, 5);
            UIView *lineView = [[UIView alloc] init];
            [self addSubview:lineView];
            lineView.backgroundColor = lineBGColor;
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self);;
                make.left.equalTo(self).with.offset(leftOffset);
                make.right.equalTo(self);
                make.height.mas_equalTo(GloBalLineWidth);
            }];
        }
            break;
            
        case DirectionTop: {
            UIView *lineView = [[UIView alloc] init];
            [self addSubview:lineView];
            lineView.backgroundColor = lineBGColor;
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.left.equalTo(self).with.offset(leftOffset);
                make.right.equalTo(self);
                make.height.mas_equalTo(GloBalLineWidth);
            }];
            
        }
            break;
            
        case DirectionLeft: {
            UIView *lineView = [[UIView alloc] init];
            [self addSubview:lineView];
            lineView.backgroundColor = lineBGColor;
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.height.mas_equalTo(GloBalLineWidth);
            }];
            
        }
            
            break;
            
        default:
            break;
    }

}



-(void)addLineAtDirection:(Direction)direction
{
    //    if (!self.lineView) {
    //        self.lineView.backgroundColor = lineBGColor;
    //    }
    switch (direction) {
        case DirectionDown: {
            //            self.lineView.frame = CGRectMake(0, self.frame.size.height - GloBalLineWidth, self.frame.size.width, 5);
            UIView *lineView = [[UIView alloc] init];
            [self addSubview:lineView];
            lineView.backgroundColor = lineBGColor;
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.equalTo(self);;
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.height.mas_equalTo(GloBalLineWidth);
            }];
        }
            break;
            
        case DirectionTop: {
            UIView *lineView = [[UIView alloc] init];
            [self addSubview:lineView];
            lineView.backgroundColor = lineBGColor;
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.height.mas_equalTo(GloBalLineWidth);
            }];
            
        }
            break;
            
        case DirectionLeft: {
            UIView *lineView = [[UIView alloc] init];
            [self addSubview:lineView];
            lineView.backgroundColor = lineBGColor;
            [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self);
                make.left.equalTo(self);
                make.right.equalTo(self);
                make.height.mas_equalTo(GloBalLineWidth);
            }];
            
        }
            
            break;
            
        default:
            break;
    }
    
}

/**
 *  找到view自己所在的viewController
 *
 *  @return 找到view自己所在的viewController
 */
- (UIViewController *)findViewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

- (UIView *)addBackViewToSupview:(CGRect)rect
{
    UIView *bg_BackView = [[UIView alloc] initWithFrame:rect];
    bg_BackView.backgroundColor = [UIColor clearColor];
    [self addSubview:bg_BackView];
    [bg_BackView addLineUp:NO andDown:YES andMidden:NO];
    return bg_BackView;
}
+ (UIView *)headerView:(CGFloat)y
{
    UIView *header = [[UIView alloc] initWithFrame:
                    CGRectMake(0, 0, Screen_Width, y)];
    return header;
}
- (void)setCenterY:(CGFloat)y{
    CGPoint center = self.center;
    center.y = y;
    self.center = center;
}
- (void)setCenterX:(CGFloat)x{
    CGPoint center = self.center;
    center.x = x;
    self.center = center;
}
- (UIView *)lineViewWithPointYY:(CGFloat)pointY{
    return [self lineViewWithPointYY:pointY andColor:UIColorFromRGB(0xc8c7cc)];
}

- (UIView *)lineViewWithPointYY:(CGFloat)pointY andColor:(UIColor *)color{
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, pointY, WIDTH(self), 0.5)];
    lineView.backgroundColor = color;
    return lineView;
}

- (void)addYLineLeft:(BOOL)hasLeft andMidden:(BOOL)hasMidden andRight:(BOOL)hasRight
{
    [self addYLineLeft:hasLeft andRigh:hasRight
                    andMidden:hasMidden andColor:UIColorFromRGBA(0xdddddd, .9)];
}

- (void)addYLineLeft:(BOOL)hasLeft andRigh:(BOOL)hasRight andMidden:(BOOL)hasMidden andColor:(UIColor *)color
{
    [self removeViewWithTag:kTagYLineView];
    CGRect rect = CGRectMake(0.f, 0.f, 0.5, HEIGHT(self));
    if (hasLeft) {
        UIView *leftView = [[UIView alloc] initWithFrame:rect];
        [leftView setX:0.f];[leftView setWidth:.5];
        leftView.backgroundColor = color;
        leftView.tag = kTagYLineView;
        [self addSubview:leftView];
    }
    if (hasRight) {
        UIView *rightView = [[UIView alloc] initWithFrame:rect];
        [rightView setX:WIDTH(self)-0.5];
        rightView.tag = kTagYLineView;
        rightView.backgroundColor = color;
        [self addSubview:rightView];
    }
    if (hasMidden) {
        UIView *middenView = [[UIView alloc] initWithFrame:rect];
        [middenView setX:WIDTH(self)/2-0.25];
        middenView.tag = kTagYLineView;
        middenView.backgroundColor = color;
        [self addSubview:middenView];
    }      // 招聘的地方
}

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andMidden:(BOOL)hasMidden{
    [self addLineUp:hasUp andDown:hasDown andMidden:hasMidden
                                    andColor:UIColorFromRGBA(0xdddddd, .9)];
}

- (void)addLineUp:(BOOL)hasUp andDown:(BOOL)hasDown andMidden:(BOOL)hasMidden andColor:(UIColor *)color{
    [self removeViewWithTag:kTagLineView];
    if (hasUp) {
        UIView *upView = [self lineViewWithPointYY:0 andColor:color];
        upView.tag = kTagLineView;
        [self addSubview:upView];
    }
    if (hasDown) {
        UIView *downView = [self lineViewWithPointYY:CGRectGetMaxY(self.bounds)-0.5 andColor:color];
        downView.tag = kTagLineView;
        [self addSubview:downView];
    }
    if (hasMidden) {
        UIView *middenView = [self lineViewWithPointYY:(CGRectGetMaxY(self.bounds)/2)-0.25 andColor:color];
        middenView.tag = kTagLineView;
        [self addSubview:middenView];
    }
}
- (void)removeViewWithTag:(NSInteger)tag{
    for (UIView *aView in [self subviews]) {
        if (aView.tag == tag) {
            [aView removeFromSuperview];
        }
    }
}
- (void)addGradientLayerWithColors:(NSArray *)cgColorArray{
    [self addGradientLayerWithColors:cgColorArray locations:nil startPoint:CGPointMake(0.0, 0.5) endPoint:CGPointMake(1.0, 0.5)];
}

- (void)addGradientLayerWithColors:(NSArray *)cgColorArray locations:(NSArray *)floatNumArray startPoint:(CGPoint )startPoint endPoint:(CGPoint)endPoint{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.bounds;
    if (cgColorArray && [cgColorArray count] > 0) {
        layer.colors = cgColorArray;
    }else{
        return;
    }
    if (floatNumArray && [floatNumArray count] == [cgColorArray count]) {
        layer.locations = floatNumArray;
    }
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    [self.layer addSublayer:layer];
}


#pragma mark BlankPageView
- (void)setBlankPageView:(EaseBlankPageView *)blankPageView{
    [self willChangeValueForKey:@"BlankPageViewKey"];
    objc_setAssociatedObject(self, &BlankPageViewKey,
                             blankPageView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"BlankPageViewKey"];
}

- (EaseBlankPageView *)blankPageView{
    return objc_getAssociatedObject(self, &BlankPageViewKey);
}

- (void)configBlankPage:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block{
    if (hasData) {
        if (self.blankPageView) {
            self.blankPageView.hidden = YES;
            [self.blankPageView removeFromSuperview];
        }
    }else{
        if (!self.blankPageView) {
            self.blankPageView = [[EaseBlankPageView alloc] initWithFrame:self.bounds];
        }
        self.blankPageView.hidden = NO;
        [self.blankPageContainer addSubview:self.blankPageView];
        
        //        [self.blankPageContainer insertSubview:self.blankPageView atIndex:0];
        //        [self.blankPageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //            make.size.equalTo(self);
        //            make.top.left.equalTo(self.blankPageContainer);
        //        }];
        [self.blankPageView configWithType:blankPageType hasData:hasData hasError:hasError reloadButtonBlock:block];
    }
}

- (UIView *)blankPageContainer{
    UIView *blankPageContainer = self;
    for (UIView *aView in [self subviews]) {
        if ([aView isKindOfClass:[UITableView class]]) {
            blankPageContainer = aView;
        }
    }
    return blankPageContainer;
}


#pragma mark LoadingView
//- (void)setLoadingView:(EaseLoadingView *)loadingView{
//    [self willChangeValueForKey:@"LoadingViewKey"];
//    objc_setAssociatedObject(self, &LoadingViewKey,
//                             loadingView,
//                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//    [self didChangeValueForKey:@"LoadingViewKey"];
//}
//- (EaseLoadingView *)loadingView{
//    return objc_getAssociatedObject(self, &LoadingViewKey);
//}
//- (void)beginLoading{
//    for (UIView *aView in [self.blankPageContainer subviews]) {
//        if ([aView isKindOfClass:[EaseBlankPageView class]] && !aView.hidden) {
//            return;
//        }
//    }
//    if (!self.loadingView) {
//        //  初始化LoadingView
//        EaseLoadingView *view = [[EaseLoadingView alloc] initWithFrame:self.bounds];
//        self.loadingView = view;
//    }
//    [self addSubview:self.loadingView];
//    [self.loadingView startAnimating];
//}
//- (void)endLoading{
//    if (self.loadingView) {
//        [self.loadingView stopAnimating];
//        [self.loadingView removeFromSuperview];
//        //MCRelease(self.loadingView);
//    }
//}
#pragma mark LoadingActView
- (void)setLoadingActView:(EaseActLoadingView *)loadingActView{
    [self willChangeValueForKey:@"LoadingActViewKey"];
    objc_setAssociatedObject(self, &LoadingActViewKey,
                             loadingActView,
                             OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self didChangeValueForKey:@"LoadingActViewKey"];
}
- (EaseActLoadingView *)loadingActView{
    return objc_getAssociatedObject(self, &LoadingActViewKey);
}
- (void)beginActLoading{
    for (UIView *aView in [self.blankPageContainer subviews]) {
        if ([aView isKindOfClass:[EaseBlankPageView class]] && !aView.hidden) {
            return;
        }
    }
    if (!self.loadingActView) {
        //  初始化LoadActingView
        [self layoutSubviews];
        
        EaseActLoadingView *view = [[EaseActLoadingView alloc]
                                    initWithFrame:self.bounds];
        
        self.loadingActView = view;
    }
    [self addSubview:self.loadingActView];
    
//    [self.loadingActView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self);
//    }];
////
    [self.loadingActView startActIndicatorAnimating];
}
- (void)layoutSubviews{
    if (self.loadingActView) {
        
        self.loadingActView.frame = self.bounds;
    }
}
- (void)endActLoading{
    if (self.loadingActView) {
        [self.loadingActView stopActIndicatorAnimating];
        [self.loadingActView removeFromSuperview];
        //MCRelease(self.loadingActView);
    }
}

@end

@interface EaseActLoadingView()
@property (nonatomic,strong)UILabel *actIndiorLab;

@end

@implementation EaseActLoadingView
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    if (_indicatorView) {
         CGPoint center = self.center;
        center.y = self.center.y - 40;
        center.x = self.center.x+20.f;
        _actIndiorLab.center = center;
        
        CGPoint indicatorCenter = CGPointZero;
        indicatorCenter.x = CGRectGetMinX(_actIndiorLab.frame)-22.f;
        indicatorCenter.y = _actIndiorLab.center.y;
         [_indicatorView setCenter:indicatorCenter];
    }
    
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        if (!_indicatorView) {
            NSString *loadingStr = @"正在加载";
            UIFont *font = [UIFont systemFontOfSize:16.f];
            CGSize size = CGSizeMake(CGFLOAT_MAX, 35.f);
            CGRect rect = [loadingStr boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:font.fontName size:font.pointSize]} context:nil];
            
            CGRect buttonFrame = CGRectZero;
            buttonFrame.size.height = CGRectGetHeight(rect);
            buttonFrame.size.width = CGRectGetWidth(rect)+10.f;
            
            CGPoint center = self.center;
            center.y = self.center.y - 40;
            center.x = self.center.x+20.f;
            UILabel *actIndiorLab = [[UILabel alloc]initWithFrame:buttonFrame];
            actIndiorLab.backgroundColor = [UIColor clearColor];
            actIndiorLab.text = loadingStr;
            actIndiorLab.font = font;
            actIndiorLab.textColor = UIColorFromRGB(0x9E9E9E);
            actIndiorLab.center = center;
            _actIndiorLab = actIndiorLab;
            [self addSubview:actIndiorLab];
            
            CGPoint indicatorCenter = CGPointZero;
            indicatorCenter.x = CGRectGetMinX(actIndiorLab.frame)-22.f;
            indicatorCenter.y = actIndiorLab.center.y;
            
            //指定进度
            _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
            [_indicatorView setCenter:indicatorCenter];//指定进度轮中心点
            _indicatorView.hidesWhenStopped = YES;
            [self addSubview:_indicatorView];
            
//            [_indicatorView mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.center.equalTo(self);
//            }];
            
        }
    }
    return self;
}
- (void)startActIndicatorAnimating{
    
    self.hidden = NO;
    if (_isLoading) {
        return;
    }
    _isLoading = YES;
    [self.indicatorView startAnimating];
}
- (void)stopActIndicatorAnimating{
    [UIView animateWithDuration:.1 animations:^{
        self.alpha = .0f;
    } completion:^(BOOL finished){
        self.hidden = YES;
        [self.indicatorView stopAnimating];
        _isLoading = NO;
    }];
}

@end

#pragma mark EaseBlankPageView
@implementation EaseBlankPageView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)configWithType:(EaseBlankPageType)blankPageType hasData:(BOOL)hasData hasError:(BOOL)hasError reloadButtonBlock:(void (^)(id))block{
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_loadAndShowStatusBlock) {
            _loadAndShowStatusBlock();
        }
    });
    
    
    if (hasData) {
        [self removeFromSuperview];
        return;
    }
    self.alpha = 1.0;
    //    图片
    if (!_fillView) {
        _fillView = [[UIImageView alloc] initWithFrame:CGRectZero];
        [self addSubview:_fillView];
    }
    //    文字
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _tipLabel.backgroundColor = [UIColor clearColor];
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = [UIFont systemFontOfSize:16];
        _tipLabel.textColor = [UIColor grayColor];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_tipLabel];
    }
    
    //    布局
    [_fillView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_centerY);
    }];
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerX.equalTo(self);
        make.top.equalTo(_fillView.mas_bottom);
        make.height.mas_equalTo(50);
    }];
    
    _reloadButtonBlock = nil;
    if (hasError) {
        //        加载失败
        if (!_reloadButton) {
            _reloadButton = [[UIButton alloc] initWithFrame:CGRectZero];
            _reloadButton.backgroundColor = BULECOLOR;
            ViewRadius(_reloadButton, 5);
            [_reloadButton setTitle:@"重新加载" forState:0];
//            [_reloadButton accountButtonStyle];
            _reloadButton.adjustsImageWhenHighlighted = YES;
            [_reloadButton addTarget:self action:@selector(reloadButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:_reloadButton];
            [_reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.top.equalTo(_tipLabel.mas_bottom);
                make.size.mas_equalTo(CGSizeMake(160, 40));
            }];
        }
        _reloadButton.hidden = NO;
        _reloadButtonBlock = block;
//        [_fillView setImage:[UIImage imageNamed:@"blankpage_image_loadFail"]];
        _tipLabel.text = @"网络好像出现了点问题";
        
        [_tipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.centerY.equalTo(self).with.offset(-30
                                                   );
            make.height.mas_equalTo(50);
            //                make.bottom.equalTo(self.mas_centerY);
        }];

        
    }else{
        //        空白数据
        if (_reloadButton) {
            _reloadButton.hidden = YES;
        }
        
        NSString *imageName, *tipStr;
        _curType=blankPageType;
        switch (blankPageType) {

            
            case  BlankEmptyDepartment:{
                imageName = @"bg-kong";
                tipStr = @"还没有数据哦!";
            }
                break;
            case  BlankEmptyTemplate:{
                imageName = @"bg-kong";
                tipStr = @"还没有模板哦!";
            }
                break;
            case  BlankEmptyData:{
                imageName = @"bg-kong";
                tipStr = @"还没有数据哦!";
            }
                break;
            case  BlankEmptySelectedMainElement:{
                imageName = @"bg-kong";
                tipStr = @"暂无可选构件!";
            }
                break;
           

               
                      default://其它页面（这里没有提到的页面，都属于其它）
            {
                tipStr = @"这里还什么都没有\n赶快起来弄出一点动静吧";
            }
                break;
        }
        [_fillView setImage:[UIImage imageNamed:imageName]];
        
        _tipLabel.text = tipStr;
        
        if(!imageName){
            [_tipLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self);
                make.centerY.equalTo(self);
                make.height.mas_equalTo(50);
//                make.bottom.equalTo(self.mas_centerY);
            }];
        }
        
//        if ((blankPageType>=EaseBlankPageTypeProject_ALL)&&(blankPageType<=EaseBlankPageTypeProject_STARED)) {
//            [_monkeyView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.centerX.equalTo(self);
//                make.bottom.equalTo(self.mas_centerY).offset(-35);
//            }];
//            
//            //新增按钮
//            UIButton *actionBtn=({
//                UIButton *button=[UIButton new];
//                button.backgroundColor=[UIColor colorWithHexString:@"0x3BBD79"];
//                button.titleLabel.font=[UIFont systemFontOfSize:15];
//                [button addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
//                button.layer.cornerRadius=18;
//                button.layer.masksToBounds=TRUE;
//                button;
//            });
//            [self addSubview:actionBtn];
//            
//            [actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.size.mas_equalTo(CGSizeMake(125 , 36));
//                make.top.equalTo(_tipLabel.mas_bottom).offset(15);
//                make.centerX.equalTo(self);
//            }];
//            
//            NSString *titleStr;
//            switch (blankPageType) {
//                case EaseBlankPageTypeProject_ALL:
//                case EaseBlankPageTypeProject_CREATE:
//                case EaseBlankPageTypeProject_JOIN:
//                    titleStr=@"+ 创建项目";
//                    //                    [actionBtn setTitle:@"+ 创建项目" forState:UIControlStateNormal];
//                    break;
//                case EaseBlankPageTypeProject_WATCHED:
//                    titleStr=@"+ 去关注";
//                    //                    [actionBtn setTitle:@"+ 去关注" forState:UIControlStateNormal];
//                    break;
//                case EaseBlankPageTypeProject_STARED:
//                    titleStr=@"+ 去收藏";
//                    //                    [actionBtn setTitle:@"+去收藏" forState:UIControlStateNormal];
//                    break;
//                default:
//                    break;
//            }
//            //            NSMutableAttributedString *titleFontStr=[[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"+ %@",titleStr]];
//            //            NSRange range;
//            //            range.location=0;
//            //            range.length=1;
//            //            [titleFontStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:20] range:range];
//            //            [actionBtn setAttributedTitle:titleFontStr forState:UIControlStateNormal];
//            
//            [actionBtn setTitle:titleStr forState:UIControlStateNormal];
//            
//        }
    }
}

- (void)reloadButtonClicked:(id)sender{
    self.hidden = YES;
    [self removeFromSuperview];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_reloadButtonBlock) {
            _reloadButtonBlock(sender);
        }
    });
}

-(void)btnAction{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (_clickButtonBlock) {
            _clickButtonBlock(_curType);
        }
    });
}



@end


