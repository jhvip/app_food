//
//  DishDetailViewController.m
//  app_food
//
//  Created by 蒋豪 on 16/3/23.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "DishDetailViewController.h"
#import "STPopup.h"
#import "RequestUrl.h"
@interface DishDetailViewController ()
@property (weak, nonatomic) IBOutlet UIButton *closeButton;
@property (weak, nonatomic) IBOutlet UIImageView *dishImageView;
@property (weak, nonatomic) IBOutlet UILabel *dishTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *dishDetailLable;
@property (weak, nonatomic) IBOutlet UILabel *dishTagLable;

@end

@implementation DishDetailViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.contentSizeInPopup = CGSizeMake(600,900);
        self.landscapeContentSizeInPopup = CGSizeMake(550, 750);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)DishDetailSetInfo:(NSDictionary *)dic{
    self.dishTitleLable.text=[dic objectForKey:@"dish_name"];
    self.title = self.dishTitleLable.text;
    self.dishTagLable.text=[dic objectForKey:@"dish_tag"];;
    self.dishDetailLable.text=[dic objectForKey:@"dish_detail"];
    
    NSString *url=[NSString stringWithFormat:@"http://%@/image/%@",ip,[dic objectForKey:@"dish_pic"]];
    NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    
    self.dishImageView.image=[UIImage imageWithData:imageData];
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
