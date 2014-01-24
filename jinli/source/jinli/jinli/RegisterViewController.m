//
//  RegisterViewController.m
//  jinli
//
//  Created by 金磊 on 14-1-17.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import "RegisterViewController.h"

#import <AFNetworking.h>

@interface RegisterViewController ()<UITextFieldDelegate>
{
    CGRect _scrollFrame;
    CGSize _scrollContentSize;
}

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet DMTextField *usernameTextField;
@property (nonatomic, weak) IBOutlet DMTextField *nicknameTextField;
@property (nonatomic, weak) IBOutlet DMTextField *passwordTextField;
@property (nonatomic, weak) IBOutlet DMTextField *repasswordTextField;
@property (nonatomic, weak) IBOutlet UILabel *warningLabel;

@end

@implementation RegisterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //获取原始的位置和内容大小
    _scrollFrame = self.scrollView.frame;
    _scrollContentSize = self.scrollView.contentSize;
	   
    //用户名输入框
    [self.usernameTextField setLeftImage:@"haoma" frame:CGRectMake(0, 0, 20, 20)];
    //用户名输入框
    [self.nicknameTextField setLeftImage:@"nicheng" frame:CGRectMake(0, 0, 20, 20)];
    //密码输入框
    [self.passwordTextField setLeftImage:@"mima" frame:CGRectMake(0, 0, 20, 20)];
    //密码输入框
    [self.repasswordTextField setLeftImage:@"mima" frame:CGRectMake(0, 0, 20, 20)];
    
    
    //添加手势，点击屏幕其他区域关闭键盘的操作
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private method

-(BOOL)checkInput
{    
    if ([self.usernameTextField.text length] != 11) {
        [self warning:@"手机号码必须是11位"];
        return NO;
    }
    
    if ([self.nicknameTextField.text length] < 2) {
        [self warning:@"昵称必须至少2位"];
        return NO;
    }
    
    if ([self.passwordTextField.text length] < 6) {
        [self warning:@"密码必须是6位"];
        return NO;
    }
    
    if (![self.passwordTextField.text isEqualToString:self.repasswordTextField.text]) {
        [self warning:@"两次密码输入不一致"];
        return NO;
    }
    
    [self warning:@""];
    return YES;
}

- (void)warning:(NSString*)text
{
    self.warningLabel.text = text;
}

//隐藏键盘的方法
-(void)hidenKeyboard
{
    [self.usernameTextField resignFirstResponder];
    [self.nicknameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.repasswordTextField resignFirstResponder];
    [self resumeView];
}

- (void)resumeView
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //恢复位置和大小
    self.scrollView.frame = _scrollFrame;
    self.scrollView.contentSize = _scrollContentSize;
    [UIView commitAnimations];
}


- (void)moveView:(CGFloat)y
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    float width = self.scrollView.frame.size.width;
    float height = self.scrollView.frame.size.height;
    
    //下移
    CGRect rect= CGRectMake(0.0f, y, width, height);
    self.scrollView.frame = rect;
    [UIView commitAnimations];
    self.scrollView.contentSize = CGSizeMake(width, 350);
}

- (void)registerWithAppId: (NSString*)appId
                    phone: (NSString*)phone
                 nickname: (NSString*)nickname
                 password: (NSString*)password
{
    DMPRINTMETHODNAME();
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"appId": appId,
                                 @"phone": phone,
                                 @"nickname": nickname,
                                 @"password": password};
    
    [manager POST:register_url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSNumber *status = responseObject[@"status"];
        
        if ([status isEqualToNumber:@1]) {
            [self warning:@"注册成功"];
        } else {
            [self warning:responseObject[@"describe"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DMPRINT(@"Error: %@", error);
        [self warning:@"暂时无法登录"];
    }];
}

#pragma mark - IBAction

-(IBAction)doBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)doRegister:(id)sender
{
    if ([self checkInput]) {

        [self registerWithAppId:@"JinLi"
                          phone:self.usernameTextField.text
                       nickname:self.nicknameTextField.text
                       password:self.passwordTextField.text];
    }
}

#pragma mark - UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self moveView:40];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self hidenKeyboard];
    
    return YES;
}

@end
