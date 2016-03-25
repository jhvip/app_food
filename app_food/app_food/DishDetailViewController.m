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
#import "CommentController.h"
@interface DishDetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *dishImageView;
@property (weak, nonatomic) IBOutlet UILabel *dishTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *dishDetailLable;
@property (weak, nonatomic) IBOutlet UILabel *dishTagLable;

@property(nonatomic,strong)NSString *dish_no;
@end

@implementation DishDetailViewController

- (instancetype)init
{
    if (self = [super init]) {
        self.contentSizeInPopup = CGSizeMake(0,0);
        self.landscapeContentSizeInPopup = CGSizeMake(550, 650);
    }
    return self;
}
- (IBAction)dismiss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"guanbi");
    }];
    
}
- (IBAction)showComment {
    CommentController *commentView =[[CommentController alloc]init];
    commentView.dish_no=self.dish_no;
    [self.popupController pushViewController:commentView animated:YES];
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
    self.dish_no=[dic objectForKey:@"dish_no"];
    
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
