//
//  GoodDetailViewController.m
//  OrderMeal
//
//  Created by 宏创 on 14-3-7.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import "GoodDetailViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface GoodDetailViewController ()
{
    NSString *_memberID;
    NSInteger _quantity;
}

@end

@implementation GoodDetailViewController

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
    
    self.imageView.image=[UIImage imageNamed:@"book.jpg"];

    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    _memberID=[defaults objectForKey:@"memberID"];
    _quantity=[self.quantityField.text intValue] ;
    
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


-(void)requestWithMemberID:(NSString *)memberId
                   goodsID:(NSString *)goodsid
                  quantitu:(NSString *)quantity
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSDictionary *parameters=@{
                               @"memberId" : memberId,
                               @"goodsid"  : goodsid,
                               @"quantity" : quantity
                               };
    [manager GET:cartadd_url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSNumber *status=responseObject[@"success"];
        if ([status isEqualToNumber:@1]) {
            NSLog(@"加入购物车成功");
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"添加购物车成功" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
            [alert show];
        }else{
            NSLog(@"--%@",responseObject[@"msg"]);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
    }];
}

-(void)requestWithEmail:(NSString *)email
               goodsids:(NSString *)goodsids
               buildingID:(NSString *)buildingID
               address:(NSString *)address
               time:(NSString *)time
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSDictionary *parameters=@{
                                   @"email" :  email,
                                   @"goodsids" : goodsids,
                                   @"buildingID" : buildingID,
                                   @"address" :  address,
                                   @"time" :   time
                                   };
    
    [manager GET:memSubmit_url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSNumber *status=responseObject[@"success"];
        if ([status isEqualToNumber:@1]) {
            NSLog(@"下单成功");
        }else{
            NSLog(@"--%@",responseObject[@"msg"]);
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (IBAction)addShoppingCard:(UIButton *)sender {
    
    [self requestWithMemberID:_memberID
                      goodsID:_goodsid
                     quantitu:self.quantityField.text];
    
}

- (IBAction)buy:(UIButton *)sender {
    
    [self requestWithEmail:nil
                  goodsids:nil
                buildingID:nil
                   address:nil
                     time:nil];
}

- (IBAction)minus:(UIButton *)sender {
    if(--_quantity==1)
    {
        self.minus.enabled=NO;
    }
    self.quantityField.text=[NSString stringWithFormat:@"%d",_quantity];
}

- (IBAction)add:(UIButton *)sender {
    self.quantityField.text=[NSString stringWithFormat:@"%d",_quantity++];
    
}

@end
