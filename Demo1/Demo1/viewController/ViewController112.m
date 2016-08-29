//
//  ViewController112.m
//  Demo1
//
//  Created by 李许康 on 16/7/26.
//  Copyright © 2016年 lxk. All rights reserved.
//

#import "ViewController112.h"
#import "lxkHTTPClient.h"
#import "BaseModel.h"
#import "TXDaiHomeViewScrollImageModel.h"
#import "UIImageView+WebCache.h"
#import <ShareSDK/ShareSDK.h>
#import "WeiboSDK.h"
#import "WXApi.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>




@interface ViewController112 ()<UICollectionViewDataSource,UICollectionViewDelegate>{
    
    CGFloat _height;
    CGFloat itemSpace;
    CGFloat itemWidth;
    UIView *_boardView;
    NSMutableArray *_titles;
    NSMutableArray *_imageNames;
    NSInteger _clickedNum;
    NSMutableArray *_types;
    NSInteger _times;

}

@property (nonatomic,strong) UIButton *noNetWorkView;
@property (nonatomic,strong) TXDaiHomeViewScrollImageModel *pictureModel;
@property (nonatomic,strong) NSMutableArray *imageArr;
@property (nonatomic,strong) UICollectionView *shareItem;
@property (nonatomic,strong) UIView *shareView;

@end

@implementation ViewController112


-(void)viewDidLoad{
    
    [super viewDidLoad];
    [self addBackButton];
    [self setNavigationItemTitle:@"第一的子视图"];
    self.view.backgroundColor = [UIColor whiteColor];
    self.imageArr = [[NSMutableArray alloc]init];
    [self rightItemWithText:@"分享" andAction:@selector(share)];
    _titles = [NSMutableArray arrayWithObjects:
               @"新浪微博",
               @"微信好友",
               @"微信朋友圈",
               @"QQ",
               nil];
    _imageNames = [NSMutableArray arrayWithObjects:
                   @"sharePanelView_sinablogbtn_icon_n.png",
                   @"sharePanelView_wechatbtn_icon_n.png",
                   @"sharePanelView_wefriendbtn_icon_n.png",
                   @"sns_icon_24.png",
                   nil];
    _types = [NSMutableArray arrayWithObjects:
              @(SSDKPlatformTypeSinaWeibo),
              @(SSDKPlatformSubTypeWechatSession),
              @(SSDKPlatformSubTypeWechatTimeline),
              @(SSDKPlatformSubTypeQQFriend),
              nil];
    //self.navigationItem.rightBarButtonItem.title = @"分享";
//    NSString *value = @"1122<i>333</i>";
//    NSArray *arr = [value componentsSeparatedByString:@"<i>"];
//    NSString *ss = [arr objectAtIndex:1];
//    NSArray *newarr = [arr[1] componentsSeparatedByString:@"</i>"];
     [self creatShareView];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
    
}

-(void)layoutView{
    if (self.imageArr.count ==1){
        
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100, IISCREEN_WIDTH, 100)];
        [self.view addSubview:imageView];
        TXDaiPicurlistModel *listModel = self.imageArr[0];
        NSString *str = listModel.imgurl;
        NSURL *url = [NSURL URLWithString:str];
    [imageView sd_setImageWithURL:url placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        imageView.image = image;
    }];
    }
    
     }
-(void)requestData{
    
    [self showHUD];
    lxkHTTPClient *client = [[lxkHTTPClient alloc]initWithBaseURL:@"MainPicture" Dic:[lxkHTTPClient getParametersForPicture:@"1"]];
    __weak typeof(&*self) safeSelf = self;
    [client requestWithParameterCallback:^(id data, NSData *getData, NSString *errorMessage) {
        [self hideHUD];
        NSDictionary *dict = (NSDictionary *)data;
        if ([dict isKindOfClass:[NSDictionary class]]) {
            BaseModel *baseModel = [BaseModel objectWithKeyValues:dict];
            if ([baseModel.result integerValue]==100) {
                safeSelf.pictureModel = [TXDaiHomeViewScrollImageModel objectWithKeyValues:dict];
                //self.imageArr = self.pictureModel.picurllist;
                safeSelf.imageArr = [TXDaiPicurlistModel objectArrayWithKeyValuesArray:safeSelf.pictureModel.picurllist];
                [safeSelf layoutView];
            }else if ([baseModel.result integerValue]==102){
                [UIToastView showToastViewWithContent:baseModel.message andRect:CGRectMake(IISCREEN_WIDTH/2-100, self.view.center.y - 200, 200, 60) andTime:TOASTSHOWTIME andObject:self];
            }
        }
    } errorBlock:^(id data, NSData *getData, NSError *error) {
        [self hideHUD];
        if (safeSelf.noNetWorkView != nil) {
            [safeSelf.noNetWorkView removeFromSuperview];
        }
        safeSelf.noNetWorkView = (UIButton *)[safeSelf addNoNetWorkDefultButtonWithFrame:CGRectMake(0, 0, IISCREEN_WIDTH, IISCREEN_HEIGHT)];
        [safeSelf.view addSubview:safeSelf.noNetWorkView];
    } nonetWorkBlock:^(BOOL nonetWork) {
        [self hideHUD];
        if (safeSelf.noNetWorkView != nil) {
            [safeSelf.noNetWorkView removeFromSuperview];
        }
        safeSelf.noNetWorkView = (UIButton *)[safeSelf addNoNetWorkDefultButtonWithFrame:CGRectMake(0, 0, IISCREEN_WIDTH, IISCREEN_HEIGHT)];
        [safeSelf.view addSubview:safeSelf.noNetWorkView];
    }];

    
}

-(void)share{
    NSLog(@"分享功能");
    [self showShareMenu];
    //1、创建分享参数
  
    
    //        [ShareSDK showShareActionSheet:nil items:nil shareParams:shareParams onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
//            switch (state) {
//                case SSDKResponseStateSuccess:
//                {
//                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
//                                                                        message:nil
//                                                                       delegate:nil
//                                                              cancelButtonTitle:@"确定"
//                                                              otherButtonTitles:nil];
//                    [alertView show];
//                    break;
//                }
//                    
//                    case SSDKResponseStateFail:
//                {
//                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
//                                                                    message:[NSString stringWithFormat:@"%@",error]
//                                                                   delegate:nil
//                                                          cancelButtonTitle:@"OK"
//                                                          otherButtonTitles:nil, nil];
//                    [alert show];
//                    break;
//                }
//                case SSDKResponseStateCancel:{
//                                                 UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
//                                                                                                     message:nil
//                                                                                                    delegate:nil
//                                                                                           cancelButtonTitle:@"确定"
//                                                                                           otherButtonTitles:nil];
//                                                 [alertView show];
//                                                 break;  
//                                             }  
//    
//                default:
//                    break;
//            }
//        }];
        
    
}


-(void)creatShareView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _boardView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, IISCREEN_WIDTH, IISCREEN_HEIGH - 64)];
    //_boardView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _boardView.backgroundColor = [UIColor blackColor];
    _boardView.alpha = 0.5;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked:)];
    [_boardView addGestureRecognizer:tap];
    //[self.view addSubview:_boardView];
    itemSpace = 15;
    itemWidth = (IISCREEN_WIDTH - itemSpace * 5) / 4;
    self.shareView = [[UIView alloc]init];
    _height = 250;
    self.shareView.frame =CGRectMake(0, IISCREEN_HEIGHT, IISCREEN_WIDTH, _height);
    self.shareView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.shareView];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    flowLayout.itemSize = CGSizeMake(itemWidth, itemWidth + itemSpace);
    flowLayout.minimumInteritemSpacing = itemSpace;
    flowLayout.minimumLineSpacing = itemSpace;
    flowLayout.sectionInset = UIEdgeInsetsMake(itemSpace, itemSpace, itemSpace, itemSpace);
    self.shareItem =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, IISCREEN_WIDTH, (itemWidth + itemSpace) + itemSpace*2                                                                                                                                                                                                                                                                                                                                                                                                                                        )  collectionViewLayout:flowLayout];
    [self.shareItem registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.shareItem.backgroundColor = [UIColor whiteColor];
    self.shareItem.scrollEnabled = NO;
    self.shareItem.dataSource = self;
    self.shareItem.delegate = self;
    self.shareItem.showsHorizontalScrollIndicator = NO;
    self.shareItem.showsVerticalScrollIndicator = YES;
    [self.shareView addSubview:self.shareItem];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setFrame:CGRectMake(15, _shareItem.bottom, IISCREEN_WIDTH - 30, 25)];
    [cancelBtn setBackgroundColor:[UIColor whiteColor]];
    [cancelBtn addTarget:self action:@selector(canced:) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:UTILITYCOLOR(@"999999") forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    cancelBtn.layer.borderWidth = 0.5;
    cancelBtn.layer.cornerRadius = 3;
    cancelBtn.layer.masksToBounds = YES;
    cancelBtn.layer.borderColor = UTILITYCOLOR(@"999999").CGColor;
    [self.shareView addSubview:cancelBtn];

    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _titles.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath ];
    CGFloat width = cell.frame.size.width;
    UIImageView *imgIcon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    imgIcon.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_imageNames[indexPath.item] ofType:nil]];
    [cell.contentView addSubview:imgIcon];
    
    UILabel * titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, width + 3, width, cell.frame.size.height - width - 3)];
    titleLabel.textColor = [Utilities colorWithHexString:@"#999999"];
    titleLabel.text = _titles[indexPath.item];
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:titleLabel];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [self shareWithItem:indexPath.item];
}
- (void)tapClicked:(UITapGestureRecognizer *)tap
{
    [self hideShareMenu];
}
- (void)hideShareMenu
{
    [UIView animateWithDuration:0.2 animations:^{
        self.shareView.top = IISCREEN_HEIGH;
        //_boardView.backgroundColor = [UIColor clearColor];
    } completion:^(BOOL finished) {
        _times = 0;
        _clickedNum = 0;
        [_boardView removeFromSuperview];
        
    }];
}

- (void)showShareMenu
{
    if (_times == 0) {
        [self.view addSubview:_boardView];
        [self.view bringSubviewToFront:self.shareView];
        [UIView animateWithDuration:0.2 animations:^{
            self.shareView.top = IISCREEN_HEIGH - _height;
            //_boardView.backgroundColor = [UIColor blackColor];
            //_boardView.alpha = kAlpha;
        } completion:^(BOOL finished) {
            _times++;
        }];
    } else {
        return;
    }
    
}



- (void)canced:(UIButton *)sender
{
    [self hideShareMenu];
}

- (void)shareWithItem:(NSInteger)item
{
//    if (_clickedNum == 0) {
//        [self shareWithApi:item];
//    }else{
//        return;
//    }
//    _clickedNum++;
    [self shareWithApi:item];
}

- (void)shareWithApi:(NSInteger)item{
    
    UIImage *image = [UIImage imageNamed:@"sharePanelView_sinablogbtn_icon_n.png"];
    NSArray *imageArray= @[image];
    if (image) {
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKEnableUseClientShare];
        [shareParams SSDKSetupShareParamsByText:@"分享成功了,赞一个" images:imageArray url:[NSURL URLWithString:@"http://www.baidu.com"] title:@"我是分享标题" type:SSDKContentTypeAuto];
        SSDKPlatformType type =[_types[item]intValue];
        /**
         *  检测客户端是否安装或者设备能不能发送短信
         */
        switch (type) {
            case SSDKPlatformTypeSinaWeibo:
            {
                if (![WeiboSDK isWeiboAppInstalled]) {
                    [self showTostMessageWithText:@"您尚未安装微博"];
                    return ;
                }
            }
                
                break;
            case SSDKPlatformSubTypeWechatSession:
            {
                if (![WXApi isWXAppInstalled]) {
                    //[self.view bringSubviewToFront:_boardView];
                    [self showTostMessageWithText:@"您尚未安装微信"];
                    return ;
                }
            }
                
                break;
            case SSDKPlatformSubTypeWechatTimeline:
            {
                if (![WXApi isWXAppInstalled]) {
                    [self showTostMessageWithText:@"您尚未安装微信"];
                    return ;
                }
                
            }
                
                break;
            case SSDKPlatformSubTypeQQFriend:
            {
                if (![QQApiInterface isQQInstalled]) {
                    [self showTostMessageWithText:@"您尚未安装QQ"];
                    return ;
                }
            }
                
                break;
            case SSDKPlatformSubTypeQZone:
            {
                if (![QQApiInterface isQQInstalled]) {
                    [self showTostMessageWithText:@"您尚未安装QQ"];
                    return ;
                }
            }
                
                break;
            case SSDKPlatformTypeSMS:
            {
                
                NSString *deviceString = [Utilities deviceString];
                
                if ([deviceString rangeOfString:@"iPhone"].location ==  NSNotFound) {
                    [self showTostMessageWithText:@"您的设备不能发送短信"];

                    return ;
                }
                
                //[self hideShareMenu];
            }
                break;
            default:
                break;
        }

        [ShareSDK share:type
             parameters:shareParams
         onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
             switch (state) {//判断分享是否成功
                 case SSDKResponseStateSuccess:{
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                         message:nil
                                                                        delegate:nil
                                                               cancelButtonTitle:@"确定"
                                                               otherButtonTitles:nil];
                     [alertView show];
                     break;
                 }
                 case SSDKResponseStateFail:{
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                         message:[NSString stringWithFormat:@"%@", error]
                                                                        delegate:nil
                                                               cancelButtonTitle:@"确定"
                                                               otherButtonTitles:nil];
                     [alertView show];
                     break;
                 }
                 case SSDKResponseStateCancel:{
                     UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                         message:nil
                                                                        delegate:nil
                                                               cancelButtonTitle:@"确定"
                                                               otherButtonTitles:nil];
                     [alertView show];
                     break;
                 }
                 default:
                     break;
             }                   }];
    }
}

@end
