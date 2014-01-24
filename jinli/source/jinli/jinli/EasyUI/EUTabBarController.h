//
//  ESUITabBarController.h
//  mygoods
//
//  Created by 金磊 on 13-6-15.
//  Copyright (c) 2013年 金磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EUTabBar.h"

@interface EUTabBarController : UITabBarController<EUTabBarDelegate>

@property (nonatomic, strong) NSArray* items;
@property (nonatomic, strong) EUTabBar* customTabBar;

@end
