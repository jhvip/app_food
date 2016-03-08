//
//  UserInfo.m
//  app_food
//
//  Created by 蒋豪 on 16/3/8.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

+(void)save:(UserInfo *)userInfo{
    //获取userDefault单例
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    //登陆成功后把用户名和密码存储到UserDefault
    [userDefaults setObject:userInfo.userName forKey:@"userName"];
    [userDefaults setObject:userInfo.token forKey:@"token"];

    [userDefaults synchronize];

}
@end
