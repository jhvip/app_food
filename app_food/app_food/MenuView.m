//
//  MenuView.m
//  app_food
//
//  Created by 蒋豪 on 16/3/14.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "MenuView.h"
#import "MenuInfo.h"
#import "RequestUrl.h"
@implementation MenuView


-(void)menuViewSetInfo:(MenuInfo *)menuInfo{
   // MenuView *view=[[[NSBundle mainBundle]loadNibNamed:@"MenuView" owner:self options:nil] lastObject];
    
    NSString *url=[NSString stringWithFormat:@"http://%@/image/%@",ip,menuInfo.image];
    NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    self.menuImageView.image=[UIImage imageWithData:imageData];
    self.menuSureButton.tag=(int)menuInfo.menuNo;
    self.menuMoneyLable.text=menuInfo.menuMoney;
    self.menuTitleLable.text=menuInfo.menuTitle;
    
    [self.menuSureButton.layer setMasksToBounds:YES];
    [self.menuSureButton.layer setCornerRadius:5.0];
    [self.menuSureButton.layer setBorderWidth:2.0];
    
    
}

- (IBAction)addOrder:(UIButton *)sender {
    NSUserDefaults *ud=[NSUserDefaults standardUserDefaults];
    NSMutableArray *array=[NSMutableArray arrayWithArray:[ud objectForKey:@"dishes"]];
    NSDictionary *dishes=@{@"id":[NSString stringWithFormat:@"%ld",sender.tag],@"name":self.menuTitleLable.text,@"acountnum":self.menuMoneyLable.text};
    [array addObject:dishes];
    
    [ud setObject:array forKey:@"dishes"];
    
    if ([self.delegate respondsToSelector:@selector(MenuViewReloadTableView)]) {
        [self.delegate MenuViewReloadTableView];
    }
}

@end
