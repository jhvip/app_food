//
//  OrderView.m
//  app_food
//
//  Created by 蒋豪 on 16/3/28.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "OrderView.h"
#import "STPopup.h"
#import "OrderCell.h"
@interface OrderView ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong)NSArray *orderList;
@end

@implementation OrderView

- (instancetype)init
{
    if (self = [super init]) {
        self.contentSizeInPopup = CGSizeMake(0,0);
        self.landscapeContentSizeInPopup = CGSizeMake(550, 650);
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderCell" bundle:nil] forCellReuseIdentifier:@"orderList"];
    self.orderList=[[NSUserDefaults standardUserDefaults]objectForKey:@"orderList"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeOrderView {
    [self.popupController dismissWithCompletion:nil];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.orderList.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    OrderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"orderList" forIndexPath:indexPath];
    if (!cell) {
        cell=[[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderList"];
    }
    [cell orderCellSetCell:self.orderList[indexPath.row] num:indexPath.row];
    cell.bgView.backgroundColor=[UIColor orangeColor];
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
