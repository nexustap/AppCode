//
//  MyPointsViewController.m
//  OrderMeal
//
//  Created by 周浩 on 14-3-9.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import "MyPointsViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface MyPointsViewController ()
{
    NSString *_customerID; //会员id
}

@end

@implementation MyPointsViewController

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
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    _customerID=[userDefaults objectForKey:@"memberID"];
    
    [self requestWithCustomerID:_customerID];
    
}

-(void)requestWithCustomerID:(NSString *)customerId
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSDictionary *parameters=@{
                               @"customerId" :customerId
                              };
    [manager GET:points_url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
     NSArray *array=responseObject[@"retData"];
     NSDictionary *dict=array[0];
     self.myPoints.text=[dict objectForKey:@"num"];
    
} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    
}];
    
}



@end
