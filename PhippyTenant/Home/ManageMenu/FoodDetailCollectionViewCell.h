//
//  FoodDetailCollectionViewCell.h
//  Phippy
//
//  Created by toby on 18/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodDetailCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *title;
@property (strong, nonatomic) IBOutlet UILabel *price;

@property (strong, nonatomic) IBOutlet UIButton *btnDelete;
@end
