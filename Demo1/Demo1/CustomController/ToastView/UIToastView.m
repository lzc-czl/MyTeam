//
//  NeighborToastView.m
//  iphone_neighbor
//
//  Created by 孟庆宇 on 11-12-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "UIToastView.h"
#import <QuartzCore/QuartzCore.h>
#import "MBProgressHUD.h"

@interface UIToastView  ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger time;
@property (nonatomic, strong) MBProgressHUD *hud;
@end

@implementation UIToastView
@synthesize toastView;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
    [toastView release];
    [super dealloc];
}

+ (UIToastView  *)sharedToastView
{
    static UIToastView  *toast = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        toast = [[UIToastView  alloc] init];
    });
    return toast;
}

+ (void)showToastViewWithContent:(NSString *)content andRect:(CGRect)rect andTime:(float)time andObject:(UIViewController *)selfController{
    [[UIToastView sharedToastView] showViewWithContent:content andRect:rect andTime:time andObject:selfController];
    
}

- (void)showViewWithContent:(NSString *)content andRect:(CGRect)rect andTime:(float)time andObject:(UIViewController *)selfController
{
    if (!content||[content isEqualToString:@""]) {
        return;
    }
    
    if (self.hud != nil) {
        [self.hud hide:YES];
    }
    
    self.hud = [MBProgressHUD showHUDAddedTo:selfController.view animated:YES];
    
    if (IOS7_OR_LATER) {
        self.hud.yOffset = -([UIScreen mainScreen].bounds.size.height-20)/4;
    }else{
        self.hud.yOffset = -[UIScreen mainScreen].bounds.size.height/4;
    }
    self.hud.mode = MBProgressHUDModeCustomView;
    self.hud.tag = 130698;
    //    hud.labelText = text;
    //    hud.labelFont = [UIFont customFontOfSize:13];
    NSString *string = content;
    if (!string) {
        string = @"暂无更多数据···";
    }
    CGSize constraintSize = CGSizeMake(150, MAXFLOAT);
    CGSize labelSize = [string customsizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat height = labelSize.height;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, height)];
    
    label.adjustsFontSizeToFitWidth = YES;
    label.backgroundColor = [UIColor clearColor];
    label.opaque = YES;
    label.font = [UIFont systemFontOfSize:14];
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    label.textAlignment =NSTextAlignmentCenter;
    label.text = content;
    self.hud.customView = label;
    
    if (self.timer != nil) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
    self.time = time;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(hideHUD) userInfo:nil repeats:NO];
    [self.timer fire];
    
}

- (void)hideHUD
{
    [self.hud hide:YES afterDelay:self.time];
}


@end
