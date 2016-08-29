//
//  Utilities.h
//  Demo1
//
//  Created by 李许康 on 16/7/21.
//  Copyright © 2016年 lxk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "AppDelegate.h"

#define SF_COLOR(RED, GREEN, BLUE, ALPHA)	[UIColor colorWithRed:RED green:GREEN blue:BLUE alpha:ALPHA]

@class AppDelegate;
@interface Utilities : NSObject

+ (NSString*)uuid;
+ (AppDelegate *)applicationDelegate;
+ (NSString *) md5:(NSString *)str;
+ (void)callPhone:(NSString *)phoneNumber;
+ (NSString *)getHostServerPath;

+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;
//获得两点之间的距离
+(CLLocationDistance)getDistanceLatitude:(NSString *)latitude longitude:(NSString *)longitude otherLatitude:(NSString *)otherLatitude otherLongitude:(NSString *)otherLongitude;

+ (BOOL)isExistenceNetwork;
//把UTF8转码为GB2312
+ (NSString*)UTF8_To_GB2312:(NSString*)utf8string;
//把UTF8转码为GBK
+ (NSString*)UTF8_To_GBK:(NSString*)utf8string;

+(NSMutableDictionary *)getInterfaceAndParamersUrlByDictionary:(NSString *)businessName paramers:(NSMutableDictionary *)dicParmers;


+ (NSString *)deviceString ;

@end

@interface UIView (UIViewUtils)

- (CGFloat)left;
- (void)setLeft:(CGFloat)x;
- (CGFloat)top;
- (void)setTop:(CGFloat)y;
- (CGFloat)right;
- (void)setRight:(CGFloat)right;
- (CGFloat)bottom;
- (void)setBottom:(CGFloat)bottom;
- (CGFloat)centerX;
- (void)setCenterX:(CGFloat)centerX;
- (CGFloat)centerY;
- (void)setCenterY:(CGFloat)centerY;
- (CGFloat)width;
- (void)setWidth:(CGFloat)width;
- (CGFloat)height;
- (void)setHeight:(CGFloat)height;
- (CGPoint)origin;
- (void)setOrigin:(CGPoint)origin;
- (CGSize)size;
- (void)setSize:(CGSize)size;
- (void)removeAllSubviews;

@end