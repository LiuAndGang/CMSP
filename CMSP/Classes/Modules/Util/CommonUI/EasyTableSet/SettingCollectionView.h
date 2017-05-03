//
//  SettingCollectionView.h
//  QuWorking
//
//  Created by xiaojia on 15/4/24.
//  Copyright (c) 2015年 eim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SettingGroup.h"


@interface SettingCollectionView : UICollectionView

@property (strong, nonatomic) NSMutableArray *groups;


- (SettingGroup *)addGroup;
@end
