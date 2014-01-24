//
//  EUGlobalStyle.h
//  EasyUI
//
//  Created by 金磊 on 13-10-11.
//  Copyright (c) 2013年 lordking. All rights reserved.
//

#import <Foundation/Foundation.h>

///////////////////////////////////////////////////////////////////////////////////////////////////
// Color helpers

#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]

#define HSVCOLOR(h,s,v) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:1]
#define HSVACOLOR(h,s,v,a) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:(a)]

#define RGBA(r,g,b,a) (r)/255.0f, (g)/255.0f, (b)/255.0f, (a)

///////////////////////////////////////////////////////////////////////////////////////////////////
// Style helpers


#define EUSTYLESHEET ((id)[EUStyleSheet globalStyleSheet])

#define EUSTYLEVAR(_VARNAME) [EUSTYLESHEET _VARNAME]

@interface EUGlobalStyle : NSObject

@end
