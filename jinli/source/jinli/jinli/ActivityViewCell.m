//
//  ActivityViewCell.m
//  jinli
//
//  Created by 金磊 on 14-1-3.
//  Copyright (c) 2014年 lordking. All rights reserved.
//

#import "ActivityViewCell.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <DTCoreText/DTCoreText.h>

@interface ActivityViewCell()

@property (nonatomic, weak) IBOutlet UIImageView *titleImageView;
@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *summary;
@property (nonatomic, weak) IBOutlet UILabel *subTitle;

@end

@implementation ActivityViewCell

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

- (void) setData:(NSDictionary *)data
{
    
    if ([data[@"images"] count] > 0) {
        //设置边框线的宽
        CALayer *layer = [self.titleImageView layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:4.0f];
        NSURL *imageUrl = [NSURL URLWithString:data[@"images"][0]];
        [self.titleImageView setImageWithURL:imageUrl
                            placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    
    self.title.text = data[@"activityName"];
    
    //显示html格式的内容到标签页
    NSData *summaryData = [data[@"summary"] dataUsingEncoding:NSUTF8StringEncoding];
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithHTMLData:summaryData documentAttributes:NULL];
    self.summary.text = attrString.string;
    
    self.subTitle.text = [NSString stringWithFormat:@"%@", data[@"createTime"]];
}

@end
