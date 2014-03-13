//
//  shoppingCartCell.m
//  OrderMeal
//
//  Created by 宏创 on 14-3-10.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import "shoppingCartCell.h"

@implementation shoppingCartCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    _number=[self.num.text intValue];
    _subtotal.text=[NSString stringWithFormat:@"%d",_number*[_salesPrice.text intValue]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (IBAction)add:(UIButton *)sender {
    self.num.text=[NSString stringWithFormat:@"%d",_number++];
    _subtotal.text=[NSString stringWithFormat:@"%d",_number*[_salesPrice.text intValue]];
}

- (IBAction)minus:(UIButton *)sender {
   
    self.num.text= [NSString stringWithFormat:@"%d",_number--];
    if (_number==0) {
       self.minus.enabled=NO;
    }
    _subtotal.text=[NSString stringWithFormat:@"%d",_number*[_salesPrice.text intValue]];
}

@end
