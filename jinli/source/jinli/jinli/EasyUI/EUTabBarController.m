//
//  ESUITabBarController.m
//  mygoods
//
//  Created by 金磊 on 13-6-15.
//  Copyright (c) 2013年 金磊. All rights reserved.
//

#import "EUDebug.h"
#import "EUTabBarController.h"

@interface EUTabBarController ()

@end

@implementation EUTabBarController


- (void)viewDidLoad
{
    [super viewDidLoad];
    EUDPRINTMETHODNAME();
    
    [self hideTabBar];
    [self addCustomTabBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    EUDPRINTMETHODNAME();
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark private method

- (void)hideTabBar
{
    EUDPRINTMETHODNAME();
    
	for(UIView *view in self.view.subviews)
	{
		if([view isKindOfClass:[UITabBar class]])
		{
			view.hidden = YES;
			break;
		}
	}
}

- (void)addCustomTabBar
{
     EUDPRINTMETHODNAME();

    self.customTabBar = [[EUTabBar alloc] init];
    _customTabBar.delegate = self;
    [self.view addSubview: self.customTabBar];
}

#pragma mark public method
- (void)setItems:(NSArray *)items
{
    [self.customTabBar setItems:items];
}

#pragma mark implement ESUITabBarDelegate

- (void)buttonClicked:(UIButton*)sender
{
     EUDPRINTMETHODNAME();
    
	NSUInteger tabID = [sender tag];
	self.selectedIndex = tabID;
}

@end
