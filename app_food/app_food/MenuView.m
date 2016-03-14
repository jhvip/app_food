//
//  MenuView.m
//  app_food
//
//  Created by 蒋豪 on 16/3/14.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "MenuView.h"
#import "MenuInfo.h"
@implementation MenuView


+(MenuView *)menuViewSetInfo:(MenuInfo *)menuInfo{
    MenuView *view=[[[NSBundle mainBundle]loadNibNamed:@"MenuView" owner:self options:nil] lastObject];
    view.menuImageView.image=[UIImage imageNamed:@"logo"];
    view.menuSureButton.tag=(int)menuInfo.menuNo;
    view.menuMoneyLable.text=menuInfo.menuMoney;
    view.menuTitleLable.text=menuInfo.menuTitle;
    
    return view;
}

@end
