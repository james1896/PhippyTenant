//
//  BaseViewController.h
//  Phippy
//
//  Created by toby on 11/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseNavigationController.h"
@interface PhippyViewController : UIViewController

@property(nonatomic,strong,readonly) PHIUserManager * _Nonnull userManager;

@end


@interface UIViewController(UIViewControllerItem)

//@property(nullable, nonatomic,readonly,strong) BaseTabBarController *baseTabbarController;
@property(nullable, nonatomic,readonly,strong) BaseNavigationController *phippyNavigationController;

@end
