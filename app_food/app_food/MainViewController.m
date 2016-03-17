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

@interface MainViewController ()<MenuViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *menuView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,assign)NSInteger currentIndex;

@property (weak, nonatomic) IBOutlet UIView *tabBarView;
//菜单order
@property (nonatomic,strong) NSMutableArray *orderArray;
@property (nonatomic,strong) NSArray *menuList;

@end


@implementation MainViewController
//懒加载
-(NSMutableArray *)orderArray{
    if (_orderArray==nil) {
        _orderArray=[NSMutableArray array];
    }
    return _orderArray;
}

//自定义TabBar
- (IBAction)tabBarButton:(UIButton*)sender {
    NSInteger index=(int)sender.tag-10;
    if (self.currentIndex==index) {
        return;
    }else{
        for (UIButton *button in [self.tabBarView subviews]) {
            if (button.tag-10==self.currentIndex) {
                button.selected=NO;
                button.backgroundColor=[UIColor blackColor];
                button.tintColor=[UIColor blackColor];
            }
        }
    
        _currentIndex=index;
        sender.backgroundColor=[UIColor whiteColor];
        sender.selected=YES;
        sender.tintColor=[UIColor whiteColor];
        
        
        [self loadMenuView:(int)sender.tag-10];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self loadMenuView:0];
    
    self.collectionView.delegate=self;
    self.collectionView.dataSource=self;
    
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    //指定布局方式为垂直
    flow.scrollDirection = UICollectionViewScrollDirectionVertical;
    flow.minimumLineSpacing = 15;//最小行间距(当垂直布局时是行间距，当水平布局时可以理解为列间距)
    flow.minimumInteritemSpacing = 20;//两个单元格之间的最小间距
    

    
    
    
    [self.collectionView setCollectionViewLayout:flow];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadMenuView:(int)class{
    User *user=[User takeUser];
    NSDictionary *param=@{@"userName":user.userName,
                          @"token":user.token,
                          @"status":@"find",
                          @"class":[NSString stringWithFormat:@"%d",class]
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

//-(void)showView:(NSArray*)info{
//    NSArray *menuList=[MenuInfo menuSetInfo:info];
//    
//    
//}




#pragma mark-点菜代理按钮
-(void)MenuViewReloadTableView{
    NSLog(@"刷新");
}
#pragma mark-collectionView 代理方法

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MenuView" bundle:nil] forCellWithReuseIdentifier:@"MenuView"];
    
    
    MenuView *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"MenuView" forIndexPath:indexPath];
    cell.delegate=self;
    cell.backgroundColor=[UIColor grayColor];
    [cell menuViewSetInfo:self.menuList[indexPath.row]];

    return cell;

}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width=self.collectionView.frame.size.width / 4 - 20;
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

@end
