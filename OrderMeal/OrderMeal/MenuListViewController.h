//
//  MenuListViewController.h
//  OrderMeal
//
//  Created by 宏创 on 14-3-6.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuListViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,copy) NSString *regionID;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

- (IBAction)indexChange:(UISegmentedControl *)sender;


@end
