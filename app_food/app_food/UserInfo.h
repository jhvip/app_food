//
//  UserInfo.h
//  app_food
//
//  Created by 蒋豪 on 16/3/8.
//  Copyright © 2016年 jh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *token;

+(void)save:(UserInfo*)userInfo;

@end
