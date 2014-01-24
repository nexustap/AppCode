//
//  ArticleViewCell.m
//  jinli
//
//  Created by 金磊 on 14-1-3.
//  Copyright (c) 2014年 lordking. All rights reserved.
//

#import "ArticleViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

#import <DTCoreText/DTCoreText.h>

@interface ArticleViewCell()

@property (nonatomic, weak) IBOutlet UIImageView *titleImageView;
@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *summary;
@property (nonatomic, weak) IBOutlet UILabel *subTitle;

@end

@implementation ArticleViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSDictionary *)data
{
 
    if ([data objectForKey:@"images"]) {
        NSArray *images = [data[@"images"] componentsSeparatedByString:@","];
        
        CALayer *layer = [self.titleImageView layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:4.0f];
        NSURL *imageUrl = [NSURL URLWithString:images[0]];
        [self.titleImageView setImageWithURL:imageUrl
                            placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }

    self.title.text = data[@"title"];
    
    //显示html格式的内容到标签页
    NSData *bodyData = [data[@"body"] dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithHTMLData:bodyData documentAttributes:NULL];
    self.summary.text = attrString.string;
    
    self.subTitle.text = [NSString stringWithFormat:@"%@  %@", data[@"date"], data[@"author"]];
}

@end
