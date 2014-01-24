//
//  EUStyleSheet.h
//  EasyUI
//
//  Created by 金磊 on 13-10-11.
//  Copyright (c) 2013年 lordking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface EUStyleSheet : NSObject

+ (EUStyleSheet*)globalStyleSheet;
+ (void)setGlobalStyleSheet:(EUStyleSheet*)styleSheet;

@end
