//
//  UIViewController+HUD.h
//  CMSP
//
//  Created by 李棠松 on 2016/11/30.
//  Copyright © 2016年 李棠松. All rights reserved.
//


#import "UIBarButtonItem+Style.h"

@implementation UIBarButtonItem (Style)

+ (instancetype)barButtonWithType:(BarButtonType)barButtonType
{
    UIBarButtonItem *barButtonItem;
    if (self) {
        
        switch (barButtonType) {
            case BarButtonBack:
                barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"icon_nav_back"] style:UIBarButtonItemStyleDone target:nil action:nil];
                
                break;
            case BarButtonClose:
                barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"nav_close"] style:UIBarButtonItemStyleDone target:nil action:nil];
                
        };
    }
    return barButtonItem;
}


@end
