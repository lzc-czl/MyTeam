//
//  UIViewController+Public.h
//  Demo1
//
//  Created by 李许康 on 16/7/25.
//  Copyright © 2016年 lxk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@interface UIViewController (ForNavagationItem)

//设置navigationItem titleView
- (void)setNavigationItemTitle:(NSString *)title;

//设置navigationItem rightItem
- (void)rightItemWithImage:(NSString *)imageName
                 andAction:(SEL)action;
- (void)rightItemWithText:(NSString *)text
                andAction:(SEL)action;
//设置navigationItem leftItem
- (void)leftItemWithImage:(NSString *)imageName
                andAction:(SEL)action;

- (void)barItemWithTitle:(NSString *)title
                   color:(UIColor *)color
                  action:(SEL)action
                    left:(BOOL)isLeft;


//设置backButton
- (void)addBackButton;
- (void)backToPrevious;
- (void)leftItemWithImage:(NSString *)imageName;
- (NSString *)getSizeImageWithUrl:(NSString *)url andSize:(NSString *)size;
- (id)addNoNetWorkDefultButtonWithFrame:(CGRect)frame;//增加没有网络时的默认图片
- (void)refreshNetWork;//刷新网络数据
- (void)leftItemAndGoBackToFianLoanView:(NSString *)registerTag;
@end

@protocol MBProgressHUDDelegate;
@interface UIViewController (HUD)
<MBProgressHUDDelegate>

-(void)showTostMessageWithText:(NSString *)text;
- (void)showHUDWithText:(NSString *)text
             afterDelay:(double)delay
             completion:(MBProgressHUDCompletionBlock)completion;

- (void)showProgressHUDWhileExecutingBlock:(dispatch_block_t)block
                                Completion:(MBProgressHUDCompletionBlock)completion;

- (void)showHUD;
- (void)hideHUD;
- (void)showLoading;
- (void)hideLoading;
-(BOOL)validateHasTheChineseSpecialCharacter:(NSString *)string;
- (BOOL)validateMobile:(NSString *)mobileNum;//手机号码验证
-(BOOL)validateIDCardNumber:(NSString *)value;//身份证验证
- (BOOL)validatePhoneMobile:(NSString *)mobileNum;//手机号码验证

//- (void)tongji:(NSString *)messagename;

@end
