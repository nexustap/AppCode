//
//  MenuViewController.m
//  OrderMeal
//
//  Created by 宏创 on 14-2-25.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import "MenuViewController.h"
#import "BuyViewController.h"
#import "AFNetworking.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadData];
    
}

//加载数据
-(void)loadData
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    [manager GET:goodstype_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        NSNumber *status=responseObject[@"success"];
        if ([status isEqualToNumber:@1]) {
            
            //   NSArray *array=[responseObject objectForKey:@"retData"] ;
            NSArray *array=responseObject[@"retData"];
            NSLog(@"%@",array);
            
            NSDictionary *dict=array[0];
            
            // NSString *name=[dict objectForKey:@"name"];
            NSString *name=dict[@"name"];
            NSLog(@"%@",name);
            
        }else{
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"数据加载失败" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"数据加载失败");
    }];
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"购买";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if ([_tableData count]>0) {
        NSDictionary *cellData =_tableData[indexPath.row];
        
    }
    
    
    return cell;
}

#pragma mark -UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([_tableData count]>0) {
        NSDictionary *cellData=_tableData[indexPath.row];
        [self performSegueWithIdentifier:@"" sender:cellData];
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }

}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"购买"]) {
        BuyViewController *controller=segue.destinationViewController;
        
        controller.hidesBottomBarWhenPushed=YES;
    }
}

@end
