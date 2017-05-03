//
//  LTSCustomButton.h
//  SAIFAMC
//
//  Created by 李棠松 on 16/8/20.
//  Copyright © 2016年 leetangsong. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SELFWIDTH self.frame.size.width
#define SELFHEIGHT self.frame.size.height
@interface LTSCustomButton : UIButton

//点击视图相关
@property (nonatomic, strong)UIImageView *touchView; //点击显示的view
@property (nonatomic, strong)UIColor *touchColor; /**<按钮被点击时显示的提示颜色，默认为黑色半透明*/

@end
