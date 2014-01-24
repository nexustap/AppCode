//
//  FilterViewCell.m
//  jinli
//
//  Created by 金磊 on 14-1-5.
//  Copyright (c) 2014年 lordking. All rights reserved.
//

#import "FilterViewCell.h"

@interface FilterViewCell ()

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;

@end

@implementation FilterViewCell

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

-(void)setData:(NSDictionary *)data
{
    self.titleLabel.text = data[@"title"];
}

@end
