//
//  ManageMenuViewController.m
//  PhippyTenant
//
//  Created by toby on 27/07/2017.
//  Copyright © 2017 kg.self.edu. All rights reserved.
//

#import "ManageMenuViewController.h"
#import "FoodDetailCollectionViewCell.h"
#import "LLImageViewController.h"

#define angle2Rad(angle) ((angle) / 180.0 * M_PI)


@interface ManageMenuViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>{
    
    //长按cell 摇动时，记住cell状态
    //    长按结束时 停止该cell
    FoodDetailCollectionViewCell *sharkeCell;
}

@property (nonatomic,strong) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic, strong) UILongPressGestureRecognizer *longPress;



@end

@implementation ManageMenuViewController

#pragma mark- life cycle

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    for(int i=0;i<10;i++){
        NSDictionary *dict = @{@"title":[NSString stringWithFormat:@"title %d",i],@"price":[NSString stringWithFormat:@"%dP",100+i]};
        [self.dataArray addObject:dict];
    }
    
    [self.collectionView reloadData];
    
}

- (void)plusPress:(UIButton *)sender {
    LLImageViewController *controller = [[LLImageViewController alloc]init];
    [self.phippyNavigationController pushViewController:controller animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.phippyNavigationController addBackButton];
    [self.phippyNavigationController addRightButtonWithTilte:nil image:[UIImage imageNamed:@"plus"] targat:self action:@selector(plusPress:)];
    [self.view addSubview:self.collectionView];
    
    _longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(lonePressMoving:)];
    [self.collectionView addGestureRecognizer:_longPress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark- set get

- (NSMutableArray *)dataArray{
    if(!_dataArray){
        _dataArray = [[NSMutableArray alloc]initWithCapacity:0];
    }
    return _dataArray;
}

- (UICollectionViewFlowLayout *)flowLayout{
    if(!_flowLayout){
        _flowLayout = [UICollectionViewFlowLayout new];
        //  collectionView的item大小
        _flowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-1)/2, 150);
        
        //  collectionView的item行间距
        _flowLayout.minimumLineSpacing = 1;
        
        //  collectionView的item列间距
        _flowLayout.minimumInteritemSpacing = 1;
        
        //  collectionView的sectionHeaderView大小
        //        _flowLayout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 41);
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView{
    if(!_collectionView){
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT) collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        //  注册item
        [_collectionView registerNib:[UINib nibWithNibName:@"FoodDetailCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"FoodDetailCollectionViewCell"];
        //  注册sectionHeaderView
        //    [collectionView registerClass:[XSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headerview"];
        
        //注册商家headerview
        [_collectionView registerNib:[UINib nibWithNibName:@"MerchantLogoReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MerchantLogoReusableView"];
        
    }
    return _collectionView;
}


#pragma mark- UICollectionViewDataSource

//  collectionView段数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
//  collectionView每段的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.dataArray.count;
}
//  collectionView的item
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dict = self.dataArray[indexPath.row];
    //  获取自定义的cell
    FoodDetailCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FoodDetailCollectionViewCell" forIndexPath:indexPath];
    cell.title.text = dict[@"title"];
    cell.price.text = dict[@"price"];
    cell.imgView.backgroundColor = COLOR(arc4random()%255, arc4random()%255, arc4random()%255, 0.6);
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath
{
    NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:self.collectionView]];
    // 找到当前的cell
    FoodDetailCollectionViewCell *cell = (FoodDetailCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectIndexPath];
    cell.btnDelete.hidden = YES;
    
    /*1.存在的问题,移动是二个一个移动的效果*/
    //	[collectionView moveItemAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
    /*2.存在的问题：只是交换而不是移动的效果*/
    //    [self.array exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];
    /*3.完整的解决效果*/
    //取出源item数据
    id objc = [self.dataArray objectAtIndex:sourceIndexPath.item];
    //从资源数组中移除该数据
    [self.dataArray removeObject:objc];
    //将数据插入到资源数组中的目标位置上
    [self.dataArray insertObject:objc atIndex:destinationIndexPath.item];
    
    
    [self.collectionView reloadData];
}

//这个方法是返回 Header的大小 size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(self.collectionView.frame.size.width, 150);
}

//这个也是最重要的方法 获取Header的 方法。
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headerView = nil;
    if([kind isEqualToString:UICollectionElementKindSectionHeader]){
        if(indexPath.section == 0){
            headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MerchantLogoReusableView" forIndexPath:indexPath];
        }
    }
    
    return headerView;
}


//长按手势
- (void)lonePressMoving:(UILongPressGestureRecognizer *)longPress
{
    
    switch (longPress.state) {
        case UIGestureRecognizerStateBegan: {
            {
                NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[longPress locationInView:self.collectionView]];
                // 找到当前的cell
                FoodDetailCollectionViewCell *cell = (FoodDetailCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectIndexPath];
                // 定义cell的时候btn是隐藏的, 在这里设置为NO
                [cell.btnDelete setHidden:NO];
                
                cell.btnDelete.tag = selectIndexPath.item;
                
                //添加删除的点击事件
                [cell.btnDelete addTarget:self action:@selector(btnDelete:) forControlEvents:UIControlEventTouchUpInside];
                
                [_collectionView beginInteractiveMovementForItemAtIndexPath:selectIndexPath];
                
             
                [self shakeAnimationForView:cell];
                sharkeCell = cell;
                
              
            }
            break;
        }
        case UIGestureRecognizerStateChanged: {
            [self.collectionView updateInteractiveMovementTargetPosition:[longPress locationInView:longPress.view]];
            break;
        }
        case UIGestureRecognizerStateEnded: {
            [self.collectionView endInteractiveMovement];
            
     
            break;
        }
        default: [self.collectionView cancelInteractiveMovement];
            break;
    }
}

- (void)shakeAnimationForView:(UIView *) view
{
    
    //1.创建动画对象
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    
    //2.设置属性值
    /**1:keyPath为layear下的属性的keypath路径 2：values是一个数组，在values数组里定义的对象都会产生动画效果，让图标先向左移动-3弧度，再动画回来移动到3弧度，在动画移动到-3，无限重复
     2：也可以设置动画的翻转效果：anim.values = @[@(angle2Rad(-3)),@(angle2Rad(3))],anim.autoreverses，这样执行完values里的动画到3弧度后，还会动画回来继续重复,否则不会产生动画
     3：再把动画添加到layear层上，核心动画都是作用砸layear层上
     *
     */
    anim.keyPath = @"transform.rotation";
    anim.values = @[@(angle2Rad(-2)),@(angle2Rad(2)),@(angle2Rad(-2))];
    
    //3.设置动画执行次数
    anim.repeatCount =  MAXFLOAT;
    
    anim.duration = 0.2;
    
    //anim.autoreverses = YES;
    
    anim.removedOnCompletion = YES;
    [view.layer addAnimation:anim forKey:nil];
}

#pragma mark---UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if(sharkeCell){
        NSIndexPath *indPath = [collectionView indexPathForCell:sharkeCell];
        if([indPath isEqual:indexPath]){
            //取消cell摇动
            [sharkeCell.layer removeAllAnimations];
            sharkeCell.btnDelete.hidden = YES;
            sharkeCell = nil;
            return;
        }
       
    }
 
    NSLog(@"%@",self.dataArray[indexPath.item]);
}

#pragma mark---btn的删除cell事件

- (void)btnDelete:(UIButton *)btn{
    
    //cell的隐藏删除设置
    NSIndexPath *selectIndexPath = [self.collectionView indexPathForItemAtPoint:[_longPress locationInView:self.collectionView]];
    // 找到当前的cell
    FoodDetailCollectionViewCell *cell = (FoodDetailCollectionViewCell *)[self.collectionView cellForItemAtIndexPath:selectIndexPath];
    cell.btnDelete.hidden = NO;
    
    //取出源item数据
    id objc = [self.dataArray objectAtIndex:btn.tag];
    //从资源数组中移除该数据
    [self.dataArray removeObject:objc];
    
    [self.collectionView reloadData];
    
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
