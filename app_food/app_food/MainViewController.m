//
//  ViewController.m
//  app_food
//
//  Created by 蒋豪 on 16/1/30.
//  Copyright © 2016年 jh. All rights reserved.
//

#import "MainViewController.h"
#import "MenuView.h"
#import "AFNetworking.h"
#import "User.h"
#import "MenuInfo.h"
#import "RequestUrl.h"
#import "OrderCell.h"
#import "HMSegmentedControl.h"

@interface MainViewController ()<MenuViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,assign)NSInteger currentIndex;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UIView *tabBarView;
//菜单order
@property (nonatomic,strong) NSMutableArray *orderArray;
@property (nonatomic,strong) NSArray *menuList;
@property (nonatomic,strong) NSMutableArray *orderList;

@end


@implementation MainViewController
//懒加载
-(NSMutableArray *)orderArray{
    if (_orderArray==nil) {
        _orderArray=[NSMutableArray array];
    }
    return _orderArray;
}

-(NSMutableArray *)orderList{
    if (_orderList==nil) {
        _orderList=[NSMutableArray array];
    }
    return _orderList;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //设置初始选项
    [self loadMenuView:0];
    //加载collection
    [self collectionSet];
    //加载tableVIew
    [self tableViewSet];
    
    UIImageView *bgimage=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"bj"]];
    [self.view addSubview:bgimage];
    
    //设置tabBarView
    HMSegmentedControl *segmentedControl1 = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"热菜",@"冷菜",@"炒菜",@"饮料"]];
    
    segmentedControl1.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
    segmentedControl1.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    segmentedControl1.scrollEnabled = YES;
    [segmentedControl1 setBackgroundColor:[UIColor blackColor]];
    segmentedControl1.textColor=[UIColor whiteColor];
    segmentedControl1.font=[UIFont systemFontOfSize:30];
    
    [segmentedControl1 setSelectionIndicatorColor:[UIColor colorWithRed:0.8392 green:0.8392 blue:0.8392 alpha:1.0f]];
    
    
    [segmentedControl1 setSelectionStyle:HMSegmentedControlSelectionStyleBox];
    
    segmentedControl1.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    [segmentedControl1 setFrame:CGRectMake(0, 0, self.tabBarView.frame.size.width, 80)];
    [segmentedControl1 addTarget:self action:@selector(loadMenuView:) forControlEvents:UIControlEventValueChanged];
    [self.tabBarView addSubview:segmentedControl1];
    self.tabBarView.backgroundColor=[UIColor colorWithRed:0.8392 green:0.8392 blue:0.8392 alpha:0.6f];
    
    
}

#pragma mark-设置collection
-(void)collectionSet{
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    self.collectionView.backgroundColor=[UIColor colorWithRed:0.8392 green:0.8392 blue:0.8392 alpha:0.6f];
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    //指定布局方式为垂直
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumLineSpacing = 15;//最小行间距(当垂直布局时是行间距，当水平布局时可以理解为列间距)
    flow.minimumInteritemSpacing = 10;//两个单元格之间的最小间距
    [self.collectionView setCollectionViewLayout:flow];
    
}

#pragma mark-设置tableView
-(void)tableViewSet{
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.tableView registerNib:[UINib nibWithNibName:@"OrderCell" bundle:nil] forCellReuseIdentifier:@"orderList"];
   

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadMenuView:(HMSegmentedControl*)HMSegmentedControl{
    User *user=[User takeUser];
    NSDictionary *param=@{@"userName":user.userName,
                          @"token":user.token,
                          @"status":@"find",
                          @"class":[NSString stringWithFormat:@"%ld",HMSegmentedControl.selectedSegmentIndex]
                          };
    AFHTTPSessionManager *manage=[AFHTTPSessionManager manager];
    [manage GET:MenuURL parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"success,%@",responseObject);
        
        //[self showView:responseObject];
        self.menuList=[MenuInfo menuSetInfo:responseObject];
        
        [self.collectionView reloadData];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error %@",error);
    }];
    
    
}




#pragma mark-点菜代理按钮
-(void)MenuViewReloadTableView:(NSArray *)orderList{
    self.orderList=[NSMutableArray arrayWithArray:orderList];
    [self.tableView reloadData];
}
#pragma mark-collectionView 代理方法

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MenuView" bundle:nil] forCellWithReuseIdentifier:@"MenuView"];
    
    
    MenuView *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MenuView" forIndexPath:indexPath];
    cell.delegate=self;
    cell.backgroundColor=[UIColor whiteColor];
    [cell menuViewSetInfo:self.menuList[indexPath.row]];

    return cell;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width=self.collectionView.frame.size.width / 4 - 10;
    CGFloat height=width*1.22;
    return CGSizeMake(width, height);
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//协议中的方法，用于返回分区中的单元格个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.menuList) {
        return self.menuList.count;
    }
    else{
        return 0;
    }
}

#pragma mark-设置tableView数据源和代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.orderList) {
        return self.orderList.count;
    }
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    OrderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"orderList" forIndexPath:indexPath];
    if (!cell) {
        cell=[[OrderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"orderList"];
    }
    [cell orderCellSetCell:self.orderList[indexPath.row] num:indexPath.row];
    cell.backgroundColor=[UIColor colorWithRed:0.8392 green:0.8392 blue:0.8392 alpha:1.0f];
    return cell;

}


-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}


/*删除用到的函数*/
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        /*此处处理自己的代码，如删除数据*/
        [self.orderList removeObjectAtIndex:indexPath.row];
        
        /*删除tableView中的一行*/
        [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
       
        
    }
}


- (IBAction)makeOrder:(id)sender {
    
    [self.tableView setEditing:YES];
    
}


@end
