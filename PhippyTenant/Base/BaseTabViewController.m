//
//  BaseTabViewController.m
//  Phippy
//
//  Created by toby on 10/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "BaseTabViewController.h"

@interface BaseTabViewController ()

@end

@implementation BaseTabViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.dataArray.count;
//    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    return cell;
}

- (void)setTableViewHeight:(CGFloat)tableViewHeight{
    _tableViewHeight = tableViewHeight;
    CGRect frame = self.tableView.frame;
    self.tableView.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, tableViewHeight);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.estimatedRowHeight = 100;  //  随便设个不那么离谱的值
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
//    self.tableView.backgroundColor = COLOR(132, 232, 32, 1);
    
    UIImageView *img = [[UIImageView alloc] initWithFrame:self.tableView.bounds];
    
#warning 需要全局设置tabview背景
//    img.image = [UIImage imageNamed:@"logo_girl.jpg"];
    self.tableView.backgroundView = img;
    
    [self.view addSubview:self.tableView];
    
//    self.dataArray = @[@"sss"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@implementation FooterView

+(instancetype)standardBottomLineFooterViewWithFrame:(CGRect)frame{
    FooterView *footer = [[FooterView alloc]initWithFrame:frame];
    footer.backgroundColor = COLOR(51, 51, 51, 1);
    return footer;
}

@end
