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

@interface HomeViewController()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:[[HomeHeaderView alloc] init]];
    [self.phippyNavigationController standardNavigationBarView];
    self.tableView.frame = CGRectMake(0, 150-64, SCREEN_WIDTH, SCREEN_HEIGHT);

    
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
        
//        [PHIRequest uploadImageWithImage:[UIImage imageNamed:@"back"]
//                               ImageName:@"back"
//                                 success:^(NSURLSessionDataTask *task, id responseObject) {
//                                     NSLog(@"uploadImage:%@",responseObject);
//                                }
//                                 failure:^(NSURLSessionDataTask *task, NSError *error) {
//                                     NSLog(@"uploadImage:%@",error);
//                                 }];
        
        [PHIRequest uploadImageWithImages:@[[UIImage imageNamed:@"back"],[UIImage imageNamed:@"logo"]]
                               ImageNames:@[@"bac",@"logo"]
                                  success:^(NSURLSessionDataTask *task, id responseObject) {
                                      NSLog(@"uploadImage:%@",responseObject);
                                  }
                                  failure:^(NSURLSessionDataTask *task, NSError *error) {
                                      NSLog(@"error:%@",error);
                                  }];
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
