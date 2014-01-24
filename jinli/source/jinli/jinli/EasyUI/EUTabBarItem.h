//
//  ESUITabBarItem.h
//  mygoods
//
//  Created by 金磊 on 13-6-13.
//  Copyright (c) 2013年 金磊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface EUTabBarItem : NSObject

@property (nonatomic, strong) UIImage* image;
@property (nonatomic, strong) UIImage* selectedImage;
@property (nonatomic, strong) UIImage* unselectedImage;
@property (nonatomic, strong) NSString* badgeValue;
@property (nonatomic, strong) NSString* clickSound;

- (id)initWithFinishedSelectedImage:(UIImage *)selectedImage withFinishedUnselectedImage:(UIImage *)unselectedImage;

@end
