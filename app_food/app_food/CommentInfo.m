//
//  CommentInfo.m
//  app_food
//
//  Created by 蒋豪 on 16/3/25.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "CommentInfo.h"

@implementation CommentInfo

+(NSArray *)commentSetInfo:(NSArray *)commentInfo{
    
    NSMutableArray *infoList=[NSMutableArray array];
    
    for (int i=0; i<commentInfo.count; i++) {
        CommentInfo *info=[CommentInfo dicSet:(NSDictionary*)commentInfo[i]];
        [infoList addObject:info];
    }
    return infoList;
}

+(CommentInfo*)dicSet:(NSDictionary*)dic{
    CommentInfo *info=[[CommentInfo alloc]init];
    info.iconImage=[dic objectForKey:@"iconImage"];
    info.guestName=[dic objectForKey:@"guestName"];
    info.commentMsg=[dic objectForKey:@"commentMsg"];
    info.time=[dic objectForKey:@"time"];
    return info;
}


@end
