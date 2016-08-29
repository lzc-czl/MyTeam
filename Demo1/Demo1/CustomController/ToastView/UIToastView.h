//
//  UIToastView.h
//
//
//  Created by 孟庆宇 on 11-12-19.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIToastView : NSObject
{
    UIImageView * toastView;
}

@property (nonatomic,retain) UIImageView * toastView;
+ (void)showToastViewWithContent:(NSString *)content andRect:(CGRect)rect andTime:(float)time andObject:(UIViewController *)selfController;
+ (UIToastView *)sharedToastView;

@end
