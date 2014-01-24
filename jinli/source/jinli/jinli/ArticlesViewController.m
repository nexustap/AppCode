//
//  ArticlesViewController.m
//  jinli
//
//  Created by 金磊 on 14-1-5.
//  Copyright (c) 2014年 lordking. All rights reserved.
//

#import "ArticlesViewController.h"
#import "ArticleViewCell.h"
#import "ArticleDetailViewController.h"

#import <AFNetworking.h>

@interface ArticlesViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *_tableData;
    NSInteger _page;
}

@property (nonatomic, weak) IBOutlet DMPullRefreshTableView *tableView;

@end

@implementation ArticlesViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //init
    _page = 1;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (_tableData == nil) {
        _tableData = [NSMutableArray new];
        
        [self articlesWithAppId:@"schoolApp"
                           page:@1
                           size:@20];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)articlesWithAppId:(NSString*)appId
                     page: (NSNumber*)page
                     size: (NSNumber*)size
{
    DMPRINTMETHODNAME();
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"appId": appId,
                                 @"page" : page,
                                 @"size" : size};
    
    [manager GET:article_url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *result = responseObject[@"result"];
        
        if ([result count] > 0) {
            [_tableData addObjectsFromArray:result];
            [self.tableView reloadData];
            
            //翻页计算
            _page++;
        }
        
        //关闭载入动画
        [self.tableView stopLoading];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DMPRINT(@"Error: %@", error);
    }];
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ArticleDetailView"]) {
        ArticleDetailViewController *controller = segue.destinationViewController;
        controller.cellData = sender;
        controller.hidesBottomBarWhenPushed = YES;
    }
}

#pragma mark - Table view data source

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
    
    static NSString *CellIdentifier = @"ArticleViewCell";
    ArticleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if ([_tableData count] > 0) {
        cell.data = _tableData[indexPath.row];
    }
    
    return cell;
}

#pragma mark - DMPullRefreshTableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMPRINTMETHODNAME();
    
    if ([_tableData count] >0) {
        NSDictionary *cellData = _tableData[indexPath.row];
        DMPRINT(@"%@", cellData);
        
        [self performSegueWithIdentifier:@"ArticleDetailView" sender:cellData];
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    
}

- (void)didTriggerRefreshHeaderView:(DMPullRefreshTableView *)pullRefreshTableView
{
    
    [_tableData removeAllObjects];

    
    [self articlesWithAppId:@"schoolApp"
                       page:@1
                       size:@20];
}

- (void)didTriggerLoadMoreFooterView:(DMPullRefreshTableView *)pullRefreshTableView
{
    [self articlesWithAppId:@"schoolApp"
                       page:@(_page+1)
                       size:@20];
}

@end
