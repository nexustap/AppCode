//
//  ActivitiesViewController.m
//  jinli
//
//  Created by 金磊 on 14-1-5.
//  Copyright (c) 2014年 lordking. All rights reserved.
//

#import "ActivitiesViewController.h"
#import "ActivityViewCell.h"
#import "ActivityDetailViewController.h"

#import <AFNetworking.h>

@interface ActivitiesViewController ()<UITableViewDataSource, DMPullRefreshTableViewDelegate>
{
    NSMutableArray *_tableData;
    NSInteger _page;
}

@property (nonatomic, weak) IBOutlet DMPullRefreshTableView *tableView;

@property (nonatomic, strong) DMSpinnerView *spinnerView;

@end

@implementation ActivitiesViewController


- (void)viewDidLoad
{
    DMPRINTMETHODNAME();
    [super viewDidLoad];
    
    _spinnerView = [[DMSpinnerView alloc] init];
    [self.view addSubview:_spinnerView];
    [_spinnerView startAnimating];
    
    //init
    _page = 1;
}

- (void)viewDidAppear:(BOOL)animated
{
    DMPRINTMETHODNAME();
    
    [super viewDidAppear:animated];
    
    if (_tableData == nil) {
        _tableData = [NSMutableArray new];
        
        [self activitiesWithAppId:@"JinLi"
                             type:@1
                           userId:@10001
                             page:@(_page)
                         pageSize:@20];
    }
}

- (void)didReceiveMemoryWarning
{
    DMPRINTMETHODNAME();
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)activitiesWithAppId:(NSString*)appId
                       type: (NSNumber*)type
                     userId: (NSNumber*)userId
                       page: (NSNumber*)page
                   pageSize: (NSNumber*)pageSize
{
    DMPRINTMETHODNAME();
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"appId": appId,
                                 @"type": type,
                                 @"userId": userId,
                                 @"page" : page,
                                 @"pageSize" : pageSize};
    
    [manager GET:getActivity_url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *activities = responseObject[@"activities"];
        if ([activities count]>0) {
            [_tableData addObjectsFromArray:activities];
            [self.tableView reloadData];
            
            //翻页计算
            _page++;
        }
        
        //关闭载入动画
        [self.tableView stopLoading];
        
        //
        [_spinnerView stopAnimating];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DMPRINT(@"Error: %@", error);
        
    }];
}



#pragma mark - prepare segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ActivityDetailView"]) {
        ActivityDetailViewController *controller = segue.destinationViewController;
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
    
    static NSString *CellIdentifier = @"ActivityViewCell";
    ActivityViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if ([_tableData count] >0) {
        cell.data = _tableData[indexPath.row];
    }
    
    return cell;
}

#pragma mark - EUPullRefreshTableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMPRINTMETHODNAME();
    
    if ([_tableData count] >0) {
        NSDictionary *cellData = _tableData[indexPath.row];
        DMPRINT(@"%@", cellData);
        
        [self performSegueWithIdentifier:@"ActivityDetailView" sender:cellData];
        [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    
}

- (void)didTriggerRefreshHeaderView:(DMPullRefreshTableView *)pullRefreshTableView
{
    
    [_tableData removeAllObjects];
    
    [self activitiesWithAppId:@"JinLi"
                         type:@1
                       userId:@10001
                         page:@1
                     pageSize:@20];

}

- (void)didTriggerLoadMoreFooterView:(DMPullRefreshTableView *)pullRefreshTableView
{
    
    [self activitiesWithAppId:@"JinLi"
                         type:@1
                       userId:@10001
                         page:@(_page+1)
                     pageSize:@20];
}

@end
