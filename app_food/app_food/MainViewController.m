//
//  ViewController.m
//  app_food
//
//  Created by 蒋豪 on 16/1/30.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "MainViewController.h"
#import "MenuView.h"
#import "AFNetworking.h"
#import "User.h"
#import "RequestUrl.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property(nonatomic,assign)NSInteger currentIndex;

@property (weak, nonatomic) IBOutlet UIView *tabBarView;
@end

@implementation MainViewController

//自定义TabBar
- (IBAction)tabBarButton:(UIButton*)sender {
    NSInteger index=(int)sender.tag-10;
    if (self.currentIndex==index) {
        return;
    }else{
        for (UIButton *button in [self.tabBarView subviews]) {
            if (button.tag-10==self.currentIndex) {
                button.selected=NO;
                button.backgroundColor=[UIColor blackColor];
                button.tintColor=[UIColor blackColor];
            }
        }
    
        _currentIndex=index;
        sender.backgroundColor=[UIColor whiteColor];
        sender.selected=YES;
        sender.tintColor=[UIColor whiteColor];
        [self loadMenuView];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.currentIndex=10;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadMenuView{
    User *user=[User takeUser];
    NSDictionary *param=@{@"userName":user.userName,
                          @"token":user.token,
                          };
    AFHTTPSessionManager *manage=[AFHTTPSessionManager manager];
    [manage GET:MenuURL parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success,%@",responseObject);
        if([[responseObject objectForKey:@"error"] isEqualToString:@"1000"]){
            
           
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error);
    }];
    [self.mainView reloadInputViews];

}


@end
