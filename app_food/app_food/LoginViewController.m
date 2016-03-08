//
//  LoginViewController.m
//  app_food
//
//  Created by 蒋豪 on 16/2/24.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "LoginViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "UserInfo.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwTextField;
@property (weak, nonatomic) IBOutlet UILabel *userError;
@property (weak, nonatomic) IBOutlet UILabel *pwError;
@property (weak, nonatomic) IBOutlet UILabel *errorInfo;

@end

@implementation LoginViewController
- (IBAction)loginAction:(id)sender {
    self.userError.hidden=YES;
    self.pwError.hidden=YES;
    self.errorInfo.hidden=YES;
    NSString *userName=self.userNameTextField.text;
    NSString *passWord=self.pwTextField.text;
    if ([userName isEqualToString:@""]) {
        self.userError.hidden=NO;
        return;
    }else if([passWord isEqualToString:@""]){
        self.pwError.hidden=NO;
        return;
    }
    
    NSString *url=@"http://127.0.0.1:8080/app_food/UserLoginServlet";
    NSDictionary *param=@{@"userName":userName,
                          @"password":passWord,
                          };
    AFHTTPSessionManager *manage=[AFHTTPSessionManager manager];
    [manage GET:url parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if ([[responseObject objectForKey:@"error"] isEqualToString:@"1000"]) {
            UserInfo *user=[[UserInfo alloc]init];
            user.userName=[responseObject objectForKey:@"userName"];
            user.token=[responseObject objectForKey:@"token"];
            [UserInfo save:user];
        }else if([[responseObject objectForKey:@"error"] isEqualToString:@"1002"]){
            self.errorInfo.hidden=NO;
            NSLog(@"账号密码错误");
        }else if([[responseObject objectForKey:@"error"] isEqualToString:@"1001"]){
            NSLog(@"位置错误 代码:1001");
        }
        
        NSLog(@"success,%@",responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"网络异常错误");
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.logoImageView.image=[UIImage imageNamed:@"logo"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
