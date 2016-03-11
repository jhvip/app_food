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
#import "MainViewController.h"
#import "RequestUrl.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwTextField;
@property (weak, nonatomic) IBOutlet UILabel *userError;
@property (weak, nonatomic) IBOutlet UILabel *pwError;

@end

@implementation LoginViewController
- (IBAction)loginAction:(id)sender {
    self.userError.hidden=YES;
    self.pwError.hidden=YES;
    NSString *userName=self.userNameTextField.text;
    NSString *passWord=self.pwTextField.text;
    if ([userName isEqualToString:@""]) {
        self.userError.hidden=NO;
        return;
    }else if([passWord isEqualToString:@""]){
        self.pwError.hidden=NO;
        return;
    }

    
    NSDictionary *param=@{@"userName":userName,
                          @"password":passWord,
                          };
    AFHTTPSessionManager *manage=[AFHTTPSessionManager manager];
    [manage GET:LoginURL parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success,%@",responseObject);
        if([[responseObject objectForKey:@"error"] isEqualToString:@"1000"]){
            
            // 登录成功跳转
            MainViewController * main = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
            
            [UIApplication sharedApplication].keyWindow.rootViewController = main;

        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error);
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置默认的logo
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
