//
//  ActivityDetailDefaultViewController.m
//  jinli
//
//  Created by 金磊 on 14-1-10.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import "ActivityDetailDefaultViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <DTCoreText/DTCoreText.h>

static CGFloat BOTTOM_SPACE;

@interface ActivityDetailDefaultViewController ()
{
    CGFloat _contentHeight;
}

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;

@property (nonatomic, weak) IBOutlet UIImageView *imageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *organizerLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *placeLabel;
@property (nonatomic, weak) IBOutlet UITextView *textView;

@end

@implementation ActivityDetailDefaultViewController


- (void)viewDidLoad
{
    DMPRINTMETHODNAME();
    [super viewDidLoad];
	
    //图片
    NSURL *imageUrl = [NSURL URLWithString:self.cellData[@"images"][0]];
    [self.imageView setImageWithURL:imageUrl
                    placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    //标题
    self.titleLabel.text = self.cellData[@"activityName"];
    
    //组织者
    NSString *organizerLabelText = [NSString stringWithFormat:@"主办: %@", self.cellData[@"communityName"]];
    self.organizerLabel.text = organizerLabelText;
    
    //活动时间
    NSString *dateLabelText = [NSString stringWithFormat:@"活动时间: %@ - %@", self.cellData[@"beginTime"], self.cellData[@"endTime"]];
    self.dateLabel.text = dateLabelText;
    
    //活动地点
    NSString *placeLabelText = [NSString stringWithFormat:@"活动地点: %@", self.cellData[@"location"]];
    self.placeLabel.text = placeLabelText;
    
    //活动详情
    NSString *textViewText = [NSString stringWithFormat:@"活动详情: %@", self.cellData[@"summary"]];
    NSData *summaryData = [textViewText dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithHTMLData:summaryData documentAttributes:NULL];
    self.textView.text = attrString.string;
    [self.textView sizeToFit];
    
    //调整画面长度
     _contentHeight = self.textView.frame.size.height + self.textView.frame.origin.y + BOTTOM_SPACE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    DMPRINTMETHODNAME();
    [super viewDidLayoutSubviews];
    [self.scrollView layoutIfNeeded];
    
    //为了能在interface builder上做
    DMPRINT(@"_contentHeight:%f",_contentHeight);
    self.scrollView.contentSize = CGSizeMake(0, _contentHeight);
}

@end
