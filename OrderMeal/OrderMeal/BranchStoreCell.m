//
//  BranchStoreCell.m
//  OrderMeal
//
//  Created by 宏创 on 14-3-6.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import "BranchStoreCell.h"

@implementation BranchStoreCell

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
