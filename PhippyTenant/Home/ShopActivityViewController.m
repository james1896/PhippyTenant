//
//  ShopActivityViewController.m
//  PhippyTenant
//
//  Created by toby on 18/08/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "ShopActivityViewController.h"

@interface ShopActivityViewController ()

@end

@implementation ShopActivityViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.phippyNavigationController addBackButton];
//    self.title = @"店铺动态";
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
