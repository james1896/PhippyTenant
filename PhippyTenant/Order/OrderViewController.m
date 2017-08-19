//
//  OrderViewController.m
//  PhippyTenant
//
//  Created by toby on 18/08/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "OrderViewController.h"
#import "OrderTableViewCell.h"
@interface OrderViewController ()

@property (nonatomic,strong) UIButton *selectedButton;
@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.phippyNavigationController standardNavigationBarView];
    
    [self addButtons];
    self.tableView.frame = CGRectMake(0, self.selectedButton.top, SCREEN_WIDTH, SCREEN_HEIGHT  -self.selectedButton.top);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OrderTableViewCell *cell = [[[NSBundle mainBundle]loadNibNamed:@"OrderTableViewCell" owner:nil options:nil] lastObject];
    cell.statusLab.text = (_selectedButton.tag == 0?@"进行中":(_selectedButton.tag == 1?@"配送中":@"已完成"));
    cell.statusLab.backgroundColor = self.selectedButton.backgroundColor;
    return cell;
}

- (void)addButtons{
    
    UIButton *progress = [UIButton buttonWithType:UIButtonTypeCustom];
    progress.tag = 0;
    progress.frame = CGRectMake(0, 64, SCREEN_WIDTH/3, 45);
    [progress setTitle:@"进行中" forState:UIControlStateNormal];
    [progress addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    [progress setBackgroundColor:COLOR(212, 16, 89, 1)];
    [self.view addSubview:progress];
    
    UIButton *delivery = [UIButton buttonWithType:UIButtonTypeCustom];
    delivery.tag = 1;
    delivery.frame = CGRectMake(progress.right, 64, SCREEN_WIDTH/3, 45);
    [delivery setTitle:@"配送中" forState:UIControlStateNormal];
    [delivery setBackgroundColor:COLOR(22, 161, 189, 1)];
    [delivery addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:delivery];
    
    UIButton *finish = [UIButton buttonWithType:UIButtonTypeCustom];
    finish.tag = 2;
    finish.frame = CGRectMake(delivery.right, 64, SCREEN_WIDTH/3, 45);
    [finish setTitle:@"已完成" forState:UIControlStateNormal];
    [finish setBackgroundColor:COLOR(12, 116, 89, 1)];
    [finish addTarget:self action:@selector(buttonPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finish];
    
    self.selectedButton = progress;
    
}

- (void)buttonPress:(UIButton *)sender{
    self.selectedButton = sender;
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
 
    
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
