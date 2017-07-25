//
//  BaseNavigationController.m
//  Phippy
//
//  Created by toby on 10/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "BaseNavigationController.h"

@interface BaseNavigationController ()<UIGestureRecognizerDelegate>{
    
    NavigationBarView *_navBarView;
    UIView *systemTitleView;
}

@property (nonatomic,strong)NavigationBarView *navBarView;
@end

@implementation BaseNavigationController

- (void)addBackButton{
    
    [self.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.7]] forBarMetrics:UIBarMetricsDefault];
    //     self.visibleViewController.automaticallyAdjustsScrollViewInsets = NO;
    
    //自定义一个按钮
    UIButton  *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn addTarget:self action:@selector(backLastView) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(-6, 5, 30, 22);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //将leftItem设置为自定义按钮
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [backView addSubview:leftBtn];
    UIBarButtonItem  *leftItem =[[UIBarButtonItem alloc]initWithCustomView: backView];
    self.topViewController.navigationItem.leftBarButtonItem = leftItem;
    
}

- (void)addRightButtonWithTilte:(NSString *)title image:(UIImage *)image targat:(UIViewController *)targat action:(SEL)action{
    //自定义一个按钮
    UIButton  *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn.frame = CGRectMake(0, 0, 60, 44);
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];

    if (image) [rightBtn setBackgroundImage:image forState:UIControlStateNormal];
    if(title) [rightBtn setTitle:title forState:UIControlStateNormal];
    if(action && targat)[rightBtn addTarget:targat action:action forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor: COLOR(168, 168, 168, 1) forState:UIControlStateNormal];
    //将leftItem设置为自定义按钮
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 44)];
    [backView addSubview:rightBtn];
    UIBarButtonItem  *rightItem =[[UIBarButtonItem alloc]initWithCustomView: backView];
    self.topViewController.navigationItem.rightBarButtonItem = rightItem;
}

- (void)addRightButton{
    //自定义一个按钮
    UIButton  *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn addTarget:self action:@selector(backLastView) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(0, 5, 30, 22);
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"call"] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //将leftItem设置为自定义按钮
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 40, 44)];
    [backView addSubview:rightBtn];
    UIBarButtonItem  *rightItem =[[UIBarButtonItem alloc]initWithCustomView: backView];
    self.topViewController.navigationItem.rightBarButtonItem = rightItem;
}

- (void)backLastView{
    [self popViewControllerAnimated:YES];
}

- (void)setNavBarView:(NavigationBarView *)navBarView{
    _navBarView = navBarView;
    systemTitleView = self.visibleViewController.navigationItem.titleView;
    self.visibleViewController.navigationItem.titleView = navBarView;
}

- (void)originalNavigationBarView{
    //    self.navBarView = [NavigationBarView originalNavigationBarView];
    self.visibleViewController.navigationItem.titleView = systemTitleView;
}

- (void)standardNavigationBarView{
    self.navBarView = [NavigationBarView standardNavigationBarView];
}

- (void)translucentAndCenterTitleNavigationBarView{
    self.navBarView = [NavigationBarView translucentAndCenterTitleNavigationBarView];
    
    //设置系统navbar背景透明
    [self.visibleViewController.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0]] forBarMetrics:UIBarMetricsDefault];
    
    //scrollView 忽略navbar高度
    self.visibleViewController.automaticallyAdjustsScrollViewInsets = NO;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.去掉nav下方的 黑线
    //     2.
    [self.navigationBar setBackgroundImage:[self createImageWithColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:0.8]] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.barStyle = UIBarStyleDefault;
    
    //navbar自带的 透明
    //    self.navigationBar.translucent = NO;
    [self.navigationBar setShadowImage:[UIImage new]];
    self.extendedLayoutIncludesOpaqueBars = YES;
    
    //设置默认title的字体颜色
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]}];
    
    
    //解决自定义返回按钮 手势返回消失问题
    self.interactivePopGestureRecognizer.enabled = YES;
    self.interactivePopGestureRecognizer.delegate = self;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    return YES;
}

- (UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
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



@implementation NavigationBarView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)addLogo{
    UIImageView *logo = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 75, 44)];
    logo.image = [UIImage imageNamed:@"logo"];
    
    [self addSubview:logo];
}

+ (instancetype)standardNavigationBarView{
    NavigationBarView *barView = [[NavigationBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    //    barView.backgroundColor = [UIColor purpleColor];
    [barView addLogo];
    return barView;
}


+ (instancetype)translucentAndCenterTitleNavigationBarView{
    NavigationBarView *barView = [[NavigationBarView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
    return barView;
}

@end






