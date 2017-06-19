//
//  LTSAboutViewController.h
//  CMSP
//
//  Created by 李棠松 on 2016/12/8.
//  Copyright © 2016年 李棠松. All rights reserved.
//

#import "LTSBaseViewController.h"

@interface LTSAboutViewController : LTSBaseViewController

/**App Store版本是否大于当前版本*/
@property (nonatomic,assign) int versionData;
/**App Store版本号*/
@property (nonatomic,copy) NSString *storeVersion;

@end
