//
//  ShopViewCell.m
//  jinli
//
//  Created by 金磊 on 14-1-13.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import "ShopViewCell.h"

@interface ShopViewCell ()

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end

@implementation ShopViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setCellData:(NSDictionary *)cellData
{
    self.imageView.image = [UIImage imageNamed:cellData[@"image"]];
}

@end
