//
//  ViewController111.m
//  Demo1
//
//  Created by 李许康 on 16/4/27.
//  Copyright © 2016年 lxk. All rights reserved.
//

#import "ViewController111.h"
#import "ViewController112.h"
@interface ViewController111 ()

@end

@implementation ViewController111

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self showHUD];
//    [self performSelector:@selector(delayMethod) withObject:nil afterDelay:3.0f];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *view = [[UIView alloc]init];
    view.frame = CGRectMake(40, 100, 80, 40);
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    UILabel *label = [[UILabel alloc]init];
    label.frame = CGRectMake(view.right, view.top, 60, 20);
    label.text = @"测试";
    label.textColor = [UIColor blackColor];
    [self.view addSubview:label];
    UIButton *bt = [[UIButton alloc]init];
    bt.frame = CGRectMake(50, 200, 100, 40);
    [bt setBackgroundColor:[UIColor greenColor]];
    [bt setTitle:@"可点击" forState:UIControlStateNormal];
    [bt setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [bt addTarget:self action:@selector(pushOther) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bt];
    [self.navigationController.navigationBar setBarTintColor:UTILITYCOLOR(@"#DE3031")];
    self.navigationController.navigationBar.translucent = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    //[NSThread sleepForTimeInterval:4];//阻塞线程
    // Do any additional setup after loading the view.
}

//-(void)delayMethod{
//    [self hideHUD];
//
//}
-(void)pushOther{
    ViewController112 *vc112 = [[ViewController112 alloc]init];
    [self.navigationController pushViewController:vc112 animated:YES];
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
