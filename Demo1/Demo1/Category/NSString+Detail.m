//
//  NSString+Detail.m
//  Demo1
//
//  Created by 李许康 on 16/7/26.
//  Copyright © 2016年 lxk. All rights reserved.
//

#import "NSString+Detail.h"

@implementation NSString (Detail)

/**
 *  @author mahao, 15-12-01 15:12:14
 *
 *  保留小数点后两位，四舍五入
 *
 *  @param multiplierValue 数字
 *  @param number          保留位数
 *
 *  @return 保留后的数字
 */
+(NSString *)decimalNumberMutiplyWithString:(NSString *)multiplierValue
                                  andNumber:(int)number
{
    
    NSDecimalNumberHandler *multiplierNumber = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                                                      scale:number
                                                
                                                                                           raiseOnExactness:NO
                                                
                                                                                            raiseOnOverflow:NO
                                                
                                                                                           raiseOnUnderflow:NO
                                                
                                                                                        raiseOnDivideByZero:YES];
    NSDecimalNumber * orign                  = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber * multiply               = [NSDecimalNumber decimalNumberWithString:@"1"];
    NSDecimalNumber * result                 = [orign decimalNumberByMultiplyingBy:multiply withBehavior:multiplierNumber];
    return [result stringValue];
}
/**
 *  @author mahao, 15-12-01 15:12:01
 *
 *  百分比，只舍不入
 *
 *  @param multiplierValue 数字
 *
 *  @return 保留后的数字
 */
+(NSString *)decimalNumberMutiplyByPlanWithString:(NSString *)multiplierValue
{
    
    NSDecimalNumberHandler *multiplierNumber = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                                      scale:0
                                                
                                                                                           raiseOnExactness:NO
                                                
                                                                                            raiseOnOverflow:NO
                                                
                                                                                           raiseOnUnderflow:NO
                                                
                                                                                        raiseOnDivideByZero:YES];
    NSDecimalNumber * orign                  = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber * multiply               = [NSDecimalNumber decimalNumberWithString:@"100"];
    NSDecimalNumber * result                 = [orign decimalNumberByMultiplyingBy:multiply withBehavior:multiplierNumber];
    return [result stringValue];
}
/**
 *  @author mahao, 15-12-01 15:12:47
 *
 *  保留小数点后两位，四舍五入
 *
 *  @param multiplierValue      数字
 *  @param othermultiplierValue 数字
 *  @param number               保留位数
 *
 *  @return 保留后的数字
 */
+(NSString *)decimalNumberMutiplyByPlanWithString:(NSString *)multiplierValue
                                   andOtherString:(NSString *)othermultiplierValue
                                        andNumber:(int)number
{
    
    NSDecimalNumberHandler *multiplierNumber = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundBankers
                                                                                                      scale:number
                                                
                                                                                           raiseOnExactness:NO
                                                
                                                                                            raiseOnOverflow:NO
                                                
                                                                                           raiseOnUnderflow:NO
                                                
                                                                                        raiseOnDivideByZero:YES];
    NSDecimalNumber * orign                  = [NSDecimalNumber decimalNumberWithString:multiplierValue];
    NSDecimalNumber * multiply               = [NSDecimalNumber decimalNumberWithString:othermultiplierValue];
    NSDecimalNumber * result                 = [orign decimalNumberByMultiplyingBy:multiply withBehavior:multiplierNumber];
    return [result stringValue];
}
/**
 *  @author mahao, 15-12-01 18:12:02
 *
 *  计算文字所占面积
 *
 */
- (CGSize)customsizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode{
    
    CGSize customsize = CGSizeZero;
    if (IOS7_OR_LATER) {
        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        customsize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    }else{
        customsize = [self sizeWithFont:font constrainedToSize:size lineBreakMode:lineBreakMode];
    }
    return customsize;
}

- (CGSize)customsizeWithFont:(UIFont *)font {
    
    CGSize customsize = CGSizeZero;
    if (IOS7_OR_LATER) {
        NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        customsize = [self sizeWithAttributes:dic];
    }else{
        customsize = [self sizeWithFont:font];
    }
    return customsize;
}


-(NSString *)customPlanFloatValue{
    
    NSDecimalNumberHandler *multiplierNumber = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                                      scale:2
                                                
                                                                                           raiseOnExactness:NO
                                                
                                                                                            raiseOnOverflow:NO
                                                
                                                                                           raiseOnUnderflow:NO
                                                
                                                                                        raiseOnDivideByZero:YES];
    NSDecimalNumber * orign                  = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber * multiply               = [NSDecimalNumber decimalNumberWithString:@"100"];
    NSDecimalNumber * result                 = [orign decimalNumberByMultiplyingBy:multiply withBehavior:multiplierNumber];
    NSNumberFormatter *numFormatter          = [[NSNumberFormatter alloc] init];
    [numFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *newStr                         = [numFormatter stringFromNumber:result];
    return newStr;
}


-(NSString *)customFormatterString{
    
    NSDecimalNumberHandler *multiplierNumber = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                                                      scale:12
                                                
                                                                                           raiseOnExactness:NO
                                                
                                                                                            raiseOnOverflow:NO
                                                
                                                                                           raiseOnUnderflow:NO
                                                
                                                                                        raiseOnDivideByZero:YES];
    NSDecimalNumber * orign                  = [NSDecimalNumber decimalNumberWithString:self];
    NSDecimalNumber * multiply               = [NSDecimalNumber decimalNumberWithString:@"1"];
    NSDecimalNumber * result                 = [orign decimalNumberByMultiplyingBy:multiply withBehavior:multiplierNumber];
    NSNumberFormatter *numFormatter          = [[NSNumberFormatter alloc] init];
    [numFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSString *newStr                         = [numFormatter stringFromNumber:result];
    return newStr;
}

@end
