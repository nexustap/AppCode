//
//  ShopsViewController.m
//  jinli
//
//  Created by 金磊 on 14-1-13.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import "ShopsViewController.h"
#import "ShopViewCell.h"
#import "ShopClassViewController.h"
#import "ShopDetailViewController.h"

#import <AFNetworking/AFNetworking.h>

typedef enum {
    SEARCH_SHOP = 0,
    SEARCH_MEMBER
} SearchOption;

@interface ShopsViewController ()<UITableViewDelegate, UISearchBarDelegate,UISearchDisplayDelegate, UICollectionViewDataSource, UICollectionViewDelegate>
{
    NSMutableArray *_searchResult;
    SearchOption _searchOption;
    NSMutableArray *_shops;
}

@property (nonatomic, weak) IBOutlet UISearchBar *searchBar;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) DMSpinnerView *spinnerView;

@end

@implementation ShopsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    DMPRINTMETHODNAME();
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    DMPRINTMETHODNAME();
    
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    _spinnerView = [[DMSpinnerView alloc] init];
    [self.view addSubview:_spinnerView];
    [_spinnerView becomeFirstResponder];
    
	// Do any additional setup after loading the view.
    _searchResult = [NSMutableArray new];
    _shops = [NSMutableArray new];
    
    [_shops addObjectsFromArray:@[
                                  @{@"image": @"shopclass-1", @"catId":@1,@"title":@"特色餐饮"},
                                  @{@"image": @"shopclass-2", @"catId":@2,@"title":@"小吃街"},
                                  @{@"image": @"shopclass-3", @"catId":@3,@"title":@"酒吧街"},
                                  @{@"image": @"shopclass-4", @"catId":@4,@"title":@"锦里客栈"},
                                  @{@"image": @"shopclass-5", @"catId":@5,@"title":@"名俗商品"}
                                  ]];
}

- (void)viewDidAppear:(BOOL)animated
{
    DMPRINTMETHODNAME();
    
    [super viewDidAppear:animated];
    
    if (self.searchDisplayController.active) {
        self.searchDisplayController.searchBar.text = self.searchDisplayController.searchBar.text;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

- (void)search:(NSString*)searchText option:(SearchOption)option
{
    DMPRINTMETHODNAME();
    [_searchResult removeAllObjects];
    
    DMPRINT(@"search:%@", searchText);
    if (option == SEARCH_SHOP && searchText.length >=2 ) {
        [self shopsWithAppId:@"JinLi"
                        type:@5
                     keyword:searchText
                      userId:@10001
                        page:@1
                    pageSize:@40];
        
    } else if (option == SEARCH_MEMBER) {
        [_searchResult addObjectsFromArray:@[@"用户1",@"用户2",@"用户3",@"用户4",@"用户5"]];
    }
}

- (void)shopsWithAppId: (NSString*)appId
                  type: (NSNumber*)type
               keyword: (NSString*)keyword
                userId: (NSNumber*)userId
                  page: (NSNumber*)page
              pageSize: (NSNumber*)pageSize
{
    DMPRINTMETHODNAME();
    
    [_spinnerView stopAnimating];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"appId": appId,
                                 @"type": type,
                                 @"keyword":keyword,
                                 @"userId": userId,
                                 @"page" : page,
                                 @"pageSize" : pageSize};
    
    [manager GET:inquireCommunity_url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *communities = responseObject[@"communities"];
        if ([communities count] > 0) {
            [_searchResult addObjectsFromArray:communities];
            
            [self.searchDisplayController.searchResultsTableView reloadData];
        }
        
        //关闭载入动画
        [_spinnerView stopAnimating];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        DMPRINT(@"Error: %@", error);
        [_spinnerView stopAnimating];
    }];
}

#pragma mark - segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DMPRINTMETHODNAME();
    
    if ([segue.identifier isEqualToString:@"个人信息"]) {
        
    } else if ([segue.identifier isEqualToString:@"商家信息"]) {
        ShopDetailViewController *viewController = segue.destinationViewController;
        viewController.cellData = sender;
        
    } else if ([segue.identifier isEqualToString:@"商家类别浏览"]) {
        ShopClassViewController *viewController = segue.destinationViewController;
        viewController.shopClass = sender;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    DMPRINTMETHODNAME();
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [_searchResult count];
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMPRINTMETHODNAME();
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (_searchResult[indexPath.row]) {
        NSDictionary *row = _searchResult[indexPath.row];
        cell.textLabel.text = row[@"communityName"];
    }
    
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
    return cell;
}

#pragma mark TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_searchOption == SEARCH_SHOP) {
        NSDictionary *row = _searchResult[indexPath.row];
        [self performSegueWithIdentifier:@"商家信息" sender:row];
        
    } else if (_searchOption == SEARCH_MEMBER) {
        [self performSegueWithIdentifier:@"个人信息" sender:nil];
    }
    
}

#pragma mark - UISearchDisplayController

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    
    [self search:searchString option:_searchOption];
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    DMPRINTMETHODNAME();
    
    _searchOption = searchOption;
    [self search:[self.searchDisplayController.searchBar text] option:_searchOption];
    
    return YES;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_shops count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ShopViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopViewCell" forIndexPath:indexPath];
    
    cell.cellData = _shops[indexPath.row];
    
    return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DMPRINTMETHODNAME();
    
    //打开指定的viewcontroller
    [self performSegueWithIdentifier:@"商家类别浏览" sender:_shops[indexPath.row]];
    
    //取消选择
    [self.collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

@end
