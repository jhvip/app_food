//
//  MenuInfo.m
//  app_food
//
//  Created by 蒋豪 on 16/3/11.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "MenuInfo.h"

@implementation MenuInfo

+(MenuInfo *)menuInfoSet:(NSDictionary *)dict{
    MenuInfo *menuInfo=[[MenuInfo alloc]init];
    menuInfo.image=[dict objectForKey:@"dish_pic"];
    menuInfo.menuMoney=[dict objectForKey:@"dish_price"];
    menuInfo.menuTitle=[dict objectForKey:@"dish_name"];
    menuInfo.menuNo=[dict objectForKey:@"dish_no"];
    menuInfo.menuDiscount=[dict objectForKey:@"dish_discount"];
    return menuInfo;
}

+(NSArray *)menuSetInfo:(NSArray *)menuInfoList{
    
    NSMutableArray *menuArray=[NSMutableArray array];
    for (int i=0; i<menuInfoList.count; i++) {
        MenuInfo *menuInfo=[MenuInfo menuInfoSet:menuInfoList[i]];
        [menuArray addObject:menuInfo];
    }
    return menuArray;
    
}

@end
