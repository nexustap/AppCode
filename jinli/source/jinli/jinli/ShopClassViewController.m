//
//  ShopClassViewController.m
//  jinli
//
//  Created by 金磊 on 14-1-13.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import "ShopClassViewController.h"
#import "ShopDetailViewController.h"
#import "ShopClassViewCell.h"

#import <AFNetworking.h>

@interface ShopClassViewController ()<UITableViewDataSource, DMPullRefreshTableViewDelegate>
{
    NSMutableArray *_tableData;
    NSInteger _page;
    NSNumber *_catId;
}

@property (nonatomic, weak) IBOutlet DMPullRefreshTableView *tableView;

@property (nonatomic, strong) DMSpinnerView *spinnerView;

@end

@implementation ShopClassViewController

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
	self.title = _shopClass[@"title"];
    
    _spinnerView = [[DMSpinnerView alloc] init];
    [self.view addSubview:_spinnerView];
    [_spinnerView startAnimating];
    
    //init
    _page = 1;
    
    _catId = _shopClass[@"catId"];
    if (_catId == nil) _catId = @0;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    DMPRINTMETHODNAME();
    
    [super viewDidAppear:animated];
    
    if (_tableData == nil) {
        _tableData = [NSMutableArray new];
        
        [self shopsWithAppId:@"JinLi"
                        type:@2
                       catId:_catId
                      userId:@10001
                        page:@(_page)
                    pageSize:@20];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)shopsWithAppId:(NSString*)appId
                  type: (NSNumber*)type
                 catId: (NSNumber*)catId
                userId: (NSNumber*)userId
                  page: (NSNumber*)page
              pageSize: (NSNumber*)pageSize
{
    DMPRINTMETHODNAME();
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"appId": appId,
                                 @"type": type,
                                 @"catId":catId,
                                 @"userId": userId,
                                 @"page" : page,
                                 @"pageSize" : pageSize};
    
    [manager GET:inquireCommunity_url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *communities = responseObject[@"communities"];
        if ([communities count]>0) {
            [_tableData addObjectsFromArray:communities];
            [self.tableView reloadData];
            
            //翻页计算
            _page++;
        }
        
        //关闭表格动画
        [self.tableView stopLoading];
        
        //关闭载入动画
        [_spinnerView stopAnimating];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        DMPRINT(@"Error: %@", error);
        [_spinnerView stopAnimating];
    }];
}

#pragma mark - prepare segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"商家信息"]) {
        ShopDetailViewController *controller = segue.destinationViewController;
        controller.cellData = sender;
        controller.hidesBottomBarWhenPushed =YES;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMPRINTMETHODNAME();
    
    static NSString *CellIdentifier = @"ShopClassViewCell";
    ShopClassViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if ([_tableData count] >0) {
        NSDictionary *cellData = _tableData[indexPath.row];
        DMPRINT(@"%@", cellData);
        cell.cellData = cellData;
    }
    
    return cell;
}

#pragma mark - EUPullRefreshTableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMPRINTMETHODNAME();
    
    if ([_tableData count] >0) {
        NSDictionary *cellData = _tableData[indexPath.row];
        
        [self performSegueWithIdentifier:@"商家信息" sender:cellData];
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    
}

- (void)didTriggerRefreshHeaderView:(DMPullRefreshTableView *)pullRefreshTableView
{
    
    [_tableData removeAllObjects];
    
    [self shopsWithAppId:@"JinLi"
                    type:@2
                   catId:_catId
                  userId:@10001
                    page:@1
                pageSize:@20];
}

- (void)didTriggerLoadMoreFooterView:(DMPullRefreshTableView *)pullRefreshTableView
{
    
    [self shopsWithAppId:@"JinLi"
                    type:@2
                   catId:_catId
                  userId:@10001
                    page:@(_page+1)
                pageSize:@20];
}


@end
