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
    menuInfo.image=[dict objectForKey:@"image"];
    menuInfo.menuMoney=[dict objectForKey:@"menuMoney"];
    menuInfo.menuTitle=[dict objectForKey:@"menuTitle"];
    return menuInfo;
    
}
@end
