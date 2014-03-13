//
//  BranchViewController.m
//  OrderMeal
//
//  Created by 宏创 on 14-3-11.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import "BranchViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "MenuListViewController.h"

@interface BranchViewController ()
{
    NSArray *_dataArray;   //数据
    NSDictionary *_dict;  //数据字典
    NSString *_regionID;   //店铺ID
    NSString *_storeName;  //店铺名字
}

@end

@implementation BranchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self loadData];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" ];
    
    _dict=[_dataArray objectAtIndex:indexPath.row];
    _storeName=[_dict objectForKey:@"name"];
    NSLog(@"----%@",_storeName);
    
    
    cell.textLabel.text=_storeName;
    
    return cell;

}

-(void)loadData
{
    AFHTTPRequestOperationManager *manger=[AFHTTPRequestOperationManager manager];
    [manger GET:region_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSNumber *status=responseObject[@"success"];
        if ([status isEqualToNumber:@1]) {
            _dataArray= [responseObject[@"retData"] objectForKey:@"regions"];
            NSLog(@"%@",_dataArray);
            [self.tableView reloadData];
            
        }else{
            NSLog(@"---%@",responseObject[@"msg"]);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"---无法访问");
    }];
}


#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath=[self.tableView indexPathForCell:sender];
    _dict=[_dataArray objectAtIndex:indexPath.row];
    _regionID=[_dict objectForKey:@"id"];
    
    MenuListViewController *menuList=segue.destinationViewController;
    menuList.regionID=_regionID;
}


@end
