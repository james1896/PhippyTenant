//
//  BaseNavigationController.h
//  Phippy
//
//  Created by toby on 10/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - BaseNavigationController
@interface BaseNavigationController : UINavigationController

- (void)addBackButton;
- (void)addRightButtonWithTilte:(NSString *)title image:(UIImage *)image targat:(UIViewController *)targat action:(SEL)action;

- (void)originalNavigationBarView;
- (void)standardNavigationBarView;
- (void)translucentAndCenterTitleNavigationBarView;

//- (void)navigationBarViewFoodDetail;

@end

#pragma mark - NavigationBarView
@interface NavigationBarView : UIView

@property (nonatomic,strong) NSString *title;

+(instancetype)originalNavigationBarView;
+(instancetype)standardNavigationBarView;
+(instancetype)translucentAndCenterTitleNavigationBarView;
@end
