//
//  MenuInfo.h
//  app_food
//
//  Created by 蒋豪 on 16/3/11.
//  Copyright © 2016年 jh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuInfo : NSObject
@property(nonatomic,strong)NSString *image;
@property(nonatomic,strong)NSString *menuTitle;
@property(nonatomic,strong)NSString *menuMoney;

+(MenuInfo*)menuInfoSet:(NSDictionary*)dict;

@end
