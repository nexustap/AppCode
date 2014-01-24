//
//  EURefreshTableView.m
//  mygoods
//
//  Created by 金磊 on 14-1-7.
//  Copyright (c) 2014年 lordking. All rights reserved.
//

#import "EUPullRefreshTableView.h"
#import "EURefreshHeaderView.h"
#import "EULoadMoreFooterView.h"

#import "EUDebug.h"

static CGFloat REFRESH_HEADER_HEIGHT = 50.0f;
static CGFloat LOADMORE_FOOTER_HEIGHT = 30.0f;

typedef enum {
    EUPullRefreshNormal = 0,
    EUPullRefreshDragging,
    EUPullRefreshLoading,
} EUPullRefreshState;

typedef enum {
    EUDraggingNone = 0,
    EUDraggingDown,
    EUDraggingUp
} EUDraggingDirection;

@interface EUPullRefreshTableView (){
    EUPullRefreshState _pullstate;
    EUDraggingDirection _dragDirection;
    UIEdgeInsets _inset;
}

@property (nonatomic, strong) EURefreshHeaderView *refreshHeaderView;
@property (nonatomic, strong) EULoadMoreFooterView *loadMoreFooterView;

@end

@implementation EUPullRefreshTableView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addRefreshHeaderView];
        [self addLoadMoreFooterView];
        
        self.delegate = self;
    }
    
    return self;
}

#pragma mark - private method

- (void)addRefreshHeaderView
{
    CGRect frame = CGRectMake(0, -REFRESH_HEADER_HEIGHT, self.bounds.size.width, REFRESH_HEADER_HEIGHT);
    self.refreshHeaderView = [[EURefreshHeaderView alloc] initWithFrame:frame];
    
    [self addSubview:_refreshHeaderView];
}

- (void)addLoadMoreFooterView
{
    CGFloat y = MAX(self.contentSize.height, self.frame.size.height);
    self.loadMoreFooterView = [[EULoadMoreFooterView alloc] initWithFrame:CGRectMake(0, y, self.bounds.size.width, LOADMORE_FOOTER_HEIGHT)];
    self.tableFooterView = _loadMoreFooterView;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    if (_pullstate == EUPullRefreshLoading) return;
    //1.开始拉动
    _pullstate = EUPullRefreshDragging;
    if (_inset.top == 0) {
        _inset = self.contentInset;
    }
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    EUDPRINTMETHODNAME();
    
    if (_pullstate == EUPullRefreshDragging) { //拉动状态
        
        if (self.contentOffset.y < 0 && self.contentOffset.y <= _inset.top) { //向下拉动
            
            _dragDirection = EUDraggingDown;
            
            if (self.contentOffset.y >= - (REFRESH_HEADER_HEIGHT + _inset.top) ) {
                [_refreshHeaderView setText:@"下拉将会刷新"];
                [_refreshHeaderView startAnimation:HeaderViewAnimationWithin];
                
            } else {
                [_refreshHeaderView setText:@"松开即可刷新"];
                [_refreshHeaderView startAnimation:HeaderViewAnimationAbove];
                
            }
            
        } else if ( self.contentOffset.y > 0 ) { //向上拉动
            _dragDirection = EUDraggingUp;
            [_loadMoreFooterView setText:@"上拉即可加载更多"];
        }
        
    } else if (_pullstate == EUPullRefreshLoading) {//加载状态
        if (_dragDirection == EUDraggingDown) {
            self.contentInset = UIEdgeInsetsMake(-self.contentOffset.y, _inset.left, _inset.bottom, _inset.right);
        } 
        
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (_pullstate == EUPullRefreshLoading) return;
    
    if (_dragDirection == EUDraggingDown) {//向下拉动
        if (self.contentOffset.y <=  -(REFRESH_HEADER_HEIGHT + _inset.top)) {
            _pullstate = EUPullRefreshLoading;
            [_refreshHeaderView setText:@"刷新中..."];
            [_refreshHeaderView startAnimation:HeaderViewAnimationLoading];
            
            if ([_pullDelegate respondsToSelector:@selector(didTriggerRefreshHeaderView:)]) {
                [_pullDelegate didTriggerRefreshHeaderView:self];
            }
        }
        
    } else if (_dragDirection == EUDraggingUp) {//向上拉动
        CGFloat scrollDownOff = _inset.bottom + self.contentSize.height - self.frame.size.height - self.contentOffset.y;
        
        if (scrollDownOff <= 0) {
            _pullstate = EUPullRefreshLoading;
            [_loadMoreFooterView setText:@"加载中..."];
            [_loadMoreFooterView startAnimation:FooterViewAnimationLoading];
            
            if ([_pullDelegate respondsToSelector:@selector(didTriggerLoadMoreFooterView:)]) {
                [_pullDelegate didTriggerLoadMoreFooterView:self];
            }
        }
    }
}

- (void)stopLoading
{
    EUDPRINTMETHODNAME();
    
    if (_pullstate == EUPullRefreshLoading) {
        
        if (_dragDirection == EUDraggingDown) {//向下拉动
            [_refreshHeaderView setText:@"刷新完成"];
            [_refreshHeaderView stopAnimation];
            
        } else if (_dragDirection == EUDraggingUp) {//向上拉动
            [_loadMoreFooterView setText:@""];
            [_loadMoreFooterView stopAnimation];
        }
        
        [UIView animateWithDuration:0.3
                         animations:^{
                             self.contentInset = _inset;
                         }
                         completion:^(BOOL finished) {}];
        
        _pullstate = EUPullRefreshNormal;
        _dragDirection = EUDraggingNone;
    }
    
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    EUDPRINTMETHODNAME();
    
    if ([_pullDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [_pullDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

@end
