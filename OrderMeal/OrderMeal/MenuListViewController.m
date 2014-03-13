//
//  MenuListViewController.m
//  OrderMeal
//
//  Created by 宏创 on 14-3-6.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import "MenuListViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "GoodDetailViewController.h"

@interface MenuListViewController ()
{
    NSString *_date;               //当前时间
    NSString *_goodsTypeID;        //商品类型
    NSMutableArray *_goodsArray ;  //商品
    NSString *_goodID;             //商品id
}

@end

@implementation MenuListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void)loadView
{
  [super loadView];
   
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    _date=[dateFormatter stringFromDate:[NSDate date]];
    
   // _goodsTypeID=[NSString stringWithFormat:@"%d",self.segment.selectedSegmentIndex+1];
   
    _regionID=@"1";
   
//    _goodsArray=@[
//                  @{
//                      @"apple" : @"广东" ,
//                      @"orange" : @"海南"
//                      },
//                  @{
//                      @"apple" : @"北京" ,
//                      @"orange" : @"武汉"
//                      },
//                  @{
//                      @"apple" : @"湖南" ,
//                      @"orange" : @"长沙"
//                      },
//                  
//                  ];
    
         [self requestWithDate:_date
                  regionId:_regionID
                  goodsTypeId:@"1"];
    
}

-(void)requestWithDate:(NSString *)date
                regionId:(NSString *)regionID
                goodsTypeId:(NSString *)goodsTypeID
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSDictionary *parameters=@{
                               @"regionId" :   regionID,
                               @"date"     :   date,
                               @"goodsTypeId" : goodsTypeID
                               };
    [manager GET:regiongoods_url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        _goodsArray=responseObject[@"retData"];
        [_tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%@",_goodsArray);
    return _goodsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier=@"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    NSDictionary *good =_goodsArray[indexPath.row];
    
    cell.textLabel.text=[NSString stringWithFormat:@"%@",[[good objectForKey:@"goods"] objectForKey:@"name"]];
    cell.detailTextLabel.text=[[good objectForKey:@"goods"]objectForKey:@"description"];
    
//    cell.textLabel.text=[NSString stringWithFormat:@"%@",[good objectForKey:@"apple"]];
//    cell.detailTextLabel.text=[NSString stringWithFormat:@"%@",[good objectForKey:@"orange"]];
//    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath=[self.tableView indexPathForCell:sender];
    _goodID=[[_goodsArray[indexPath.row] objectForKey:@"goods"]objectForKey:@"id"];
    
    GoodDetailViewController *destinationVC=segue.destinationViewController;
    destinationVC.goodsid=_goodID;
}

- (IBAction)indexChange:(UISegmentedControl *)sender {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5];
    
    _goodsTypeID=[NSString stringWithFormat:@"%d",sender.selectedSegmentIndex+1];
    
    [self requestWithDate:_date
                  regionId:_regionID
               goodsTypeId:_goodsTypeID];
    
    [UIView commitAnimations];
}

@end
