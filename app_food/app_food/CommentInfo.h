//
//  CommentInfo.h
//  app_food
//
//  Created by 蒋豪 on 16/3/25.
//  Copyright © 2016年 jh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentInfo : NSObject

@property(nonatomic,strong)NSString *iconImage;
@property(nonatomic,strong)NSString *guestName;
@property(nonatomic,strong)NSString *commentMsg;
@property(nonatomic,strong)NSString *time;

+(NSArray*)commentSetInfo:(NSArray*)info;

@end
