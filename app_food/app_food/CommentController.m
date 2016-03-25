//
//  CommentController.m
//  app_food
//
//  Created by 蒋豪 on 16/3/25.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "CommentController.h"
#import "STPopup.h"
#import "CommentTableViewCell.h"
#import "AFNetworking.h"
#import "RequestUrl.h"
#import "CommentInfo.h"
@interface CommentController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSArray *commentList;

@property (weak, nonatomic) IBOutlet UIImageView *commentImage;

@end

@implementation CommentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    self.tableView.rowHeight=80;
    
}


- (IBAction)closeWin {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init
{
    if (self = [super init]) {
        self.landscapeContentSizeInPopup = CGSizeMake(550, 650);
    }
    return self;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CommentTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"comment" forIndexPath:indexPath];
    if (!cell) {
        cell=[[CommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
    }
    [cell commentSetInfo:self.commentList[indexPath.row]];
    return cell;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.commentList.count) {
        return self.commentList.count;
    }return 0;

}

-(void)loadCommentInfo{
    

}


-(void)viewWillAppear:(BOOL)animated{
    [self.tableView registerNib:[UINib nibWithNibName:@"CommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"comment"];
    NSDictionary *param=@{@"dish_no":self.dish_no,
                          };
    AFHTTPSessionManager *manage=[AFHTTPSessionManager manager];
    [manage GET:CommentURL parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSMutableArray *infoList=[NSMutableArray arrayWithArray:responseObject];
        self.commentList=[CommentInfo commentSetInfo:infoList];
        
        if (self.commentList.count==0) {
            self.tableView.hidden=YES;
            self.commentImage.hidden=NO;
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error);
    }];

}

- (IBAction)backView {
    [self.popupController popViewControllerAnimated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
