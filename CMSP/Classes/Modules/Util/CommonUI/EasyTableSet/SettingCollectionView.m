//
//  SettingCollectionView.m
//  QuWorking
//
//  Created by xiaojia on 15/4/24.
//  Copyright (c) 2015年 eim. All rights reserved.
//

#import "SettingCollectionView.h"
#import "SettingCollectionCell.h"

@interface SettingCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

static NSString * const reuseIdentifier = @"Cell";

@implementation SettingCollectionView


- (SettingGroup *)addGroup
{
    SettingGroup *group = [SettingGroup group];
    [self.groups addObject:group];
    return group;
}

-(NSMutableArray *)groups
{
    if (!_groups) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

-(instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    
    if (self) {
        
        self.dataSource = self;
        self.delegate = self;
        //注册自定义的UICollectionViewCell
        [self registerClass:[SettingCollectionCell class] forCellWithReuseIdentifier:reuseIdentifier];
    }
    
    return self;
}

@end
