//
//  lxkHTTPClient.m
//  Demo1
//
//  Created by 李许康 on 16/8/2.
//  Copyright © 2016年 lxk. All rights reserved.
//

#import "lxkHTTPClient.h"
#import "Reachability.h"
#import "UIDevice+IdentifierAddition.h"
#import "JSONKit.h"

#define HTTPREQUESTVERSION @"1.0"
#define DESKEY @"39d6f0b7"
@interface lxkHTTPClient ()

@property(nonatomic,strong)AFHTTPRequestOperationManager *manager;
@property(nonatomic,strong)NSString *baseUrl;
@property (nonatomic,strong)NSMutableDictionary * requestDict;


@end

@implementation lxkHTTPClient

- (id)initWithBaseURL:(NSString *)base Dic:(NSDictionary *)dic {
    self = [super init];
    if (self) {
        
        self.requestDict = [NSMutableDictionary dictionaryWithCapacity:0];
        NSMutableDictionary * newdict = [NSMutableDictionary dictionaryWithCapacity:0];
        //非贷款端接口加密
        if (![dic.allKeys containsObject:@"urltype"]) {
            NSString * jsonStr = [self encryptUseDES:[dic JSONString] key:DESKEY];
            [newdict setObject:jsonStr forKey:@"param"];
            [newdict setObject:HTTPREQUESTVERSION forKey:@"version"];
        }else{
            [newdict addEntriesFromDictionary:dic];
        }

        self.requestDict = [Utilities getInterfaceAndParamersUrlByDictionary:base paramers:newdict];
        self.baseUrl = [NSString stringWithFormat:@"%@",[Utilities getHostServerPath]];
        NSMutableString * str = [NSMutableString stringWithString:self.baseUrl];
        for (int i = 0; i<self.requestDict.allKeys.count; i++) {
            NSString * key = [self.requestDict.allKeys objectAtIndex:i];
            NSString * value = [self.requestDict objectForKey:key];
            [str appendFormat:@"%@=%@",key,value];
            if (i!=(self.requestDict.allKeys.count-1)) {
                [str appendString:@"&"];
            }
        }
        NSLog(@"url = %@",str);
        
    }
    
    return self;
}

-(void)requestWithParameterCallback:(callbackBlock)callback
                         errorBlock:(errorBlock)errorBlock
                     nonetWorkBlock:(nonetWorkBlock)nonetWorkBlock{
    self.manager = [AFHTTPRequestOperationManager manager];
    self.manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    //添加证书后无法请求到
    if ([self.baseUrl hasPrefix:@"https://"]) {
        AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        securityPolicy.allowInvalidCertificates = YES;
        [AFHTTPRequestOperationManager manager].securityPolicy = securityPolicy;
    }
    self.manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/xml",@"text/html", nil];
    self.manager.responseSerializer = [AFJSONResponseSerializer serializer];
    self.manager.requestSerializer.timeoutInterval = 30;
    [self addRequestHeader];
    
    [self.manager POST:self.baseUrl parameters:self.requestDict success:^(AFHTTPRequestOperation * operation, id responseObject) {
        [operation cancel];
        //id data = [operation.responseData objectFromJSONData];
        id data =responseObject;
        callback( data, responseObject, @"");
 
    } failure:^(AFHTTPRequestOperation * _Nonnull operation, NSError * _Nonnull error) {
        [operation cancel];
        errorBlock(nil,operation.responseData,error);
    }];


    
    
}

- (void)addRequestHeader
{
    
    //当前应用版块号
    
    //应用类型IOS
    
    //当前应用
    NSMutableString *userAgent = [NSMutableString string];
    [userAgent appendString:@"iPhone_txdai"];
    [userAgent appendString:@"~"];
    if ([[UIDevice currentDevice] model]) {
        [userAgent appendString:[Utilities deviceString]];
        [userAgent appendString:@"~"];
    }
    if ([[UIDevice currentDevice] systemVersion]) {
        [userAgent appendString:[[UIDevice currentDevice] systemVersion]];
    }
    [self.manager.requestSerializer setValue:userAgent forHTTPHeaderField:@"User-Agent"];
    NSString * header2 = [NSString stringWithString:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    [self.manager.requestSerializer setValue:header2 forHTTPHeaderField:@"version"];
    
    
    NSString * header3=@"wifi";
    Reachability *r = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    switch ([r currentReachabilityStatus]) {
        case NotReachable:
            // 没有网络连接
            header3=@"no connection";
            break;
        case ReachableViaWWAN:
            // 使用3G网络
            header3=@"gps";
            
            break;
        case ReachableViaWiFi:
            // 使用WiFi网络
            header3=@"wifi";
            
            break;
    }
    [self.manager.requestSerializer setValue:header3 forHTTPHeaderField:@"connmode"];
    NSString * header4 = [NSString stringWithString:[[UIDevice currentDevice] uniqueDeviceIdentifier]];
    [self.manager.requestSerializer setValue:header4 forHTTPHeaderField:@"imei"];
    [self.manager.requestSerializer setValue:@"iphone" forHTTPHeaderField:@"appsystem"];
    [self.manager.requestSerializer setValue:@"txdai" forHTTPHeaderField:@"appname"];
    [self.manager.requestSerializer setValue:[Utilities deviceString] forHTTPHeaderField:@"model"];
    [self.manager.requestSerializer setValue:[[UIDevice currentDevice] systemVersion] forHTTPHeaderField:@"osVersion"];
    [self.manager.requestSerializer setValue:@"" forHTTPHeaderField:@"phoneNumber"];
    [self.manager.requestSerializer setValue:@"" forHTTPHeaderField:@"ispos"];
    [self.manager.requestSerializer setValue:@"" forHTTPHeaderField:@"iscard"];
    [self.manager.requestSerializer setValue:@"gps,wifi" forHTTPHeaderField:@"posmode"];
    [self.manager.requestSerializer setValue:@"920001" forHTTPHeaderField:@"company"];
    
    NSString * cityName = USERCURRENTPROVINCEANDCITY[1];
    if (cityName == nil||cityName.length == 0) {
        cityName = @"";
    }else if([cityName hasSuffix:@"市"]){
        cityName = [cityName stringByReplacingOccurrencesOfString:@"市" withString:@""];
    }
    NSString * encodedString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)cityName, NULL, NULL,  kCFStringEncodingUTF8 ));
    [self.manager.requestSerializer setValue:encodedString forHTTPHeaderField:@"city"];
}



+(NSDictionary *)getParametersForPicture:(NSString *)imageType{
    if (imageType ==nil) {
        imageType = @"";
    }
    NSDictionary *dict = @{
                           @"imageType":imageType
                           };
    return dict;
}




#pragma mark 3.2.2接口字段加密
/**
 *  @Author mahao, 15-07-22 09:07:33
 *
 *  Des根据公钥加密
 *
 *  @param plainText 加密字段
 *  @param key       公钥
 *
 *  @return 加密字符串
 */
- (NSString *) encryptUseDES:(NSString *)plainText key:(NSString *)key

{
    NSString *ciphertext = nil;
    //    NSStringEncoding encoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    // UTF-8转码
    NSData* encryptData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    size_t dataLength = [encryptData length];
    const char *textBytes = (const void *)[encryptData bytes];
    
    //==================
    
    uint8_t *bufferPtr = NULL;
    
    size_t bufferPtrSize = 0;
    
    size_t movedBytes = 0;
    
    bufferPtrSize = (dataLength + kCCBlockSizeDES) & ~(kCCBlockSizeDES - 1);
    
    bufferPtr = malloc( bufferPtrSize * sizeof(uint8_t));
    
    memset((void *)bufferPtr, 0x0, bufferPtrSize);
    
    
    NSString *testString = key;
    
    NSData *testData = [testString dataUsingEncoding: NSUTF8StringEncoding];
    
    Byte *iv = (Byte *)[testData bytes];
    
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmDES,
                                          
                                          kCCOptionPKCS7Padding,
                                          
                                          iv, kCCKeySizeDES,
                                          
                                          iv,
                                          
                                          textBytes, dataLength,
                                          
                                          (void *)bufferPtr, bufferPtrSize,
                                          
                                          &movedBytes);
    
    if (cryptStatus == kCCSuccess) {
        
        ciphertext= [self parseByte2HexString:bufferPtr length:(int)movedBytes];
        
    }
    
    ciphertext=[ciphertext uppercaseString];
    return ciphertext ;
    
}


/**
 *  @Author mahao, 15-07-22 09:07:32
 *
 *  将字符串变为16进制编码，服务端解析16进制
 *
 *
 *  @return 16进制编码字符串
 */
-(NSString *) parseByte2HexString:(Byte *) bytes length:(int)len{

    NSString *hexStr = @"";
    
    if(bytes)
        
    {
        
        for(int i=0;i<len;i++)
            
        {
            
            NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff]; ///16进制数
            
            if([newHexStr length]==1)
                
                hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
            
            else
                
                hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
            
        }
        
    }
    
    NSLog(@"bytes 的16进制数为:%@",hexStr);
    
    return hexStr;
    
}



@end
