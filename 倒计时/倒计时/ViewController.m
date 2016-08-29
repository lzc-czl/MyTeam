//
//  ViewController.m
//  倒计时
//
//  Created by 李许康 on 16/3/11.
//  Copyright © 2016年 lxk. All rights reserved.
//

#import "ViewController.h"
#import "MZTimerLabel.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label1 = [[UILabel alloc]init];
    label1.frame = CGRectMake(100, 200, 200, 200);
    MZTimerLabel *label = [[MZTimerLabel alloc]initWithLabel:label1];
    [label setCountDownTime:20];
    [label start];
    [self.view addSubview:label1];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
