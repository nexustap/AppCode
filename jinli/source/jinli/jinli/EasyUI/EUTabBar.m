//
//  ESUITabBar.m
//  mygoods
//
//  Created by 金磊 on 13-6-15.
//  Copyright (c) 2013年 金磊. All rights reserved.
//

#import "EUDebug.h"
#import "EUTabBar.h"
#import "EUTabBarItem.h"

@interface EUTabBar()

@end

@implementation EUTabBar

- (void)setButtons:(NSArray*)buttons
{
    if (buttons == nil) {
        buttons = [[NSMutableArray alloc] init];
    }
}

- (void)setItems:(NSArray *)items
{
    EUDPRINTMETHODNAME();
    _items = items;
    
    [self createTabs];
}

- (void)layoutSubviews
{
    EUDPRINTMETHODNAME();

    if (self.backgroundImage) {
        self.backgroundColor = [UIColor colorWithPatternImage:self.backgroundImage];
    } else {
        self.backgroundColor = [UIColor grayColor];
    }

}

#pragma mark private method

-(void) createTabs
{
    EUDPRINTMETHODNAME();
        
    NSUInteger tabCount = self.items.count;
    CGFloat tabWidth = self.frame.size.width / tabCount;
    CGFloat tabBarHeight = self.frame.size.height;
    
    NSLog(@"tabBarHeight:%f",tabBarHeight);

    int tabCounter = 0;
    for (EUTabBarItem *item in self.items) {
        
        CGFloat buttonXValue = tabWidth*tabCounter;
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = tabCounter;
        button.frame = CGRectMake(buttonXValue, 0.0, tabWidth, tabBarHeight);
        
        [button setImage:item.image forState:UIControlStateNormal];
        [button setImage:item.selectedImage forState:UIControlStateHighlighted];
        [button setImage:item.selectedImage forState:UIControlStateSelected];
        
        [button setBackgroundImage:self.selectionIndicatorImage forState:UIControlStateHighlighted];
        [button setBackgroundImage:self.selectionIndicatorImage forState:UIControlStateSelected];
                
        [button addTarget:self action:@selector(tabTouchedDown:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(tabTouchedUp:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];

        tabCounter += 1;
    }
    
    [self tabTouchedDown:[self.subviews objectAtIndex:0]];
}

- (void)tabTouchedDown:(UIButton*)touchedTab
{
    EUDPRINTMETHODNAME();

    //select button
    for (UIButton *button in self.subviews) {
        [button setSelected:NO];
    }
    
    [touchedTab setSelected:YES];
}

- (void)tabTouchedUp:(UIButton*)touchedTab
{
    EUDPRINTMETHODNAME();
    
    [self.delegate buttonClicked:touchedTab];
}


@end
