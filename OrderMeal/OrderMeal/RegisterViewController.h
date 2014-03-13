//
//  RegisterViewController.h
//  OrderMeal
//
//  Created by 宏创 on 14-2-19.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController<UITextFieldDelegate,NSURLConnectionDataDelegate,NSURLConnectionDelegate>
{
    CGRect _scrollFrame;
    CGSize _scrollContentSize;
    NSURLConnection *_con;
    NSMutableData *_webData;
    NSString *_webString;
    NSDictionary *_webDic;
}

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *sexTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *buildingidTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *repasswordTextField;


@property (weak, nonatomic) IBOutlet UILabel *warningLabel;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)doBack:(id)sender;

- (IBAction)doRegister:(UIButton *)sender;


@end
