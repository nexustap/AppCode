//
//  ShoppingCartViewController.m
//  OrderMeal
//
//  Created by 周浩 on 14-3-9.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import "ShoppingCartViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "shoppingCartCell.h"

@interface ShoppingCartViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSString *_memberID;
    NSString *_num;
    NSMutableArray *_goodsArray;  //购物车中的商品
    NSString *_price;
    NSString *_salesPrice;
    NSString *_name;
    NSMutableArray *_deleteArray;  //删除的商品
    
}

@end

@implementation ShoppingCartViewController

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
    _deleteArray=[NSMutableArray array];
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    _memberID=[userDefaults objectForKey:@"memberID"];
    
    [self requestWithMemberID:_memberID];
    
}

-(void)requestWithMemberID:(NSString *)memberID
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSDictionary *parameters=@{
                               @"memberId" : memberID
                               };

    [manager GET:cartview_url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
       _goodsArray =[responseObject[@"retData"] objectForKey:@"cartItems"];
       
        NSLog(@"-----%@",_goodsArray);
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
  


}

#pragma mark - request
-(void)requestWithMemberID:(NSString *)memberID
                   goodsid:(NSString *)goodsid
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSDictionary *parameters=@{
                               @"memberId" : memberID,
                               @"goosid" :  goodsid
                               };
    
    [manager GET:cartGoodsDelete_url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"删除成功" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil];
        [alert show];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}



#pragma mark dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _goodsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   shoppingCartCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CellShoppingCart"];
   NSDictionary *good=_goodsArray[indexPath.row];
   _num=[good objectForKey:@"quantity"] ;
   _price=[[good objectForKey:@"goods"]objectForKey:@"price"];
   _salesPrice=[[good objectForKey:@"goods"]objectForKey:@"salesPrice"];
   _name=[[good objectForKey:@"goods"]objectForKey:@"name"];
    
   cell.num.text=_num;
   cell.price.text=_price;
   cell.salesPrice.text=_salesPrice;
   cell.name.text=_name;
   
    if ([_deleteArray containsObject:good]) {
        cell.accessoryType=UITableViewCellAccessoryCheckmark;
    }else {
        cell.accessoryType=UITableViewCellAccessoryNone;
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *good=_goodsArray[indexPath.row];
    if ([_deleteArray containsObject:good]) {
        [_deleteArray removeObject:good];
    }else{
        [_deleteArray addObject:good];
    }
    [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationMiddle];
}

- (IBAction)deleteGood:(UIButton *)sender {
    NSMutableArray *deletePaths=[NSMutableArray array];
    for (NSDictionary *good in _deleteArray) {
        NSIndexPath *path=[NSIndexPath indexPathForItem:[_goodsArray indexOfObject:good] inSection:0];
        [deletePaths addObject:path];
        NSString *goodid =[good objectForKey:@"id"];
        [self requestWithMemberID:_memberID
                          goodsid: goodid];
        
    }
    
    [_goodsArray removeObjectsInArray:_deleteArray];
    [_deleteArray removeAllObjects];
    [self.tableView deleteRowsAtIndexPaths:deletePaths withRowAnimation:UITableViewRowAnimationTop];
}

- (IBAction)submit:(UIButton *)sender {
    
    
}

@end
