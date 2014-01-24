//
//  FilterViewController.h
//  jinli
//
//  Created by 金磊 on 14-1-5.
//  Copyright (c) 2014年 lordking. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FilterViewControllerDelegate <NSObject>

-(void)didSelected:(NSDictionary*)cellData;

@end

@interface FilterViewController : UIViewController

@property (nonatomic, weak) id<FilterViewControllerDelegate> delegate;

@end
