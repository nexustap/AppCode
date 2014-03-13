//
//  MenuViewController.h
//  OrderMeal
//
//  Created by 宏创 on 14-2-25.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *_tableData;
    
    
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
