//
//  YXSpritesLoadingView.h
//  Gogobot-iOS
//
//  Created by Yin Xu on 05/14/14.
//  Copyright (c) 2014 Yin Xu. All rights reserved.
//

#import "YXSpritesLoadingView.h"


@implementation YXSpritesLoadingView
{
    UIView *loaderView;
    UIImageView *loadingImageView;
    UIImageView *loadingCircleImageView;
//    FBShimmeringView *shimmeringView;
//    UILabel *loadingLabel;
//    UIButton *loadingButton;
    UIWindow *window;
    int adjustHeightForLoader; //when we set shouldBlockCurrentViewUserIntercation to YES
                               //we leave 64 pixel on the top of the screen for the nav bar
                               //so we need adjust the center point of loader
    
    BOOL _isAnmationing;
    
}

#pragma mark - Class Methods
+ (YXSpritesLoadingView *)sharedInstance
{
	static dispatch_once_t once = 0;
	static YXSpritesLoadingView *sharedInstance;
	dispatch_once(&once, ^{
        sharedInstance = [[YXSpritesLoadingView alloc] init];
    });
	return sharedInstance;
}

#pragma mark - Initialization Methods
- (id)init
{
    self = [super initWithFrame: [UIScreen mainScreen].bounds];
//    self.backgroundColor = [UIColor greenColor];
    self.backgroundColor = [Utilities colorWithHexString:@"#fafafa"];
    id<UIApplicationDelegate> delegate = [[UIApplication sharedApplication] delegate];
    window = [delegate respondsToSelector:@selector(window)] ? [delegate performSelector:@selector(window)] : [[UIApplication sharedApplication] keyWindow];
    self.alpha = 1;
    [self addCustomView];
    return self;
}

- (void)addCustomView  {

    loaderView = [[UIView alloc] init];
    loaderView.backgroundColor = [Utilities colorWithHexString:@"#fafafa"];
//    loaderView.backgroundColor = [UIColor greenColor];
    
//    if (loaderView.superview == nil)
//    {
//        [window addSubview:loaderView];
//    }
    
    
    //加载失败的标签栏
//    loadingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, IISCREEN_WIDTH, 30)];
//    loadingLabel.center = CGPointMake(IISCREEN_WIDTH/2, (IISCREEN_HEIGH/2 + 55));
//    loadingLabel.backgroundColor = [UIColor clearColor];
//    loadingLabel.font = [UIFont customFontOfSize:loadingTextFontSize];
//    loadingLabel.textAlignment = NSTextAlignmentCenter;
//    //    loadingLabel.text = text;
//    loadingLabel.textColor = [UIColor blackColor];
//    loadingLabel.numberOfLines = 0;
    //    [loaderView addSubview:loadingLabel];
    
    
    //加载失败的按钮

//    loadingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    loadingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
//    loadingButton.center = CGPointMake(IISCREEN_WIDTH/2, (IISCREEN_HEIGH/2+ 95));
//    loadingButton.backgroundColor = [UIColor clearColor];
//    loadingButton.titleLabel.font = [UIFont customFontOfSize:16];
//    [loadingButton setTitle:@"点击加载" forState:UIControlStateNormal];
//    [loadingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    
//    //给按钮加上边框
//    loadingButton.layer.cornerRadius = 5;
//    loadingButton.layer.masksToBounds = YES;
//    loadingButton.layer.borderWidth = 0.5;
//    loadingButton.layer.borderColor = [UIColor blackColor].CGColor;
//    [loadingButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

//    loadingButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    loadingButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
//    loadingButton.center = CGPointMake(IISCREEN_WIDTH/2, (IISCREEN_HEIGH/2+ 95));
//    loadingButton.backgroundColor = [UIColor clearColor];
//    loadingButton.titleLabel.font = [UIFont customFontOfSize:16];
//    [loadingButton setTitle:@"点击加载" forState:UIControlStateNormal];
//    [loadingButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    //给按钮加上边框
//    loadingButton.layer.cornerRadius = 5;
//    loadingButton.layer.masksToBounds = YES;
//    loadingButton.layer.borderWidth = 0.5;
//    loadingButton.layer.borderColor = [UIColor blackColor].CGColor;
//    [loadingButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];

    //    [loaderView addSubview:loadingButton];
    
    
    loadingImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, animationImageWidth*0.8, animationImageHeight*0.8)];
    loadingImageView.backgroundColor = [UIColor clearColor];
    loadingImageView.center = CGPointMake(IISCREEN_WIDTH/2, IISCREEN_HEIGH/2 - 40);
    loadingImageView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"page_loading.png"],[UIImage imageNamed:@"page_loading1.png"],[UIImage imageNamed:@"page_loading2.png"],[UIImage imageNamed:@"page_loading3.png"],[UIImage imageNamed:@"page_loading4.png"], nil];
    loadingImageView.animationDuration = 1*5;
    loadingImageView.animationRepeatCount = 0;
    [loaderView addSubview:loadingImageView];
    
    
    loadingCircleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, animationImageWidth, animationImageHeight)];
    loadingCircleImageView.image = [UIImage imageNamed:@"page_loading_bar"];
    loadingCircleImageView.center = loadingImageView.center;
    [loaderView addSubview:loadingCircleImageView];
    
    
}


+ (void)showWithView:(UIView *)view {

    if ([view isMemberOfClass:[UIWindow class]]) {
        [[YXSpritesLoadingView sharedInstance] loadingViewSetupWithLoaderViewFrame: CGRectMake(0, 64, IISCREEN_WIDTH, ((IOS7_OR_LATER?IISCREEN_HEIGHT:IISCREEN_HEIGH)-44)) andView:view andImgCenter:loaderViewInitCenter];
    }
    else{
    [[YXSpritesLoadingView sharedInstance] loadingViewSetupWithLoaderViewFrame: loaderViewInitFrame andView:view andImgCenter:loaderViewInitCenter];
    }

}

+ (void)showWithLoaderViewFrame:(CGRect)frame andView:(UIView *)view andImgCenter:(CGPoint)center
{
    
    [[YXSpritesLoadingView sharedInstance] loadingViewSetupWithLoaderViewFrame:frame andView:view andImgCenter:center];
}


+ (void)dismiss
{
    [[YXSpritesLoadingView sharedInstance] loadingViewHide];
}



#pragma mark - Helper Methods
- (void)loadingViewSetupWithLoaderViewFrame:(CGRect)frame andView:(UIView *)view andImgCenter:(CGPoint)center
{

    
    if (loaderView.superview) {
        
        [loaderView removeFromSuperview];
    }
    
    
    
    
//    NSLog(@"**********%@",frame);
    
    NSLog(@"^^^^^^^^^^^^&&&&&&^^^^^^^^^^^%f",frame.origin.y);
//    NSAssert(frame.origin.y != 68, @"^^^^^^^^^^^^^^^");
    loaderView.frame = frame;
    loadingImageView.center = center;
    if (view != nil) {
        
        [view addSubview:loaderView];
        

    }else {
        
        [loaderView removeFromSuperview];
        
        [window addSubview:loaderView];
        

    }
    loadingCircleImageView.center = center;
    
    loaderView.backgroundColor = [Utilities colorWithHexString:@"#fafafa"];
    
    [UIView animateWithDuration:0.0 delay:0.0 options:  UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionCurveLinear animations:^{
        
        loaderView.alpha = 1;
        
    } completion:^(BOOL finished) {
        

        if (!_isAnmationing) {
            
            _isAnmationing = YES;
       
            CABasicAnimation *fullRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
            fullRotation.fromValue = [NSNumber numberWithFloat:0];
            fullRotation.toValue = [NSNumber numberWithFloat:MAXFLOAT];
            fullRotation.duration = MAXFLOAT * 0.15;
            [loadingCircleImageView.layer addAnimation:fullRotation forKey:nil];

            
            CABasicAnimation *centerRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
            centerRotation.fromValue = [NSNumber numberWithFloat:-M_PI_2];
            centerRotation.toValue = [NSNumber numberWithFloat:M_PI_2];
            centerRotation.duration = 1.0;
            centerRotation.repeatCount = MAXFLOAT;
            [loadingImageView.layer addAnimation:centerRotation forKey:nil];
            [loadingImageView startAnimating];
            
        }else {
            
            _isAnmationing = NO;
            [loadingImageView stopAnimating];
            [loadingCircleImageView.layer removeAllAnimations];
            
            [self loadingViewSetupWithLoaderViewFrame: frame andView:view andImgCenter:center];
        }
     
    }];
    
 
}


- (void)loadingViewHide
{

    
//    [UIView animateWithDuration:0.0 delay:0.0 options:  UIViewAnimationOptionTransitionCrossDissolve | UIViewAnimationOptionCurveLinear animations:^{
//
//        loaderView.alpha = 0;
//        
//    } completion:^(BOOL finished) {
//        
//        _isAnmationing = NO;
//        
//        [loadingCircleImageView.layer removeAllAnimations];
//        [loadingImageView.layer removeAllAnimations];
//        
//        [loaderView removeFromSuperview];
//    }];
   
           _isAnmationing = NO;
    
           [loadingCircleImageView.layer removeAllAnimations];
           [loadingImageView.layer removeAllAnimations];
  
           [loaderView removeFromSuperview];

}

//- (NSArray *)imagesForAnimating
//{
//    NSArray *retVal = [NSArray arrayWithObjects:[UIImage imageNamed:@"page_loading.png"],[UIImage imageNamed:@"page_loading1.png"],[UIImage imageNamed:@"page_loading2.png"], nil];
//
////    for(int i = 0; i < numberOfFramesInAnimation; i++)
////    {
////        [retVal addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%@%d",spriteNameString, i]]];
////    }
//    return retVal;
//}


//计算标签栏的高度
//- (int)getTextHeight:(NSString*)text andFont: (UIFont *)font andWidth:(float)width {
//    CGSize constrain = CGSizeMake(width, 1000000);
//    return [text boundingRectWithSize:constrain options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font} context:Nil].size.height;
//}


@end
