//
//  ESUITabBar.h
//  mygoods
//
//  Created by 金磊 on 13-6-15.
//  Copyright (c) 2013年 金磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EUTabBarDelegate <NSObject>

@required 
- (void)buttonClicked:(UIButton*)sender;

@end

@interface EUTabBar : UIView

@property(nonatomic, retain) id <EUTabBarDelegate> delegate;

@property (nonatomic, strong) NSArray* items;
@property (nonatomic, strong) UIImage* backgroundImage;
@property (nonatomic, strong) UIImage* selectionIndicatorImage;

@end

