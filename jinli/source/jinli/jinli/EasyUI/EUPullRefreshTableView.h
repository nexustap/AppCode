//
//  EURefreshTableView.h
//  mygoods
//
//  Created by 金磊 on 14-1-7.
//  Copyright (c) 2014年 lordking. All rights reserved.
//

#import <UIKit/UIKit.h>

/*!
 *  UITableView已经继承了UITableViewDelegate，并且将其delegate指向了自己。所以在使用是不能重复调用delegate。UITableViewDelegate由EUPullRefreshTableViewDelegate的相同名称的方法替代。
 */
@class EUPullRefreshTableView;

@protocol EUPullRefreshTableViewDelegate<NSObject>

@optional
/*!
 *  用于替代TableViewDelaget的代理方法
 *
 *  @param tableView <#tableView description#>
 *  @param indexPath <#indexPath description#>
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)didTriggerRefreshHeaderView:(EUPullRefreshTableView *)pullRefreshTableView;
- (void)didTriggerLoadMoreFooterView:(EUPullRefreshTableView *)pullRefreshTableView;

@end

@interface EUPullRefreshTableView : UITableView<UIScrollViewDelegate, UITableViewDelegate>

@property (nonatomic, weak) IBOutlet id <EUPullRefreshTableViewDelegate> pullDelegate;

- (void) stopLoading;

@end

