//
//  EUStyleSheet.m
//  EasyUI
//
//  Created by 金磊 on 13-10-11.
//  Copyright (c) 2013年 lordking. All rights reserved.
//

#import "EUStyleSheet.h"

static EUStyleSheet* gStyleSheet = nil;

@implementation EUStyleSheet

+ (EUStyleSheet*)globalStyleSheet {
    return gStyleSheet;
}

+ (void)setGlobalStyleSheet:(EUStyleSheet*)styleSheet {
    gStyleSheet = styleSheet;
}


@end
