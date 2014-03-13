//
//  UserCenterViewController.m
//  OrderMeal
//
//  Created by 宏创 on 14-2-25.
//  Copyright (c) 2014年 周浩. All rights reserved.
//

#import "UserCenterViewController.h"
#import "AFNetworking.h"

@interface UserCenterViewController ()

@end

@implementation UserCenterViewController

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
    

}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.tabBarController.selectedIndex=0;
    //sender.enabled=NO;
    
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"123" message:@"321" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
    
}


- (IBAction)loginAction:(UIButton *)sender {
    //self.tabBarController.selectedIndex=0;
    //sender.enabled=NO;
    
       // [self performSegueWithIdentifier:@"登陆" sender:nil];
    if ([self checkInput]) {
        [self loginWithUsername:self.userName.text
                       password:self.password.text];
        
    }
    
   
    
//    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"123" message:@"321" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
}

-(BOOL)checkInput
{
    if ([self.userName.text length]==0) {
        self.warningLabel.text=@"请输入用户名！";
        return NO;
    }
    if ([self.password.text length]==0) {
        self.warningLabel.text=@"请输入密码";
        return NO;
    }
    
    return YES;
}

-(void)loginWithUsername:(NSString *)username
                password:(NSString *)password
{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSDictionary *parameters=@{
                               @"username" : username,
                               @"password" : password
                               
                               };
    
    [manager POST:login_url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSNumber *status=responseObject[@"success"];
        if ([status isEqualToNumber:@1]) {
           self.warningLabel.text=@"登陆成功";
            
           NSString *memberID= [responseObject[@"retData"] objectForKey:@"id"];
           NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
           [userDefaults setObject:memberID forKey:@"memberID"];
           [userDefaults synchronize];
            
        }else{
            self.warningLabel.text=responseObject[@"msg"];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
         self.warningLabel.text=@"暂时无法登陆";
        
    }];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
