//
//  ShopDetailViewController.m
//  jinli
//
//  Created by 金磊 on 14-1-14.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "ShopDetailShowTableViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface ShopDetailViewController ()<UIScrollViewDelegate>
{
    CGFloat _imagesScrollViewContentWidth;
}

@property (nonatomic, weak) IBOutlet UIScrollView *imagesScrollView;
@property (nonatomic, weak) IBOutlet UIView *imagesContentView;
@property (nonatomic, weak) IBOutlet UITextView *summaryTextView;
@property (nonatomic, weak) IBOutlet UILabel *communityNameLabel;
@property (nonatomic, weak) IBOutlet UIPageControl *imageScrollPageControl;

@end

@implementation ShopDetailViewController

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
	
    DMPRINT(@"cellData:%@", self.cellData);
    
    self.title = self.cellData[@"communityName"];
    self.communityNameLabel.text = self.cellData[@"communityName"];
    self.summaryTextView.text = self.cellData[@"remark"];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    DMPRINTMETHODNAME();
    
    [super viewDidLayoutSubviews];
    //调整画面长度
    [self.imagesScrollView layoutIfNeeded];
    
    //载入图片
    CGSize imageSize = CGSizeMake(320, 170);
    CGFloat imagesX = 0;
    if ([self.cellData objectForKey:@"images"]) {
        NSArray *images = self.cellData[@"images"];
        
        self.imageScrollPageControl.numberOfPages = [images count];
        self.imageScrollPageControl.currentPage = 0;
        
        for (NSString *imageUrlString in images) {
            
            NSURL *imageUrl = [NSURL URLWithString:imageUrlString];
            CGPoint imageViewOffset = CGPointMake(imagesX,  0);
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:(CGRect){.origin = imageViewOffset, .size = imageSize}];
            [imageView setImageWithURL:imageUrl
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            
            [_imagesContentView addSubview:imageView];
            
            imagesX += imageSize.width;
        }
        
        _imagesContentView.frame = CGRectMake(0, 0, imagesX, 170);
        _imagesScrollViewContentWidth = imagesX;
        
    }
    
    if (_imagesScrollViewContentWidth > 0) {
        _imagesScrollView.contentSize = CGSizeMake(_imagesScrollViewContentWidth, 170);
    }
    
}

#pragma mark - IBAction

-(IBAction)telAction:(id)sender
{
    NSString *url = [NSString stringWithFormat:@"tel://1234567890"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

#pragma mark - prepare segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"表格"]) {
        ShopDetailShowTableViewController *viewController = segue.destinationViewController;
        viewController.data = self.cellData;
    }
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    DMPRINT(@"scrollView.contentOffset x:%f", scrollView.contentOffset.x);
    
    self.imageScrollPageControl.currentPage = (NSInteger)(scrollView.contentOffset.x/320);
}

@end
