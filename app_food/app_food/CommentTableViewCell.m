//
//  CommentTableViewCell.m
//  app_food
//
//  Created by 蒋豪 on 16/3/25.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "CommentTableViewCell.h"
#import "CommentInfo.h"

@interface CommentTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *guestNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

@implementation CommentTableViewCell


-(void)commentSetInfo:(CommentInfo *)info{

    self.iconImageView.image=[UIImage imageNamed:info.iconImage];
    self.guestNameLabel.text=info.guestName;
    self.commentLabel.text=info.commentMsg;
    self.timeLabel.text=[info.time substringToIndex:19];

}

@end
