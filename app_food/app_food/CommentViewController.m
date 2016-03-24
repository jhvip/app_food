//
//  CommentViewController.m
//  app_food
//
//  Created by 蒋豪 on 16/3/24.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "CommentViewController.h"
#import "STPopup.h"
#import "AFHTTPSessionManager.h"
#import "RequestUrl.h"
@interface CommentViewController ()<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *commentList;
@end

@implementation CommentViewController

-(NSMutableArray *)commentList{
    if (_commentList==nil) {
        _commentList=[NSMutableArray array];
    }
    return _commentList;
}

- (instancetype)init
{
    if (self = [super init]) {
        self.landscapeContentSizeInPopup = CGSizeMake(550, 650);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.dataSource=self;
    self.tableView.rowHeight=50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)closeComment:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"comment"];
     NSDictionary *param=@{@"dish_no":self.dish_no,
                          };
    AFHTTPSessionManager *manage=[AFHTTPSessionManager manager];
    [manage GET:CommentURL parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success,%@",responseObject);
        
        self.commentList=[NSMutableArray arrayWithArray:responseObject];
        [self.tableView reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error);
    }];


}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"comment" forIndexPath:indexPath];
    cell.textLabel.text=self.commentList[indexPath.row];
    cell.detailTextLabel.text=self.commentList[indexPath.row];
    
    
    return cell;
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
