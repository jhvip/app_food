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
@property(nonatomic,strong)NSString *menuNo;
@property(nonatomic,strong)NSString *menuDiscount;


+(MenuInfo*)menuInfoSet:(NSDictionary*)dict;
+(NSArray *)menuSetInfo:(NSArray *)menuInfoList;
@end