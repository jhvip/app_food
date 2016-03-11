//
//  MenuView.m
//  app_food
//
//  Created by 蒋豪 on 16/3/11.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "MenuView.h"
#include "MenuInfo.h"
@interface MenuView()

@property (weak, nonatomic) IBOutlet UIImageView *menuImageView;
@property (weak, nonatomic) IBOutlet UILabel *menuTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *menuMoneyLable;
@property (weak, nonatomic) IBOutlet UIButton *menuSureButton;

@end

@implementation MenuView

+(NSArray *)menuSetInfo:(NSArray *)menuInfoList{
    if (menuInfoList.count==0) {
        NSLog(@"菜单为空");
        return nil;
    }
    NSMutableArray *menuArray=[NSMutableArray array];
    for (int i=0; i<menuInfoList.count; i++) {
        MenuInfo *menuInfo=[MenuInfo menuInfoSet:menuInfoList[i]];
        MenuView *view=[[MenuView alloc]init];
        view.menuImageView.image=[UIImage imageNamed:menuInfo.image];
        view.menuTitleLable.text=menuInfo.menuTitle;
        view.menuMoneyLable.text=menuInfo.menuMoney;
        view.menuSureButton.tag=i;
        [menuArray addObject:view];
    }
    return menuArray;

}


@end
