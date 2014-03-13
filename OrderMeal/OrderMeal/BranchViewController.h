//
//  BranchViewController.h
//  OrderMeal
//
//  Created by 宏创 on 14-3-11.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BranchViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end
