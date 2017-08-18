//
//  HomeViewController.m
//  PhippyTenant
//
//  Created by toby on 25/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "HomeViewController.h"
#import "ManageTableViewCell.h"
#import "DemandTableViewCell.h"
#import "ManageMenuViewController.h"
#import "PHIRequest.h"

#import "SDCycleScrollView.h"

//---------------------------------------------------------------------------------------
//  HomeHeaderView
//---------------------------------------------------------------------------------------

@interface HomeHeaderView : UIView

@end

@implementation HomeHeaderView

- (instancetype)init
{
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
    if (self) {
        self.backgroundColor = [UIColor purpleColor];
    }
    return self;
}

@end



//---------------------------------------------------------------------------------------
//                              HomeViewController
//---------------------------------------------------------------------------------------
//  1.
//  2.
//  3.
//
//
//---------------------------------------------------------------------------------------

@interface HomeViewController()<SDCycleScrollViewDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:[[HomeHeaderView alloc] init]];
    [self.phippyNavigationController standardNavigationBarView];
    self.tableView.frame = CGRectMake(0, 150-64, SCREEN_WIDTH, SCREEN_HEIGHT);

    
//    // 情景一：采用本地图片实现
//    NSArray *images = @[[UIImage imageNamed:@"h1.jpg"],
//                        [UIImage imageNamed:@"h2.jpg"],
//                        [UIImage imageNamed:@"h3.jpg"],
//                        [UIImage imageNamed:@"h4.jpg"]
//                        ];
    
    // 情景二：采用网络图片实现
    NSArray *imagesURL = @[
                           [NSURL URLWithString:@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg"],
                           [NSURL URLWithString:@"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg"],
                           [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1502079256027&di=78507b9234dd5c6a4e53b4b3352ee70e&imgtype=0&src=http%3A%2F%2Fimgsrc.baidu.com%2Fbaike%2Fpic%2Fitem%2F4651a712c13e6890c2fd7805.jpg"],
                           [NSURL URLWithString:@"https://ss0.baidu.com/7Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=0c231a5bb34543a9f54ea98c782abeb0/a71ea8d3fd1f41342830c1d1211f95cad1c85e1e.jpg"]
                           ];
    
    // 情景三：图片配文字
    NSArray *titles = @[@"感谢您的支持，如果下载的",
                        @"如果代码在使用过程中出现问题",
                        @"您可以发邮件到gsdios@126.com",
                        @"感谢您的支持"
                        ];
    
    
    
    
    CGFloat w = self.view.bounds.size.width;
    
//    // 创建不带标题的图片轮播器
//    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 60, w, 180) imagesGroup:images];
//    cycleScrollView.delegate = self;
//    [self.view addSubview:cycleScrollView];
//    // 轮播时间间隔，默认1.0秒，可自定义
//    cycleScrollView.autoScrollTimeInterval = 3.0;
    
    
    // 创建带标题的图片轮播器
    SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 280, w, 200) imageURLsGroup:imagesURL];
    cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView2.delegate = self;
    cycleScrollView2.titlesGroup = titles;

    cycleScrollView2.autoScrollTimeInterval = 3.0;
    self.tableView.tableHeaderView = cycleScrollView2;
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"---点击了第%ld张图片", index);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    UITableViewCell *tCell = nil;
    if(indexPath.row == 0){
       ManageTableViewCell * cell = [[[NSBundle mainBundle] loadNibNamed:@"ManageTableViewCell" owner:nil options:nil]lastObject];
    
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(latestTap)];
        [cell.latestLab addGestureRecognizer:tap1];
        
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(manageTap)];
        [cell.menuLab addGestureRecognizer:tap2];
        tCell = cell;
        
    }else if (indexPath.row == 1){
        DemandTableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"DemandTableViewCell" owner:nil options:nil]lastObject];
        
        tCell = cell;
    }
    return tCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 1){
        NSLog(@"indexPath.row :%ld",indexPath.row);
        
        [PHIRequest uploadImageWithImage:[UIImage imageNamed:@"back"]
                               imageName:@"back"
                                 storeId:@"10011"
                                 success:^(NSURLSessionDataTask *task, id responseObject) {
                                    
                                 } failure:^(NSURLSessionDataTask *task, NSError *error) {
            
                                 }];
//        [PHIRequest uploadImageWithImage:[UIImage imageNamed:@"back"]
//                               ImageName:@"back"
//                                 success:^(NSURLSessionDataTask *task, id responseObject) {
//                                     NSLog(@"uploadImage:%@",responseObject);
//                                }
//                                 failure:^(NSURLSessionDataTask *task, NSError *error) {
//                                     NSLog(@"uploadImage:%@",error);
//                                 }];
        
//        [PHIRequest uploadImageWithImages:@[[UIImage imageNamed:@"back"],[UIImage imageNamed:@"logo"]]
//                               ImageNames:@[@"bac",@"logo"]
//                                  success:^(NSURLSessionDataTask *task, id responseObject) {
//                                      NSLog(@"uploadImage:%@",responseObject);
//                                  }
//                                  failure:^(NSURLSessionDataTask *task, NSError *error) {
//                                      NSLog(@"error:%@",error);
//                                  }];
    }
    
}

- (void)latestTap{
    NSLog(@"%@",NSStringFromSelector(_cmd));
}

- (void)manageTap{
    ManageMenuViewController *controller = [[ManageMenuViewController alloc]init];
    controller.title = @"菜单管理";
    controller.hidesBottomBarWhenPushed = YES;
    [self.phippyNavigationController pushViewController:controller animated:YES];
}

@end
