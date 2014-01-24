//
//  ShopDetailShowTableViewController.m
//  jinli
//
//  Created by 金磊 on 14-1-16.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import "ShopDetailShowTableViewController.h"

@interface ShopDetailShowTableViewController ()<UITableViewDelegate>

@end

@implementation ShopDetailShowTableViewController

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        NSString *url = [NSString stringWithFormat:@"http://maps.apple.com/?q=锦里+%@&z=9",self.data[@"address"]];
        url =  [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
    }
}

@end
