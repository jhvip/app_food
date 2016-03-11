//
//  User.h
//  app_food
//
//  Created by 蒋豪 on 16/3/11.
//  Copyright © 2016年 jh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *token;


+ (void)save:(User *)user;
+ (User *)takeUser;


@end
