//
//  BaseTabViewController.h
//  Phippy
//
//  Created by toby on 10/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "PhippyViewController.h"

@interface BaseTabViewController : PhippyViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray     *dataArray;

@property (nonatomic) CGFloat tableViewHeight;

@end

@interface FooterView : UIView

@end
