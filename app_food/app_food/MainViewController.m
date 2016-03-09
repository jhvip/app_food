//
//  ViewController.m
//  app_food
//
//  Created by 蒋豪 on 16/1/30.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UIView *mainView;

@property(nonatomic,assign)NSInteger currentIndex;

@end

@implementation MainViewController

//自定义TabBar
- (IBAction)tabBarButton:(UIButton*)sender {
    NSInteger index=(int)sender.tag-10;
    if (self.currentIndex==index) {
        return;
    }else{
        _currentIndex=index;
        NSLog(@"%ld",index);
        
        sender.backgroundColor=[UIColor whiteColor];
        sender.selected=YES;
        sender.highlighted=YES;
        
        
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
