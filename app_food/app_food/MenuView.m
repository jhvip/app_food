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


+(MenuView *)menuViewSetInfo:(MenuInfo *)menuInfo{
    MenuView *view=[[[NSBundle mainBundle]loadNibNamed:@"MenuView" owner:self options:nil] lastObject];
    
    NSString *url=[NSString stringWithFormat:@"http://%@/image/%@",ip,menuInfo.image];
    NSData *imageData=[NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    view.menuImageView.image=[UIImage imageWithData:imageData];
    view.menuSureButton.tag=(int)menuInfo.menuNo;
    view.menuMoneyLable.text=menuInfo.menuMoney;
    view.menuTitleLable.text=menuInfo.menuTitle;
    
    [view.menuSureButton.layer setMasksToBounds:YES];
    [view.menuSureButton.layer setCornerRadius:5.0];
    [view.menuSureButton.layer setBorderWidth:2.0];
    
    return view;
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
