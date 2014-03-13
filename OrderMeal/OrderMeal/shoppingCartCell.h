//
//  shoppingCartCell.h
//  OrderMeal
//
//  Created by 宏创 on 14-3-10.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface shoppingCartCell : UITableViewCell
{
    int _number;

}





@property (weak, nonatomic) IBOutlet UILabel *name;

@property (weak, nonatomic) IBOutlet UIImageView *imageName;

@property (weak, nonatomic) IBOutlet UILabel *price;

@property (weak, nonatomic) IBOutlet UILabel *salesPrice;

@property (weak, nonatomic) IBOutlet UIButton *minus;

@property (weak, nonatomic) IBOutlet UILabel *num;

@property (weak, nonatomic) IBOutlet UILabel *subtotal;

@property (weak, nonatomic) IBOutlet UIButton *add;



- (IBAction)add:(UIButton *)sender;

- (IBAction)minus:(UIButton *)sender;




@end
