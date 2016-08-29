//
//  UtilitiesConstants.h
//  Demo1
//
//  Created by 李许康 on 16/7/22.
//  Copyright © 2016年 lxk. All rights reserved.
//

#import <Foundation/Foundation.h>


#define KIOS_TESTSERVER //是否为测试版本

#ifndef KIOS_TESTSERVER //正式服务器
#define KSERVER_ADDRESS @"https://p2p.txdai.com/p2pRefactor/TxdaiService.aspx?" //正式服务器
#define TONGJI_ADDRESS @"https://p2p.txdai.com/p2pRefactor/statisticsservice.aspx?"
#define DBTIME @"https://p2p.txdai.com/commonApi/getCurrentTime.do?site=database" //正式服务器时间

#define MINRECGARGE 0
#define MINDRAWCASH 0
#define WIRELESSCODE @"soufuntxdaihttpapp"

#define SUPPORTBANKCARDLIST  @"http://m.txdai.com/WapPersonalBank/SearchAbleBank.html?src=client"
#define SUPPORTHELPCENTER  @"http://m.txdai.com/newhelp/help.html?src=client"
#define SUPPORTABOUTUS  @"http://m.txdai.com/newhelp/introduce.html?src=client"
#define SUPPORTSAFESECURITY  @"http://wap.txdai.com/Safety.html"
#define SUPPORTCALCULATOR  @"http://wap.txdai.com/calculator.html"
#define PAYPROTOCOLWAPURL  @"http://m.txdai.com/WapPayForCapitalIn/PaymentAgreement.html?src=client&orderid="
//推荐
#define RECOMMEND_GIFT @"http://m.txdai.com/dai/MyShared/IIndex.html?CustomSource=39&pingtai=app"
#define BANKCARDLIST_WAP @"http://m.txdai.com/WapPersonalBank/GetSupportBankList.html?src=client"
#define BAOFUPAY_BUSINESS @"true"//宝付正式环境

#else  //测试服务器

#define KSERVER_ADDRESS @"https://p2ptest.txdai.com/p2pRefactor/TxdaiService.aspx?" //测试服务器
#define TONGJI_ADDRESS @"https://p2ptest.txdai.com/p2pRefactor/statisticsservice.aspx?"
//#define DBTIME @"http://txdaiservice.light.fang.com/commonApi/getCurrentTime.do?site=database&src=client" //测试服务器时间
////#define DBBTIME @"http://txdaiservice.light.fang.com/commonApi/getCurrentTime.do?site=database" //测试服务器时间
#define DBTIME @"https://p2ptest.txdai.com/commonApi/getCurrentTime.do?site=database"
#define MINRECGARGE 0.01
#define MINDRAWCASH 0.1
#define WIRELESSCODE @"soufuntxdaihttpapp"

#define SUPPORTBANKCARDLIST  @"http://lashwap.test.txdai.com/WapPersonalBank/SearchAbleBank.html?src=client"
#define SUPPORTHELPCENTER  @"http://lashwap.test.txdai.com/newhelp/help.html?src=client"
#define SUPPORTABOUTUS  @"http://lashwap.test.txdai.com/newhelp/introduce.html?src=client"
#define SUPPORTSAFESECURITY  @"http://wap.test.txdai.com/Safety.html"
#define SUPPORTCALCULATOR  @"http://wap.test.txdai.com/calculator.html"


#define RECOMMEND_GIFT @"http://m.test.txdai.com/dai/MyShared/IIndex.html?CustomSource=39&pingtai=app"
#define BANKCARDLIST_WAP @"http://lashwap.test.txdai.com/WapPersonalBank/GetSupportBankList.html?src=client"
#define PAYPROTOCOLWAPURL  @"http://lashwap.test.txdai.com/WapPayForCapitalIn/PaymentAgreement.html?src=client&orderid="

#define BAOFUPAY_BUSINESS @"fals"//宝付测试环境
#endif


//describle the notification for mengqingyu


#define TOASTSHOWTIME 2.0f

#define FORCE_LOGOUT @"FORCE_LOGOUT" //强制退出
#define USERLOGINTYPE @"USERLOGINTYPE"

//有状态栏时的屏幕宽度
#define IISCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_WIDTH self.bounds.size.width
//无状态栏时的屏幕高度
#define IISCREEN_HEIGH ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_HEIGH self.bounds.size.height
//有状态栏时的屏幕高度
#define IISCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height - 20)

//设备是否为IPHONE5
#define IIDEVICE_IS_IPHONE5 ([[UIScreen mainScreen] bounds].size.height == 568)

//针对iphone5资源图片，布局应该缩放的比例，例如当前为iphone4 480，则需要将图片缩放到0.84...倍
#define IISCALE_HEIGHT ([[UIScreen mainScreen] bounds].size.height / 568.0)
//请求图片等待图片
#define PlaceholderImage [UIImage imageNamed:@"default_image_min"]
//状态栏高度
#define IISTATUS_BAR_HEIGHT 20.0f

//NavgationBar高度
#define IINAVIGATION_BAR_HEIGHT 44.0f

//tabbar高度
#define IITAB_BAR_HEIGHT 49.0f

#define IIRGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define IIRGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define UTILITYCOLOR(a) [Utilities colorWithHexString:(a)]

#define SEPARATORCOLOR UTILITYCOLOR(@"d2d2d2")
//NSUSERDEFAULTS
#define MYSETNSUSERDEFAULTSDEFINE(a,b) [[NSUserDefaults standardUserDefaults]setObject:(a) forKey:(b)]
#define MYGETNSUSERDEFAULTSDEFINE(a) [[NSUserDefaults standardUserDefaults]objectForKey:(a)]
#define MYREMOVENSUSERDEFAULTSDEFINE(a) [[NSUserDefaults standardUserDefaults] removeObjectForKey:(a)];
//登录状态
#define LOGINSETNSUSERDEFAULTSDEFINE(a)  MYSETNSUSERDEFAULTSDEFINE(a,@"LOGINSTATUS")
#define LOGINGETNSUSERDEFAULTSDEFINE  MYGETNSUSERDEFAULTSDEFINE(@"LOGINSTATUS")
//定位的省份和城市
#define USERCURRENTPROVINCEANDCITY     MYGETNSUSERDEFAULTSDEFINE(@"CurrentUserLocationProvinceAndCity")
//选择银行卡
#define SELECTBANCARDSETNSUSERDEFAULTSDEFINE(a)  MYSETNSUSERDEFAULTSDEFINE(a,@"SELECTBANCARD")
#define SELECTBANCARDGETNSUSERDEFAULTSDEFINE  MYGETNSUSERDEFAULTSDEFINE(@"SELECTBANCARD")
#define SELECTBANCARDREMOVENSUSERDEFAULTSDEFINE  MYREMOVENSUSERDEFAULTSDEFINE(@"SELECTBANCARD")
//服务电话
#define SERVERPHONESETNSUSERDEFAULTSDEFINE(a) MYSETNSUSERDEFAULTSDEFINE(a,@"AppPublicInformation")
#define SERVERPHONEGETNSUSERDEFAULTSDEFINE MYGETNSUSERDEFAULTSDEFINE(@"AppPublicInformation")
#define SERVERPHONEREMOVENSUSERDEFAULTSDEFINE MYREMOVENSUSERDEFAULTSDEFINE(@"AppPublicInformation")

//标题统一Font
#define TITLEFONTDEFINE(a) [UIFont customFontOfSize:(a)]

#define IOS6_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"6.0"] != NSOrderedAscending )
#define IOS7_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS8_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS9_OR_LATER   ( [[[UIDevice currentDevice] systemVersion] compare:@"9.0"] != NSOrderedAscending )
#define IOS6_OR_OLDER   ( [[[UIDevice currentDevice] systemVersion] compare:@"6.9"] == NSOrderedAscending )

#define RegisterProcess @"注册流程"
#define TXJINREGISTERPROCESS @"天下金注册流程"
#define ZHONGHOUREGISTERPROCESS @"众筹注册流程"
#define WithDrawingCash @"提现流程"
#define RECHARGEMONEY @"充值流程"
#define RECHARGEMONEY001 @"充值流程001"
#define ONLYSHOWONCERECHARGEALERT @"onlyshowoncealert"

#define APPAdvertismentShowTime 60*60*4

