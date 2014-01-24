//
//  FilterViewController.m
//  jinli
//
//  Created by 金磊 on 14-1-5.
//  Copyright (c) 2014年 lordking. All rights reserved.
//

#import "FilterViewController.h"
#import "FilterViewCell.h"

@interface FilterViewController ()
{
    NSArray *_tableData;
}

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@end

@implementation FilterViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	
    _tableData = @[@{@"title":@"全部活动"},
                   @{@"title":@"本周活动"},
                   @{@"title":@"本月活动"},
                   @{@"title":@"下月活动"},
                   @{@"title":@"已过期活动"}];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    static NSString *CellIdentifier = @"FilterViewCell";
    FilterViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.data = _tableData[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DMPRINTMETHODNAME();
    
    NSDictionary *cellData = _tableData[indexPath.row];
//    if ([self.delegate respondsToSelector:@selector(didSelected:)]) {
        NSLog(@"...");
        [self.delegate didSelected:cellData];
//    }
}

@end
