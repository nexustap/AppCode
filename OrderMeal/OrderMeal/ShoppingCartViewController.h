//
//  ShoppingCartViewController.h
//  OrderMeal
//
//  Created by 周浩 on 14-3-9.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShoppingCartViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)deleteGood:(UIButton *)sender;

- (IBAction)submit:(UIButton *)sender;

@end
