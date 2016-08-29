//
//  Utilities.m
//  Demo1
//
//  Created by 李许康 on 16/7/21.
//  Copyright © 2016年 lxk. All rights reserved.
//

#import "Utilities.h"
#import <CommonCrypto/CommonHMAC.h>//CC_MD5
#include <sys/sysctl.h>

#import<CoreTelephony/CTTelephonyNetworkInfo.h>
#import<CoreTelephony/CTCarrier.h>


#import "Reachability.h"
#define aViewTag                0x402
#define activityViewTag                0x401
@implementation Utilities

+ (NSString*)uuid {
    CFUUIDRef puuid = CFUUIDCreate( nil );
    CFStringRef uuidString = CFUUIDCreateString( nil, puuid );
    NSString * result = (NSString *)CFStringCreateCopy( NULL, uuidString);
    CFRelease(puuid);
    CFRelease(uuidString);
    return [result autorelease];
}

+ (AppDelegate *)applicationDelegate{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

+ (NSString *) md5:(NSString *)str {
    if (str == nil) {
        return nil;
    }
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

/**
 获取服务器地址
 */
+ (NSString *)getHostServerPath {
    NSString * url = KSERVER_ADDRESS;
    
    return url;
    
}

+ (void)callPhone:(NSString *)phoneNumber{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]];
}

//获取两点之间距离
+(CLLocationDistance)getDistanceLatitude:(NSString *)latitude longitude:(NSString *)longitude otherLatitude:(NSString *)otherLatitude otherLongitude:(NSString *)otherLongitude {
    //	NSLog(@"获取距离..%@",[NSString stringWithFormat:@"%f km",[NeardyLocation distanceFromLocation:fromLocation]/1000]);
    CLLocation * location = [[CLLocation alloc] initWithLatitude:[latitude floatValue] longitude:[longitude floatValue]];
    CLLocation * otherLocation = [[CLLocation alloc] initWithLatitude:[otherLatitude floatValue] longitude:[otherLongitude floatValue]];
    CLLocationDistance distance = [location distanceFromLocation:otherLocation];
    [location release];
    [otherLocation release];
    return distance;
}

//把UTF8转码为GB2312
+ (NSString*)UTF8_To_GB2312:(NSString*)utf8string
{
    NSStringEncoding encoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSString *tempString = [utf8string stringByAddingPercentEscapesUsingEncoding:encoding];
    
    return tempString;
}

//把UTF8转码为GBK
+ (NSString*)UTF8_To_GBK:(NSString*)utf8string
{
    NSStringEncoding encoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_2312_80);
    NSString *tempString = [utf8string stringByAddingPercentEscapesUsingEncoding:encoding];
    
    return tempString;
}

+(NSMutableDictionary *)getInterfaceAndParamersUrlByDictionary:(NSString *)businessName paramers:(NSMutableDictionary *)dicParmers{
    int number = rand();
    NSString * md5Str=[Utilities md5:[NSString stringWithFormat:@"messagename=%@&txdairandom=%d%@",businessName,number,WIRELESSCODE] ];
    [dicParmers setObject:businessName forKey:@"messagename"];
    [dicParmers setObject:[NSNumber numberWithInt:number] forKey:@"txdairandom"];
    [dicParmers setObject:md5Str forKey:@"wirelesscode"];
    return dicParmers;
}

//获取颜色
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString hasPrefix:@"0X"]) cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"]) cString = [cString substringFromIndex:1];

    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    //NSLog(@"%f:::%f:::%f",((float) r / 255.0f),((float) g / 255.0f),((float) b / 255.0f));
    
    return SF_COLOR(((float) r / 255.0f),((float) g / 255.0f),((float) b / 255.0f), 1);
}


//检测网络是否可用
+ (BOOL)isExistenceNetwork
{
    BOOL isExistenceNetwork = NO;
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            isExistenceNetwork=NO;
            break;
        case ReachableViaWWAN:
            isExistenceNetwork=YES;
            break;
        case ReachableViaWiFi:
            isExistenceNetwork=YES;
            break;
    }
    return isExistenceNetwork;
}


+ (NSString *)deviceString {
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *name = malloc(size);
    sysctlbyname("hw.machine", name, &size, NULL, 0);
    
    NSString *platform = [NSString stringWithCString:name encoding:NSUTF8StringEncoding];
    free(name);
    
    if([platform isEqualToString:@"iPhone1,1"]) return@"iPhone 2G";
    if([platform isEqualToString:@"iPhone1,2"])  return@"iPhone 3G";
    if([platform isEqualToString:@"iPhone2,1"])  return@"iPhone 3GS";
    if([platform isEqualToString:@"iPhone3,1"])  return@"iPhone 4";
    if([platform isEqualToString:@"iPhone3,2"])  return@"iPhone 4";
    if([platform isEqualToString:@"iPhone3,3"])  return@"iPhone 4 (CDMA)";
    if([platform isEqualToString:@"iPhone4,1"])  return@"iPhone 4S";
    if([platform isEqualToString:@"iPhone5,1"])  return@"iPhone 5";
    if([platform isEqualToString:@"iPhone5,2"])  return@"iPhone 5 (GSM+CDMA)";
    if([platform isEqualToString:@"iPhone5,3"])  return@"iPhone 5C";
    if([platform isEqualToString:@"iPhone5,4"])  return@"iPhone 5C";
    if([platform isEqualToString:@"iPhone6,1"])  return@"iPhone 5S";
    if([platform isEqualToString:@"iPhone6,2"])  return@"iPhone 5S";
    if([platform isEqualToString:@"iPhone7,2"])  return@"iPhone 6";
    if([platform isEqualToString:@"iPhone7,1"])  return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPod1,1"])    return@"iPod Touch (1 Gen)";
    if([platform isEqualToString:@"iPod2,1"])    return@"iPod Touch (2 Gen)";
    if([platform isEqualToString:@"iPod3,1"])    return@"iPod Touch (3 Gen)";
    if([platform isEqualToString:@"iPod4,1"])    return@"iPod Touch (4 Gen)";
    if([platform isEqualToString:@"iPod5,1"])    return@"iPod Touch (5 Gen)";
    
    if([platform isEqualToString:@"iPad1,1"])    return@"iPad";
    if([platform isEqualToString:@"iPad1,2"])    return@"iPad 3G";
    if([platform isEqualToString:@"iPad2,1"])    return@"iPad 2 (WiFi)";
    if([platform isEqualToString:@"iPad2,2"])    return@"iPad 2";
    if([platform isEqualToString:@"iPad2,3"])    return@"iPad 2 (CDMA)";
    if([platform isEqualToString:@"iPad2,4"])    return@"iPad 2";
    if([platform isEqualToString:@"iPad2,5"])    return@"iPad Mini (WiFi)";
    if([platform isEqualToString:@"iPad2,6"])    return@"iPad Mini";
    if([platform isEqualToString:@"iPad2,7"])    return@"iPad Mini (GSM+CDMA)";
    if([platform isEqualToString:@"iPad3,1"])    return@"iPad 3 (WiFi)";
    if([platform isEqualToString:@"iPad3,2"])    return@"iPad 3 (GSM+CDMA)";
    if([platform isEqualToString:@"iPad3,3"])    return@"iPad 3";
    if([platform isEqualToString:@"iPad3,4"])    return@"iPad 4 (WiFi)";
    if([platform isEqualToString:@"iPad3,5"])    return@"iPad 4";
    if([platform isEqualToString:@"iPad3,6"])    return@"iPad 4 (GSM+CDMA)";
    if([platform isEqualToString:@"iPad4,1"])    return@"iPad Air";
    if([platform isEqualToString:@"iPad4,2"])    return@"iPad Air";
    if([platform isEqualToString:@"iPad4,4"])    return@"iPad Mini 2";
    if([platform isEqualToString:@"iPad4,5"])    return@"iPad Mini 2";
    
    if([platform isEqualToString:@"i386"])       return@"Simulator";
    if([platform isEqualToString:@"x86_64"])     return@"Simulator";
    
    return [[UIDevice currentDevice] model];
}

@end




@implementation UIView (UIViewUtils)

- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = ceilf(x);
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = ceilf(y);
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = ceilf(right - frame.size.width);
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = ceilf(bottom - frame.size.height);
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(ceilf(centerX), self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, ceilf(centerY));
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = ceilf(width);
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = ceilf(height);
    self.frame = frame;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (void)removeAllSubviews {
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
}

@end

