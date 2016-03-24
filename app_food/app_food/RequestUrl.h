//
//  RequestUrl.h
//  app_food
//
//  Created by 蒋豪 on 16/3/9.
//  Copyright © 2016年 jh. All rights reserved.
//

#ifndef RequestUrl_h
#define RequestUrl_h


#define ip @"127.0.0.1:8080/app_food"


// 登陆URL
#define LoginURL [NSString stringWithFormat:@"http://%@/UserLoginServlet",ip]
//菜单URL
#define MenuURL [NSString stringWithFormat:@"http://%@/DishControlServlet",ip]

//菜单详情URL
#define DetailURL [NSString stringWithFormat:@"http://%@/DishDetailServlet",ip]




#endif /* RequestUrl_h */
