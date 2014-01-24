//
//  EventsViewController.m
//  jinli
//
//  Created by 金磊 on 14-1-2.
//  Copyright (c) 2014年 lordking. All rights reserved.
//

#import "NewsViewController.h"
#import "FilterViewController.h"
#import "AppDelegate.h"

#import <Canvas/CSAnimationView.h>
#import <AFNetworking.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface NewsViewController ()<FilterViewControllerDelegate>
{
    BOOL _filterViewIsHidden;
}

//界面布局
@property (weak, nonatomic) IBOutlet UISegmentedControl *viewSelectionControl;
@property (weak, nonatomic) IBOutlet UIView *activitiesView;
@property (weak, nonatomic) IBOutlet UIView *articlesView;
@property (nonatomic, weak) IBOutlet UIView *filterView;
@property (nonatomic, weak) IBOutlet UIBarButtonItem *leftButton;

@property (nonatomic, strong) DMUserinfo *userinfo;

@end

@implementation NewsViewController

- (void)viewDidLoad
{
    DMPRINTMETHODNAME();
    [super viewDidLoad];
    
    //图片缓存地址
    _filterViewIsHidden = YES;
}

- (void)didReceiveMemoryWarning
{
    DMPRINTMETHODNAME();
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    DMPRINTMETHODNAME();
    
    _userinfo = [self userinfo];
    if ([_userinfo isLogon]) {
        DMPRINT(@"name:%@", _userinfo[@"name"]);
        _leftButton.title = @"退出";
    } else {
         _leftButton.title = @"登录";
    }
}

#pragma mark - private method

/**
 *  取出共享用户对象
 *
 *  @return 返回蓝牙对象
 */
-(DMUserinfo*) userinfo
{
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return appDelegate.userinfo;
}

#pragma mark - IBAction

//切换界面
- (IBAction)switchView:(id)sender
{
    DMPRINTMETHODNAME();
    DMPRINT(@"select %ld", (long)self.viewSelectionControl.selectedSegmentIndex);
    
    switch (self.viewSelectionControl.selectedSegmentIndex) {
        case 0:
        default: {
            [self.activitiesView setHidden:NO];
            [self.articlesView setHidden:YES];

        }
            break;
        case 1: {
            [self.activitiesView setHidden:YES];
            [self.articlesView setHidden:NO];
        }
            break;
    }
}

- (IBAction)openFilterView:(id)sender
{
    DMPRINTMETHODNAME();
    
    if (_filterViewIsHidden) {
        self.filterView.hidden = NO;
        _filterViewIsHidden = NO;
        
        //动画弹出菜单
        // Start
        self.filterView.alpha = 0;
        self.filterView.transform = CGAffineTransformMakeTranslation(0, -300);
        [UIView animateKeyframesWithDuration:0.5 delay:0 options:0 animations:^{
            // End
            self.filterView.alpha = 1;
            self.filterView.transform = CGAffineTransformMakeTranslation(0, 0);
        } completion:^(BOOL finished) {}];
        
        [self.filterView startCanvasAnimation];
        
    } else {
        
        self.filterView.alpha = 1;
        [UIView animateKeyframesWithDuration:0.5 delay:0.2 options:0 animations:^{
            // End
            self.filterView.alpha = 0;
        } completion:^(BOOL finished) {
            self.filterView.hidden = YES;
        }];
        
        [self.filterView startCanvasAnimation];
        _filterViewIsHidden = YES;

    }
    
}

-(IBAction)signinView:(id)sender
{
    //如果已经登录就退出
    if ([_userinfo isLogon]) {
        [_userinfo signOut];
    }
    [self performSegueWithIdentifier:@"用户登录" sender:nil];
}

#pragma mark - segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"FilterViewController"]) {
        FilterViewController *filterViewController = segue.destinationViewController;
        filterViewController.delegate = self;
    }
}

#pragma mark - FilterViewControllerDelegate

- (void)didSelected:(NSDictionary *)cellData
{
    DMPRINT(@"select:%@", cellData);
    
    self.filterView.alpha = 1;
    [UIView animateKeyframesWithDuration:0.5 delay:0.2 options:0 animations:^{
        self.filterView.alpha = 0;
    } completion:^(BOOL finished) {
        self.filterView.hidden = YES;
    }];
    
    [self.filterView startCanvasAnimation];
    _filterViewIsHidden = YES;

}

@end
