//
//  TXDaiHomeViewScrollImageModel.h
//  txdai
//
//  Created by 陳凱歌 on 14/11/5.
//  Copyright (c) 2014年 陳凱歌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXDaiHomeViewScrollImageModel : NSObject
@property (strong, nonatomic) NSString *result;
@property (strong, nonatomic) NSString *message;
@property (strong, nonatomic) NSString *isshowloanproject;
@property (strong, nonatomic) NSMutableArray *picurllist;
@end

@interface TXDaiPicurlistModel : NSObject
@property (nonatomic, copy) NSString *imgurl;
@property (nonatomic, copy) NSString *linkurl;
@property (nonatomic, copy) NSString *pagetitle;
@end



