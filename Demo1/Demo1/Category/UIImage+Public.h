//
//  UIImage+Public.h
//  Demo1
//
//  Created by 李许康 on 16/7/26.
//  Copyright © 2016年 lxk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Public)

//获取纯色图片
+ (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color;

@end

@interface UIImage (ForTabBarItem)

- (UIImage *)drawImage:(UIImage *)inputImage inRect:(CGRect)frame;
//tabbarItem正常背景
+ (UIImage *)normalImageWithImage:(NSString *)imageName title:(NSString *)aTitle;

//tabbarItem选中背景
+ (UIImage *)selectedImageWithImage:(NSString *)imageName title:(NSString *)aTitle;

@end