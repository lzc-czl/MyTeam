 //
//  ViewController222.m
//  Demo1
//
//  Created by 李许康 on 16/4/27.
//  Copyright © 2016年 lxk. All rights reserved.
//

#import "ViewController222.h"

@interface ViewController222 ()

@end

@implementation ViewController222

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    CGSize size = CGSizeMake(100, 200);
    UIImage *image = [UIImage imageWithSize:size color:[UIColor redColor]];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:image];
    imageView.frame = CGRectMake(100, 150, 100, 200);
    [self.view addSubview:imageView];
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
