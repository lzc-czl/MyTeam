//
//  AppDelegate.m
//  Demo1
//
//  Created by 李许康 on 16/4/27.
//  Copyright © 2016年 lxk. All rights reserved.
//

#import "AppDelegate.h"
#import "TabBarViewController.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"
//#import <RennSDK/RennSDK.h>

//#define APP_ID @"414478124"//微信appid
#define APP_ID @"946377115"//房天下appid

@interface AppDelegate ()

@property (nonatomic,strong) NSString *appurl;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    TabBarViewController *barVC = [[TabBarViewController alloc]init];
    self.tabVC = barVC;
    self.window.rootViewController =barVC;
    self.window.backgroundColor = [UIColor whiteColor];
    //[self checkUpgrade];
    [self initShareSDK];

    // Override point for customization after application launch.
    return YES;
}

//检查更新
-(void)checkUpgrade{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.securityPolicy = [AFSecurityPolicy defaultPolicy];
    NSString *url = [NSString stringWithFormat:@"https://itunes.apple.com/lookup?id=%@",APP_ID];
    [manager POST:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        int resultCount = [[responseObject objectForKey:@"resultCount"] intValue];
        if(resultCount != 0){
            NSString *appstoreVersion = [[responseObject objectForKey:@"results"][0] objectForKey:@"version"];
            if(appstoreVersion != nil){
                NSString *localVersion = [self getCurrentAppVersion];
                NSLog(@"latest app version %@ ; localVersion:%@",appstoreVersion,localVersion);
                NSInteger local = [[localVersion stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
                NSInteger appstore = [[appstoreVersion stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
                self.appurl = [[responseObject objectForKey:@"results"][0] objectForKey:@"trackViewUrl"];
                
                if(local < appstore){
                    UIAlertView *alert= [[UIAlertView alloc] initWithTitle:@"版本更新提示" message:@"发现新版本,是否确定要更新？" delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:@"稍后再说", nil];
                    alert.tag = 10001;
                    [alert show];
                    //                    [UIAlertView displayAlertWithTitle:@"版本更新提示" message:@"发现新版本,是否确定要更新？" leftButtonTitle:@"取消" leftButtonAction:nil rightButtonTitle:@"更新" rightButtonAction:^(){
                    //                        NSString *appurl = [[responseObject objectForKey:@"results"][0] objectForKey:@"trackViewUrl"];
                    //                        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:appurl]];
                    //                    }];
                }
            }
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error ----%@",error.userInfo);
    }];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex ==0) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.appurl]];
    }
    
}

//分享平台初始化

-(void)initShareSDK{
    //房天下 698f5927bc6f
    //1617debf33ab0
    [ShareSDK registerApp:@"1617debf33ab0"
     
          activePlatforms:@[@(SSDKPlatformTypeSinaWeibo),
                                                            @(SSDKPlatformSubTypeQQFriend),
//                                                             @(SSDKPlatformTypeSinaWeibo),
//                                                             @(SSDKPlatformTypeSMS),
                                                            @(SSDKPlatformSubTypeWechatSession),
                                                             @(SSDKPlatformSubTypeWechatTimeline)]
         onImport:^(SSDKPlatformType platformType) {
             switch (platformType) {
                 case SSDKPlatformTypeQQ:
                     [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                     break;
                   case SSDKPlatformTypeSinaWeibo:
                     [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                     break;
                     case SSDKPlatformTypeWechat:
                     [ShareSDKConnector connectWeChat:[WXApi class]];
                     break;
                 default:
                     break;
             }
    } onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo) {
        switch (platformType) {
            case SSDKPlatformTypeSinaWeibo:
                //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                //appKey 2089132940
                //appSecret 85bd63082e46c128e40f43c628c48b6d
            //房天下1526271141
                //5c370facfe10993c508cb1d65832a08f
                [appInfo SSDKSetupSinaWeiboByAppKey:@"2089132940"
                                          appSecret:@"85bd63082e46c128e40f43c628c48b6d"
                                        redirectUri:@"http://www.sharesdk.cn"
                                           authType:SSDKAuthTypeBoth];
                break;
//                //微信   wx74dc7731e0e5df7d    64693304bc5340c85157d226aec5a69a
                case SSDKPlatformTypeWechat:
                [appInfo SSDKSetupWeChatByAppId:@"wx74dc7731e0e5df7d" appSecret:@"64693304bc5340c85157d226aec5a69a"];
                break;
//                //QQ
//                //APP ID1105618742
//               // APP BXnGEdeDItRO431q
//                //房天下1103992299
//                //f9587caa7804d53b551e1b3f7d029ec8
                case SSDKPlatformTypeQQ:
                [appInfo SSDKSetupQQByAppId:@"1105618742" appKey:@"BXnGEdeDItRO431q" authType:SSDKAuthTypeBoth];
                break;
                
            default:
                break;
        }
    }];
    
}


- (NSString *)getCurrentAppVersion
{
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [infoDict objectForKey:@"CFBundleShortVersionString"];
    return version;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
