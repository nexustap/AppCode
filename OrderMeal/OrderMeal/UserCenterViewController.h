//
//  UserCenterViewController.h
//  OrderMeal
//
//  Created by 宏创 on 14-2-25.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserCenterViewController : UIViewController<UITextFieldDelegate>

- (IBAction)loginAction:(UIButton *)sender;

@property (weak, nonatomic) IBOutlet UITextField *userName;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UILabel *warningLabel;

@end
