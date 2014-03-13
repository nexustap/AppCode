//
//  ShoppingCardViewController.m
//  OrderMeal
//
//  Created by 宏创 on 14-1-27.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import "ShoppingCardViewController.h"

@interface ShoppingCardViewController ()
{
    NSArray *_array;
}

@end

@implementation ShoppingCardViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _array=[NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.imageView.image=[UIImage imageNamed:@"btn_center.png"];
    cell.textLabel.text=@"菜名：";
    cell.detailTextLabel.text=@"原价：   优惠价：    ";
    
    return cell;
}

@end
