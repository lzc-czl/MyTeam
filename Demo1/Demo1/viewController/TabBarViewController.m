//
//  TabBarViewController.m
//  Demo1
//
//  Created by 李许康 on 16/4/27.
//  Copyright © 2016年 lxk. All rights reserved.
//

#import "TabBarViewController.h"
#import "ViewController111.h"
#import "ViewController222.h"
#import "ViewController333.h"
#import "ViewController444.h"
#import "ViewController555.h"

//#define IISCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width

@interface TabBarViewController (){
    NSArray  *_imageArr;
    NSMutableArray *_btArr;
    NSArray  *_HeightimageArr;
}
@end

@implementation TabBarViewController

- (void)viewDidLoad {
    _imageArr = [[NSArray alloc]init];
    _HeightimageArr = [[NSArray alloc]init];
    _btArr = [[NSMutableArray alloc]init];
    [super viewDidLoad];
    ViewController111 *VC11 = [[ViewController111 alloc]init];
    VC11.navigationItem.title = @"第一个";
//    VC11.tabBarItem.title = @"红";
//    VC11.tabBarItem.image = [UIImage imageNamed:@"正常_08.png"];
//    VC11.tabBarItem.selectedImage = [UIImage imageNamed:@"按下_08.png"];
    UINavigationController *na11 = [[UINavigationController alloc]initWithRootViewController:VC11];
    //na11.title = @"红";
    ViewController222 *VC22 = [[ViewController222 alloc]init];
    VC22.navigationItem.title = @"第二个";
//    VC22.tabBarItem.title = @"黑";
//    VC22.tabBarItem.image =[UIImage imageNamed:@"正常_10.png"];
//       VC22.tabBarItem.selectedImage = [UIImage imageNamed:@"按下_10.png"];
    UINavigationController *na22 = [[UINavigationController alloc]initWithRootViewController:VC22];
   // na22.title = @"黑";
    ViewController333 *VC33 = [[ViewController333 alloc]init];
    VC33.navigationItem.title =@"第三个";
//    VC33.tabBarItem.title = @"绿";
//    VC33.tabBarItem.image =[UIImage imageNamed:@"2加长金融贷款-(2)_12.png"];
//       VC33.tabBarItem.selectedImage = [UIImage imageNamed:@"点击后加长金融贷款-(2)_12.png"];
    UINavigationController *na33 = [[UINavigationController alloc]initWithRootViewController:VC33];
    //na33.title = @"绿";
    ViewController444 *VC44 = [[ViewController444 alloc]init];
    UINavigationController *na44 = [[UINavigationController alloc]initWithRootViewController:VC44];
    ViewController555 *VC55 = [[ViewController555 alloc]init];
    UINavigationController *na55 = [[UINavigationController alloc]initWithRootViewController:VC55];
    self.viewControllers =@[na11,na22,na33,na44,na55];
    //self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
    [self layTabBar];
}

-(void)layTabBar{
 
    [self.tabBar setClipsToBounds:YES];
    _imageArr = @[[UIImage normalImageWithImage:@"正常_08.png" title:nil],
                  [UIImage normalImageWithImage:@"正常_10.png" title:nil],
                  [UIImage normalImageWithImage:@"2加长金融贷款-(2)_12.png" title:nil],
                  [UIImage normalImageWithImage:@"2加长金融贷款-(2)_12.png" title:nil],
                  [UIImage normalImageWithImage:@"2加长金融贷款-(2)_12.png" title:nil]];
    
    _HeightimageArr = @[[UIImage selectedImageWithImage:@"按下_08.png" title:nil],
                        [UIImage selectedImageWithImage:@"按下_10.png" title:nil],
                        [UIImage selectedImageWithImage:@"点击后加长金融贷款-(2)_12.png" title:nil],
                        [UIImage selectedImageWithImage:@"点击后加长金融贷款-(2)_12.png" title:nil],
                        [UIImage selectedImageWithImage:@"点击后加长金融贷款-(2)_12.png" title:nil]];
    
    CGFloat width = [[UIScreen mainScreen] bounds].size.width/self.viewControllers.count;
    for (int i = 0; i<5;i++) {
        UIButton *bt = [[UIButton alloc]init];
        bt.frame = CGRectMake(i*width, 0, width, 49);
        bt.tag = 100+i;
        [bt setBackgroundImage:_imageArr[i] forState:UIControlStateNormal];
        [bt setBackgroundImage:_HeightimageArr[i] forState:UIControlStateHighlighted];
        [_btArr addObject:bt];
        [bt addTarget:self action:@selector(selectedTab:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:bt];
        [self.tabBar bringSubviewToFront:bt];

    }
    UIButton *button_ = (UIButton *)[self.tabBar viewWithTag:100];
    [button_ setBackgroundImage:_HeightimageArr[self.selectedIndex] forState:(UIControlStateNormal)];
}

-(void)selectedTab:(UIButton *)sender{
    self.selectedIndex = sender.tag-100;
    int i = 0;
    [sender setBackgroundImage:_HeightimageArr[sender.tag-100] forState:UIControlStateNormal];
    for (UIButton *bt in _btArr) {
        if (bt!=sender) {
            [bt setBackgroundImage:_imageArr[i] forState:UIControlStateNormal];
        }
        i++;
    }
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
