//
//  GoodDetailViewController.h
//  OrderMeal
//
//  Created by 宏创 on 14-3-7.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodDetailViewController : UIViewController

@property (copy,nonatomic) NSString *goodsid;

@property (weak, nonatomic) IBOutlet UIButton *minus;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UITextField *quantityField;

- (IBAction)addShoppingCard:(UIButton *)sender;

- (IBAction)buy:(UIButton *)sender;

- (IBAction)minus:(UIButton *)sender;

- (IBAction)add:(UIButton *)sender;


@end
