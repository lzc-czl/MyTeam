//
//  UIImage+Public.m
//  Demo1
//
//  Created by 李许康 on 16/7/26.
//  Copyright © 2016年 lxk. All rights reserved.
//

#import "UIImage+Public.h"

@implementation UIImage (Public)

//获取纯色图片
+ (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color
{
    UIImage *image;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSaveGState(ctx);
        {
            CGContextSetFillColorWithColor(ctx, color.CGColor);
            CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
        }
        CGContextRestoreGState(ctx);
    }
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

@implementation UIImage (ForTabBarItem)

- (UIImage *)drawImage:(UIImage *)inputImage inRect:(CGRect)frame
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    [self drawInRect:CGRectMake(0.0, 0.0, self.size.width, self.size.height)];
    [inputImage drawInRect:frame];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

//tabbarItem正常背景
+ (UIImage *)normalImageWithImage:(NSString *)imageName title:(NSString *)aTitle
{
    CGSize size = CGSizeMake(IISCREEN_WIDTH / 5.0f, IITAB_BAR_HEIGHT);
    UIImage *image;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextSaveGState(ctx);
        {
            CGContextSetFillColorWithColor(ctx, UTILITYCOLOR(@"#FAFAFA").CGColor);
            CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            
            [UTILITYCOLOR(@"#888888") set];
            NSString *string = aTitle;
            if (!string) {
                string = @"暂无数据····";
            }
            CGSize constraintSize = CGSizeMake(MAXFLOAT, 10);
            CGSize labelSize = [string customsizeWithFont:[UIFont systemFontOfSize:10] constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
            float width = labelSize.width;
            [aTitle drawInRect:CGRectMake((size.width - width) / 2.0f, 32, width, 10) withFont:[UIFont systemFontOfSize:10]];
            
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            UIImage *iconImage = [UIImage imageNamed:imageName];
            [iconImage drawInRect:CGRectMake((size.width - 24) / 2.0f, 8, 24, 24)];
        }
        CGContextRestoreGState(ctx);
    }
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//tabbarItem选中背景
+ (UIImage *)selectedImageWithImage:(NSString *)imageName title:(NSString *)aTitle
{
    CGSize size = CGSizeMake(IISCREEN_WIDTH / 5.0f, IITAB_BAR_HEIGHT);
    UIImage *image;
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextSaveGState(ctx);
        {
            CGContextSetFillColorWithColor(ctx, UTILITYCOLOR(@"#FAFAFA").CGColor);
            CGContextFillRect(ctx, CGRectMake(0, 0, size.width, size.height));
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            [UTILITYCOLOR(@"#DE3031") set];
            NSString *string = aTitle;
            if (!string) {
                string = @"暂无数据····";
            }
            CGSize constraintSize = CGSizeMake(MAXFLOAT, 10);
            CGSize labelSize = [string customsizeWithFont:[UIFont systemFontOfSize:10] constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
            float width = labelSize.width;
            [aTitle drawInRect:CGRectMake((size.width - width) / 2.0f, 32, width, 10) withFont:[UIFont systemFontOfSize:10]];
        }
        CGContextRestoreGState(ctx);
        
        CGContextSaveGState(ctx);
        {
            UIImage *iconImage = [UIImage imageNamed:imageName];
            
            [iconImage drawInRect:CGRectMake((size.width - 24) / 2.0f, 8, 24, 24)];
            
        }
        CGContextRestoreGState(ctx);
        
    }
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


@end
