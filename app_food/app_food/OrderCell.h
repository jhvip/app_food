//
//  OrderCell.h
//  app_food
//
//  Created by 蒋豪 on 16/3/17.
//  Copyright © 2016年 jh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuInfo;
@interface OrderCell : UITableViewCell

-(void)orderCellSetCell:(NSDictionary*)dict num:(NSInteger)num;

@end
