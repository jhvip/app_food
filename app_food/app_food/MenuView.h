//
//  MenuView.h
//  app_food
//
//  Created by 蒋豪 on 16/3/14.
//  Copyright © 2016年 jh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenuInfo;

@protocol MenuViewDelegate <NSObject>

-(void)MenuViewReloadTableView;

@end

@interface MenuView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *menuImageView;
@property (weak, nonatomic) IBOutlet UILabel *menuTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *menuMoneyLable;
@property (weak, nonatomic) IBOutlet UIButton *menuSureButton;


@property (nonatomic,weak) id<MenuViewDelegate> delegate;
+(MenuView*)menuViewSetInfo:(MenuInfo*)menuInfo;
@end
