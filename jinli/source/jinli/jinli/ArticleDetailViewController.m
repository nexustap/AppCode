//
//  ArticleDetailViewController.m
//  jinli
//
//  Created by 金磊 on 14-1-5.
//  Copyright (c) 2014年 lordking. All rights reserved.
//

#import "ArticleDetailViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>

static CGFloat BOTTOM_SPACE = 60.f;

@interface ArticleDetailViewController ()
{
    CGFloat _contentHeight;
}

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (nonatomic, weak) IBOutlet UILabel *articleTitle;
@property (nonatomic, weak) IBOutlet UILabel *articleMark;

@property (nonatomic, strong) DMSpinnerView *spinnerView;

@end

@implementation ArticleDetailViewController

-(id)initWithCoder:(NSCoder *)aDecoder
{
    DMPRINTMETHODNAME();
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        _spinnerView = [[DMSpinnerView alloc] init];
        [self.scrollView addSubview:_spinnerView];
        [_spinnerView resignFirstResponder];
        [_spinnerView startAnimating];
    }
    
    return self;
}

- (void)viewDidLoad
{
    DMPRINTMETHODNAME();
    [super viewDidLoad];

    //标题
    NSString *title = self.cellData[@"title"];
    self.articleTitle.text = title;
    
    //标注
    NSString *mark = [NSString stringWithFormat:@"%@  %@", self.cellData[@"date"], self.cellData[@"author"]];
    self.articleMark.text = mark;

    //图片
    CGFloat bodyViewY = 90.0f;
    if ([self.cellData objectForKey:@"images"]) {
        NSArray *images = [self.cellData[@"images"] componentsSeparatedByString:@","];
        
        for (NSString *imageUrlString in images) {
            
            NSURL *imageUrl = [NSURL URLWithString:imageUrlString];
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView setImageWithURL:imageUrl
                      placeholderImage:[UIImage imageNamed:@"placeholder.png"]
                             completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
                                 
                                 CGFloat bodyViewX = (_scrollView.bounds.size.width - image.size.width) / 2;
                                 CGPoint imageViewOffset = CGPointMake(bodyViewX,  bodyViewY);
                                 imageView.frame = (CGRect){.origin = imageViewOffset, .size = image.size};
                      }];
            
            
            CGFloat bodyViewX = (_scrollView.bounds.size.width - imageView.image.size.width) / 2;
            CGPoint imageViewOffset = CGPointMake(bodyViewX,  bodyViewY);
            imageView.frame = (CGRect){.origin = imageViewOffset, .size = imageView.image.size};
            
            [_scrollView addSubview:imageView];
            bodyViewY += imageView.bounds.size.height + 10;
            
        }
    }
    
    NSString *text = self.cellData[@"body"];
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(0, bodyViewY, _scrollView.bounds.size.width, 40)];
    textView.text = text;
    [textView sizeToFit];
    [_scrollView addSubview:textView];
    
    bodyViewY = bodyViewY + textView.bounds.size.height;
    _contentHeight = bodyViewY + BOTTOM_SPACE;
    
    //调整画面长度
}

-(void)viewDidAppear:(BOOL)animated
{
    DMPRINTMETHODNAME();
    [super viewDidAppear:animated];
    [_spinnerView stopAnimating];
}

- (void)viewDidLayoutSubviews
{
    DMPRINTMETHODNAME();
    
    [super viewDidLayoutSubviews];
    //调整画面长度
    [self.scrollView layoutIfNeeded];
    if (_contentHeight > 0) {
        self.scrollView.contentSize = CGSizeMake(320, _contentHeight);
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
