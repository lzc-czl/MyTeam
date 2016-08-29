//
//  NSString+Detail.h
//  Demo1
//
//  Created by 李许康 on 16/7/26.
//  Copyright © 2016年 lxk. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface NSString (Detail)
+(NSString *)decimalNumberMutiplyWithString:(NSString *)multiplierValue
                                  andNumber:(int)number;
+(NSString *)decimalNumberMutiplyByPlanWithString:(NSString *)multiplierValue;
+(NSString *)decimalNumberMutiplyByPlanWithString:(NSString *)multiplierValue
                                   andOtherString:(NSString *)othermultiplierValue
                                        andNumber:(int)number;
- (CGSize)customsizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;
- (CGSize)customsizeWithFont:(UIFont *)font ;
-(NSString *)customPlanFloatValue;
-(NSString *)customFormatterString;

@end
