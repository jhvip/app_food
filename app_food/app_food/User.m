//
//  User.m
//  app_food
//
//  Created by 蒋豪 on 16/3/11.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "User.h"



#define UserName @"userName"
#define Token @"token"
@interface User()

@end
@implementation User


/**
 *  存储帐号信息
 */
+ (void)save:(User *)user
{
    
    //获取userDefault单例
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //登陆成功后把用户名和密码存储到UserDefault
    [userDefaults setObject:user.userName forKey:UserName];
    [userDefaults setObject:user.token forKey:Token];
    
    [userDefaults synchronize];
}


/**
 *  获得上次存储的帐号
 *
 *  @return 帐号过期, 返回nil
 */
+ (User *)takeUser
{
    
    User *user = [[User alloc] init];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    
    user.userName  = [def objectForKey:UserName];
    user.token = [def objectForKey:Token];
   
    return user;
}


@end
