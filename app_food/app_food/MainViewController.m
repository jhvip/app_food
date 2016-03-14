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
#import "MenuInfo.h"
#import "RequestUrl.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIView *menuView;

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
        
        
        [self loadMenuView:(int)sender.tag-10];
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

-(void)loadMenuView:(int)class{
    User *user=[User takeUser];
    NSDictionary *param=@{@"userName":user.userName,
                          @"token":user.token,
                          @"status":@"find",
                          @"class":[NSString stringWithFormat:@"%d",class]
                          };
    AFHTTPSessionManager *manage=[AFHTTPSessionManager manager];
    [manage GET:MenuURL parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success,%@",responseObject);
        
        [self showView:responseObject];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error);
    }];
    
}

-(void)showView:(NSArray*)info{
    NSArray *menuList=[MenuInfo menuSetInfo:info];
    CGFloat width=self.menuView.frame.size.width;
    
    CGFloat viewWidth=(width-85)*0.25;
    CGFloat viewHeight=viewWidth*1.2;
    NSLog(@"%f,%f",viewHeight,viewWidth);
    
    //清空之前的view
    for (UIView *view in self.menuView.subviews) {
        [view removeFromSuperview];
    }
    
    for (int i=0; i<menuList.count; i++) {
        int row=i%4;
        int col=i/4;
        MenuView *menuView=[[MenuView alloc]initWithFrame:CGRectMake(row*viewWidth+15*row+20, col*viewHeight+15*col+20, viewWidth,viewHeight)];
        menuView.backgroundColor=[UIColor redColor];
        [self.menuView addSubview:menuView];
    }
    
    
    
    
    
}


@end
