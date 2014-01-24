//
//  ShopClassViewCell.m
//  jinli
//
//  Created by 金磊 on 14-1-14.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import "ShopClassViewCell.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface ShopClassViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *titleImageView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *summaryLabel;

@end

@implementation ShopClassViewCell

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

-(void)setCellData:(NSDictionary *)cellData
{
    if ([cellData[@"images"] count] > 0) {
        
        CALayer *layer = [self.titleImageView layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:4.0f];
        NSURL *imageUrl = [NSURL URLWithString:cellData[@"images"][0]];
        [self.titleImageView setImageWithURL:imageUrl
                            placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    }
    
    self.titleLabel.text = cellData[@"communityName"];
    self.summaryLabel.text = cellData[@"remark"];
}

@end
