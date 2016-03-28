//
//  OrderCell.m
//  app_food
//
//  Created by 蒋豪 on 16/3/17.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "OrderCell.h"
#import "MenuInfo.h"

@interface OrderCell()

@property (weak, nonatomic) IBOutlet UILabel *numLable;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *moneyLable;

@end

@implementation OrderCell


-(void)orderCellSetCell:(NSDictionary *)dict num:(NSInteger)num{
    self.numLable.text=[NSString stringWithFormat:@"%ld",(long)num+1];
    self.titleLable.text=[dict objectForKey:@"name"];
    self.moneyLable.text=[dict objectForKey:@"acountnum"];
    
}

@end
