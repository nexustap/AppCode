//
//  ESUITabBarItem.m
//  mygoods
//
//  Created by 金磊 on 13-6-13.
//  Copyright (c) 2013年 金磊. All rights reserved.
//

#import "EUTabBarItem.h"

@implementation EUTabBarItem

- (id)initWithFinishedSelectedImage:(UIImage *)selectedImage withFinishedUnselectedImage:(UIImage *)unselectedImage{
    self = [super init];
    if (self) {
        _image = unselectedImage;
        _selectedImage = selectedImage;
        _unselectedImage = unselectedImage;
    }
    
    return self;
}

@end
