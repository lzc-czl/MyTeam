//
//  ViewController333.m
//  Demo1
//
//  Created by 李许康 on 16/4/27.
//  Copyright © 2016年 lxk. All rights reserved.
//

#import "ViewController333.h"

@interface ViewController333 ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong)UIView *backView;
@property (nonatomic,strong)UICollectionView *collectionView;
@end

@implementation ViewController333

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    [self LayoutView];
    // Do any additional setup after loading the view.
}

-(void)LayoutView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _backView = [[UIView alloc]init];
    CGFloat width = (IISCREEN_WIDTH-15*5)/4;
    _backView.frame = CGRectMake(0, 100, IISCREEN_WIDTH, 15+(width+15)*2+15+15+25);
    _backView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_backView];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(width, width+15);
    flowLayout.minimumInteritemSpacing = 15;
    flowLayout.minimumLineSpacing = 15;
    flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 15, 15);
    
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, IISCREEN_WIDTH, 15+(width+15)*2+15+15) collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor redColor];
    self.collectionView.showsVerticalScrollIndicator = YES;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.backView addSubview:self.collectionView];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section ==0) {
        return 4;
    }else{
        return 2;
        
    }
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blackColor];
    return cell;
    
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"选择了");
}
+ (BOOL)resolveInstanceMethod:(SEL)aSEL{
    return YES;
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
