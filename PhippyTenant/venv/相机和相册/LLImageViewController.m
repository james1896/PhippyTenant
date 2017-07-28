//
//  LLImageViewController.m
//  LLImagePickerDemo
//
//  Created by toby on 28/07/2017.
//  Copyright © 2017 liushaohua. All rights reserved.
//

#import "LLImageViewController.h"

#import "AddLLImagePickerVC.h"
#import "DisplayLLImagePickerVC.h"
#import "EditLLImagePickerVC.h"
#import "PresentViewController.h"

@interface LLImageViewController ()

@end

@implementation LLImageViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@""];
    NSArray *arr = @[@"添加",@"预览",@"添加以及预览添加",@"打开相机"];
    cell.textLabel.text = arr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSArray *arr = @[@"添加",@"预览",@"添加以及预览添加",@"打开相机"];
    
    UIViewController *controller = nil;
    switch (indexPath.row) {
        case 0:{
            controller = [[AddLLImagePickerVC alloc]init];
             break;
        }
        case 1:{
            controller = [[DisplayLLImagePickerVC alloc]init];
            break;
        }
        case 2:{
            controller = [[EditLLImagePickerVC alloc]init];
            break;
        }
        case 3:{
            controller = [[PresentViewController alloc]init];
//            [self presentViewController:controller animated:YES completion:nil];
            break;
        }
            
            
        default:
            break;
    }
    
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
