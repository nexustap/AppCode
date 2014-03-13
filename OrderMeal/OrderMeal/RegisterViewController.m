//
//  RegisterViewController.m
//  OrderMeal
//
//  Created by 宏创 on 14-2-19.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import "RegisterViewController.h"
#import "AFHTTPRequestOperationManager.h"

@interface RegisterViewController ()

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
    
    _scrollFrame=self.scrollView.frame;
    _scrollContentSize=self.scrollView.contentSize;
    
    
    UITapGestureRecognizer *gesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:gesture];
}

-(BOOL)checkInput
{
    if ([self.phoneTextField.text length]!=11) {
        self.warningLabel.text=@"手机号码必须是11位";
        return NO;
    }
    
    if ([self.lastNameTextField.text length]<2) {
        self.warningLabel.text=@"昵称至少2位";
        return NO;
    }

    if ([self.passwordTextField.text length]!=6) {
        self.warningLabel.text=@"密码必须是6位";
        return NO;
    }
    
    if (![self.passwordTextField.text isEqualToString:self.repasswordTextField.text]) {
        self.warningLabel.text=@"两次密码输入不一致";
        return NO;
    }
    self.warningLabel.text=nil;
    return YES;
}

-(void)registerWithEmail:(NSString *)email
                lastName:(NSString *)name
                     sex:(NSString *)sex
                   phone:(NSString *)phone
              buildingid:(NSString *)buildingid
              password:(NSString *)password
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSDictionary *parameters=@{@"email" : email,
                               @"name":name,
                               @"sex":sex,
                               @"phone":phone,
                               @"buildingid":buildingid,
                               
                               @"password":password

                               };

    [manager GET:register_url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
         NSNumber *status=responseObject[@"success"];
         if ([status isEqualToNumber:@1]) {
            self.warningLabel.text=@"注册成功";
         }else{
            self.warningLabel.text=responseObject[@"msg"];
         }

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        self.warningLabel.text=@"暂时无法登陆";
    }];
}

-(void)hideKeyboard
{
    [self.view endEditing:YES];
    [self resumeView];
}

-(void)resumeView
{
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    self.scrollView.frame=_scrollFrame;
    self.scrollView.contentSize=_scrollContentSize;
    [UIView commitAnimations];
}

-(void)moveView:(CGFloat)y
{
    NSTimeInterval animationDuration=0.30f;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:animationDuration];
    
    float width=self.scrollView.frame.size.width;
    float height=self.scrollView.frame.size.height;

    CGRect rect=CGRectMake(0.0f, y, width, height);
    self.scrollView.frame=rect;
    [UIView commitAnimations];
    self.scrollView.contentSize=CGSizeMake(width, 350);
}


- (IBAction)doBack:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doRegister:(UIButton *)sender
{
    if ([self checkInput]) {
        [self registerWithEmail:self.emailTextField.text 
                       lastName:self.lastNameTextField.text
                       sex:self.sexTextField.text
                       phone:self.phoneTextField.text
                       buildingid:self.buildingidTextField.text
                       password:self.passwordTextField.text];
    }
    
//    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
//    
//    NSDictionary *parameters=@{
//                               @"email" : @"977968588@qq.com",
//                               @"lastName" : @"张",
//                               @"sex" : @"1" ,
//                               @"phone" : @"13770928853" ,
//                               @"buildingid" : @"1" ,
//                               @"password" : @"123456"
//                               };
//    
//    [manager GET:register_url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        NSNumber *status=responseObject[@"success"];
//        if ([status isEqualToNumber:@1]) {
//            self.warningLabel.text=@"注册成功";
//        }else{
//            self.warningLabel.text=responseObject[@"msg"];
//        }
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@",[error localizedDescription]);
//        self.warningLabel.text=@"暂时无法登陆";
//    }];
    
   // NSDictionary *parameters=@{   @"customerId" : @3};
    
   
//    NSString *string=@"http://192.168.0.202:28080/app/regist?email=1263907326@qq.com&lastName=涨&sex=1&phone=13770123242&buildingid=1&password=123446";
//    
//   // NSString *key=[[parameters allKeys]objectAtIndex:0];
//
//   // NSString *string=[NSString stringWithFormat:@"%@?%@=%@",points_url,key ,[parameters objectForKey:key]];
//    NSString *str=[string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    NSLog(@"str:%@",str);
//    NSURL *url=[NSURL URLWithString:str];
//    NSLog(@"url:%@",url);
//    NSURLRequest *req=[NSURLRequest requestWithURL:url];
//
//    _con=[[NSURLConnection alloc]initWithRequest:req delegate:self];
//    if (_con) {
//        NSLog(@"connection is done!");
//        NSLog(@"%@",_con);
//        [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
//        _webData=[NSMutableData data];
//    }
}

#pragma mark URL Connection Data Delegate 
//接受数据时调用
-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [_webData setLength:0];
    NSLog(@"完成连接");
}

//每接收到一部分数据追加到webData中
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_webData appendData:data];
}

//完成接收数据时调用
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
   [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    
    NSError *error;
   // _webDic=[[NSDictionary alloc]init];
    _webDic=[NSJSONSerialization JSONObjectWithData:_webData
            options:NSJSONReadingMutableContainers error:&error];
    NSLog(@"字典里面的内容为:%@",_webDic);
    
    NSString *msg=[_webDic objectForKey:@"msg"];
    NSLog(@"%@",msg);
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"注册成功" message:@"注册成功" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

//error
-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _con=nil;
    _webData=nil;
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"连接出错" message:[error localizedDescription] delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alert show];
}

#pragma mark- UITextFiekdDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self moveView:100];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self hideKeyboard];
    [textField resignFirstResponder];
    return YES;
}

@end
