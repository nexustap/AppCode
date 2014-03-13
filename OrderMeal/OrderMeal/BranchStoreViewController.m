//
//  BranchStoreViewController.m
//  OrderMeal
//
//  Created by 宏创 on 14-3-6.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import "BranchStoreViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "BranchStoreCell.h"
#import "MenuListViewController.h"

@interface BranchStoreViewController ()
{
    NSArray *_dataArray;   //数据
    NSDictionary *_dict;  //数据字典
    NSString *_regionID;   //店铺ID
    NSString *_storeName;  //店铺名字
}

@end

@implementation BranchStoreViewController

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
    
    [self.collectionView registerClass:[BranchStoreCell class] forCellWithReuseIdentifier:@"CollectionCell"];
   
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc]init];
    [layout setItemSize:CGSizeMake(100, 150)];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.collectionView setCollectionViewLayout:layout];
   
    [self loadData];
}

-(void)loadData
{
    AFHTTPRequestOperationManager *manger=[AFHTTPRequestOperationManager manager];
    [manger GET:region_url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSNumber *status=responseObject[@"success"];
        if ([status isEqualToNumber:@1]) {
              _dataArray= [responseObject[@"retData"] objectForKey:@"regions"];
            NSLog(@"%@",_dataArray);
            [self.collectionView reloadData];
           
        }else{
            NSLog(@"---%@",responseObject[@"msg"]);
        }

      
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"---无法访问");
    }];
}

#pragma mark -data
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BranchStoreCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    
    _dict=[_dataArray objectAtIndex:indexPath.row];
    _storeName=[_dict objectForKey:@"name"];
    NSLog(@"----%@",_storeName);
    
    cell.imageView.image=[UIImage imageNamed:@"default_nopic.png"];
    cell.label.text=_storeName;
   
    return cell;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath=[self.collectionView indexPathForCell:sender];
    _dict=[_dataArray objectAtIndex:indexPath.row];
    _regionID=[_dict objectForKey:@"id"];
    
    MenuListViewController *menuList=segue.destinationViewController;
    menuList.regionID=_regionID;
}

@end
