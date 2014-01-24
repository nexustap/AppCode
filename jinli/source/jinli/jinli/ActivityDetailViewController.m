//
//  ActivityDetailViewController.m
//  jinli
//
//  Created by 金磊 on 14-1-4.
//  Copyright (c) 2014年 lordking. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "AcitivityNavBarView.h"
#import "ActivityDetailDefaultViewController.h"
#import "ActivityDetailCommonViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface ActivityDetailViewController ()
{
    NSArray *_views;
    NSArray *_segues;
}

@property (nonatomic, weak) IBOutlet AcitivityNavBarView *navBar;

@property (nonatomic, weak) IBOutlet UIView *view1;
@property (nonatomic, weak) IBOutlet UIView *view2;
@property (nonatomic, weak) IBOutlet UIView *view3;
@property (nonatomic, weak) IBOutlet UIView *view4;

@end

@implementation ActivityDetailViewController


- (void)viewDidLoad
{
    [super viewDidLoad];

    //init 
    _views = @[_view1, _view2, _view3, _view4];
    _segues = @[@"view1", @"view2", @"view3", @"view4"];
    
}

- (void)didReceiveMemoryWarning
{
    DMPRINTMETHODNAME();
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

-(IBAction)switchButton:(id)sender
{
    DMPRINTMETHODNAME();
    DMPRINT(@"select: %ld", (long)self.navBar.selectedButtonIndex);
    
    for (NSInteger i = 0; i < _views.count; i++) {
        UIView *view = _views[i];
        if (i == self.navBar.selectedButtonIndex) {
            view.hidden = NO;
        } else {
            view.hidden = YES;
        }
    }

}

#pragma mark - prepare segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    DMPRINTMETHODNAME();
    if (self.cellData == nil) return;
    
    if ([segue.destinationViewController isKindOfClass:[ActivityDetailCommonViewController class]]) {
        ActivityDetailCommonViewController* viewController = segue.destinationViewController;
        viewController.cellData = self.cellData;
    }
}

@end
