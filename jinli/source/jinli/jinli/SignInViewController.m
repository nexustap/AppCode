//
//  SignInViewController.m
//  jinli
//
//  Created by 金磊 on 14-1-14.
//  Copyright (c) 2014年 ailk. All rights reserved.
//

#import "SignInViewController.h"
#import "AppDelegate.h"

#import <AFNetworking.h>

@interface SignInViewController ()<UITextFieldDelegate>
{
    CGRect _scrollFrame;
    CGSize _scrollContentSize;
}

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet DMTextField *usernameTextField;
@property (nonatomic, weak) IBOutlet DMTextField *passwordTextField;
@property (nonatomic, weak) IBOutlet UIButton *registerButton;
@property (nonatomic, weak) IBOutlet UIButton *loginButton;
@property (nonatomic, weak) IBOutlet UILabel *warningLabel;

@end

@implementation SignInViewController

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
    [self.usernameTextField setLeftImage:@"yonghuming" frame:CGRectMake(0, 0, 20, 20)];
    //密码输入框
    [self.passwordTextField setLeftImage:@"mima" frame:CGRectMake(0, 0, 20, 20)];
    
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

#pragma mark - IBAction

- (IBAction)doBack:(id)sender
{
    DMPRINTMETHODNAME();
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doRegister:(id)sender
{
    DMPRINTMETHODNAME();
    [self performSegueWithIdentifier:@"用户注册" sender:nil];
}

- (IBAction)doSignin:(id)sender
{
    DMPRINTMETHODNAME();
    
    if ([self checkInput]) {
        [self loginWithAppId:@"JinLi"
                    username:self.usernameTextField.text
                    password:self.passwordTextField.text];
    }
}

#pragma mark - private method

-(BOOL)checkInput
{    
    if ([self.usernameTextField.text length] == 0) {
        [self warning:@"用户名没有填写"];
        return NO;
    }
    
    if ([self.passwordTextField.text length] == 0) {
        [self warning:@"密码没有填写"];
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
- (void)hidenKeyboard
{
    [self.usernameTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self resumeView];
}

- (void)resumeView
{
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //恢复
    self.scrollView.frame = _scrollFrame;
    self.scrollView.contentSize = _scrollContentSize;
    [UIView commitAnimations];
}


- (void)moveView:(CGFloat)y
{
    
    float width = self.scrollView.frame.size.width;
    float height = self.scrollView.frame.size.height;
    
    NSTimeInterval animationDuration = 0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    //下移
    CGRect rect= CGRectMake(0.0f, y, width, height);
    self.scrollView.frame = rect;
    self.scrollView.contentSize = CGSizeMake(width, 400);
    [UIView commitAnimations];
}

/*!
 *  用户登录
 *
 *  @param appId    <#appId description#>
 *  @param username <#username description#>
 *  @param password <#password description#>
 */
- (void)loginWithAppId: (NSString*)appId
              username: (NSString*)username
              password: (NSString*)password
{
    DMPRINTMETHODNAME();
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *parameters = @{@"appId": appId,
                                 @"username": username,
                                 @"password": password};

    [manager POST:login_url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *data = responseObject;
        NSNumber *status = data[@"status"];
        
        if ([status isEqualToNumber:@1]) {
            
            DMUserinfo *userinfo = [[DMUserinfo alloc] initWithData:data];
            AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
            
            appDelegate.userinfo = userinfo;
            
            [self dismissViewControllerAnimated:YES completion:nil];
        } else {
            [self warning:data[@"describe"]];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        DMPRINT(@"Error: %@", error);
        [self warning:@"暂时无法登录"];
    }];
}


#pragma mark - UITextFieldDelegate

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self moveView:30];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self hidenKeyboard];
    
    return YES;
}

@end
