//
//  lxkHTTPClient.h
//  Demo1
//
//  Created by 李许康 on 16/8/2.
//  Copyright © 2016年 lxk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>
#import "AFNetworking.h"
typedef void(^callbackBlock)(id data,NSData *getData,NSString *errorMessage);
typedef void(^errorBlock)(id data,NSData *getData,NSError *error);
typedef void(^nonetWorkBlock)(BOOL nonetWork);

@interface lxkHTTPClient : NSObject

- (id)initWithBaseURL:(NSString *)base Dic:(NSDictionary *)dic;
-(void)requestWithParameterCallback:(callbackBlock)callback
                         errorBlock:(errorBlock)errorBlock
                     nonetWorkBlock:(nonetWorkBlock)nonetWorkBlock;
+(NSDictionary *)getParametersForPicture:(NSString *)imageType;

@end
