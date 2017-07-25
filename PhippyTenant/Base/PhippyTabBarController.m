//
//  PhippyTabBarController.m
//  Phippy
//
//  Created by toby on 11/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "PhippyTabBarController.h"

@interface PhippyTabBarController ()

@end

@implementation PhippyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.tabBar.tintColor = [UIColor blackColor];
    // 字体颜色 选中
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0F], NSForegroundColorAttributeName : [UIColor blackColor]} forState:UIControlStateSelected];
    
    // 字体颜色 未选中
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12.0F],  NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    
    
   
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
        //去掉上面的黑线
        CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
        
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        
        CGContextFillRect(context, rect);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        [self.tabBar setBackgroundImage:img];
        
        [self.tabBar setShadowImage:img];
        
        [self.tabBar setBackgroundColor:[UIColor whiteColor]];
    }
    return self;
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
