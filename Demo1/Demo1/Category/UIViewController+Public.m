//
//  UIViewController+Public.m
//  Demo1
//
//  Created by 李许康 on 16/7/25.
//  Copyright © 2016年 lxk. All rights reserved.
//

#import "UIViewController+Public.h"
#import "YXSpritesLoadingView.h"
@implementation UIViewController (ForNavagationItem)


//设置navgation bar title
- (void)setNavigationItemTitle:(NSString *)title
{
    
    UILabel *label_ = [[UILabel alloc] initWithFrame:CGRectZero];
    NSString *string = title;
    if (!string) {
        string = @"暂无标题";
    }
    CGRect frame_ = CGRectMake(0, 0, 150, 44);
    
    label_.frame = frame_;
    label_.font = [UIFont systemFontOfSize:16];
    label_.textColor = UTILITYCOLOR(@"#FFFFFF");
    label_.text = title;
    label_.backgroundColor = [UIColor clearColor];
    label_.textAlignment = NSTextAlignmentCenter;
    self.navigationItem.titleView = label_;
}

//设置navigationItem rightItem
- (void)rightItemWithImage:(NSString *)imageName
                 andAction:(SEL)action
{
    UIButton *button_ = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    button_.imageEdgeInsets = UIEdgeInsetsMake(9.6, 8.8, 9.6, 8.8);//上左下右
    [button_ setImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
    [button_ setImage:[UIImage imageNamed:imageName] forState:(UIControlStateHighlighted)];
    [button_ addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_];
}

- (void)rightItemWithText:(NSString *)text
                andAction:(SEL)action
{
    UIButton *button_ = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    button_.imageEdgeInsets = UIEdgeInsetsMake(9.6, 8.8, 9.6, 8.8);//上左下右
    [button_ setTitle:text forState:(UIControlStateNormal)];
    [button_ setTitle:text forState:(UIControlStateHighlighted)];
    [button_ setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button_ setTitleColor:[UIColor whiteColor] forState:(UIControlStateHighlighted)];
    [button_ addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    button_.titleLabel.font=[UIFont systemFontOfSize:14];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_];
}

//设置navigationItem leftItem
- (void)leftItemWithImage:(NSString *)imageName
                andAction:(SEL)action
{
    UIButton *button_ = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 16)];
    [button_ setBackgroundImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
    [button_ setBackgroundImage:[UIImage imageNamed:imageName] forState:(UIControlStateHighlighted)];
    [button_ addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_];
}

- (id)addNoNetWorkDefultButtonWithFrame:(CGRect)frame {
    
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:frame];
    bottomView.tag = 6364675;
    bottomView.backgroundColor = [Utilities colorWithHexString:@"#fafafa"];
    
    
    UIImageView *circleImg = [[UIImageView alloc] initWithFrame:CGRectMake((IISCREEN_WIDTH-animationImageWidth)/2, 153 + 10, animationImageWidth, animationImageHeight)];
    circleImg.image = [UIImage imageNamed:@"page_loading_bar"];
    [bottomView addSubview:circleImg];
    
    UIImageView *centerImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, animationImageWidth*0.8, animationImageHeight*0.8)];
    centerImg.backgroundColor = [UIColor clearColor];
    centerImg.center = circleImg.center;
    centerImg.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"page_loading.png"],[UIImage imageNamed:@"page_loading1.png"],[UIImage imageNamed:@"page_loading2.png"] ,[UIImage imageNamed:@"page_loading3.png"],[UIImage imageNamed:@"page_loading4.png"],nil];
    centerImg.animationDuration = 1*5;
    centerImg.animationRepeatCount = 0;
    [bottomView addSubview:centerImg];
    
    
    CABasicAnimation *centerRotation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    centerRotation.fromValue = [NSNumber numberWithFloat:-M_PI_2];
    centerRotation.toValue = [NSNumber numberWithFloat:M_PI_2];
    centerRotation.duration = 1.0;
    centerRotation.repeatCount = MAXFLOAT;
    [centerImg.layer addAnimation:centerRotation forKey:nil];
    
    [centerImg startAnimating];
    
    
    
    
    
    //加载失败的标签栏
    UILabel *loadingLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 153+60, IISCREEN_WIDTH, 30)];
    //    loadingLabel.center = CGPointMake(IISCREEN_WIDTH/2, (IISCREEN_HEIGH/2 + 55));
    loadingLabel.backgroundColor = [UIColor clearColor];
    loadingLabel.font = [UIFont systemFontOfSize:loadingTextFontSize];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    loadingLabel.text = @"加载失败，请检查您的网络";
    loadingLabel.textColor = [UIColor blackColor];
    loadingLabel.numberOfLines = 0;
    [bottomView addSubview:loadingLabel];
    
    
    
    
    
    
    
    
    UIButton *textButton = [UIButton buttonWithType:UIButtonTypeCustom];
    textButton.frame = CGRectMake((IISCREEN_WIDTH-80)/2, 153 + 90, 80, 38);
    textButton.backgroundColor = [UIColor clearColor];
    //    textButton.backgroundColor = [UIColor clearColor];
    [textButton addTarget:self action:@selector(noNetWorkDefultButtonClickde:) forControlEvents:(UIControlEventTouchUpInside)];
    [textButton setTitle:@"点击加载" forState:UIControlStateNormal];
    [textButton setTitle:@"点击加载" forState:UIControlStateHighlighted];
    [textButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [textButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    
    //给button加上边框
    textButton.layer.cornerRadius = 5;
    textButton.layer.masksToBounds = YES;
    textButton.layer.borderWidth = 0.5;
    textButton.layer.borderColor = [UIColor blackColor].CGColor;
    
    [bottomView addSubview:textButton];
    
    [self.view addSubview:bottomView];
    return bottomView;
}

- (void)noNetWorkDefultButtonClickde:(UIButton *)sender {
    //    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:[UtilityHelper applicationDelegate].window animated:YES];
    //    hud.tag = 130697;
    //    [sender removeFromSuperview];
    //    [self  stopHud];
    
    UIView *view = sender.superview;
    if (view.tag == 6364675) {
        
        [view removeFromSuperview];
    }
    
    [self refreshNetWork];
    
}

- (void)stopHud{
    //    [MBProgressHUD hideAllHUDsForView:[UtilityHelper applicationDelegate].window animated:![UtilityHelper isExistenceNetwork]];
    //    [self refreshNetWork];
}

- (void)refreshNetWork {
    NSLog(@"父类刷新网络数据");
}

- (void)barItemWithTitle:(NSString *)title
                   color:(UIColor *)color
                  action:(SEL)action
                    left:(BOOL)isLeft
{
    UIButton *button_ = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 30)];
    [button_ addTarget:self action:action forControlEvents:(UIControlEventTouchUpInside)];
    button_.layer.backgroundColor = color.CGColor;
    button_.layer.borderColor = [UIColor lightTextColor].CGColor;
    button_.layer.cornerRadius = 5;
    button_.layer.borderWidth = 0.01;
    button_.titleLabel.font = [UIFont systemFontOfSize:14];
    button_.titleLabel.adjustsFontSizeToFitWidth = YES;
    button_.titleLabel.text = title;
    
    [button_ setTitle:title forState:(UIControlStateNormal)];
    [button_ setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    
    if (isLeft) {
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_];
    } else {
        
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_];
    }
}

//设置backButton
- (void)addBackButton
{
    [self leftItemWithImage:@"返回正常_03.png" andAction:@selector(backToPrevious)];
}

- (void)backToPrevious
{
    //    [self.navigationController popViewControllerAnimated:YES];
   // id locked = [self.navigationController navigationlock];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)leftItemAndGoBackToFianLoanView:(NSString *)registerTag{
    UIButton *button_ = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 16)];
    [button_ setBackgroundImage:[UIImage imageNamed:@"返回正常_03.png"] forState:(UIControlStateNormal)];
    if ([registerTag isEqualToString:TXJINREGISTERPROCESS]) {
        button_.tag = 20000;
    }else if ([registerTag isEqualToString:ZHONGHOUREGISTERPROCESS]) {
        button_.tag = 20001;
    }else if ([registerTag isEqualToString:RegisterProcess]) {
        button_.tag = 20002;
    }else if ([registerTag isEqualToString:WithDrawingCash]){
        button_.tag = 20003;
    }else if ([registerTag isEqualToString:@"提现"])  {
        button_.tag = 20004;
    }else if ([registerTag isEqualToString:RECHARGEMONEY])  {
        button_.tag = 20005;
    }else if ([registerTag isEqualToString:RECHARGEMONEY001])  {
        button_.tag = 20006;
    }
    
    [button_ setBackgroundImage:[UIImage imageNamed:@"返回正常_03.png"] forState:(UIControlStateHighlighted)];
    [button_ addTarget:self action:@selector(goBackToRootVC:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_];
    
}
- (void)goBackToRootVC:(UIButton *)btnTag {
    
//    if(btnTag.tag == 20000){
//        for (TXDaiViewController * vc in self.navigationController.viewControllers) {
//            if ([vc isKindOfClass:[TxJDetailController class]]) {
//                TxJDetailController * detailView = (TxJDetailController *)vc;
//                id locked = [self.navigationController navigationlock];
//                [self.navigationController popToViewController:detailView animated:YES navigationLock:locked];
//                return;
//            }else if ([vc isKindOfClass:[DTBaoViewController class]]) {
//                DTBaoViewController * detailView = (DTBaoViewController *)vc;
//                id locked = [self.navigationController navigationlock];
//                [self.navigationController popToViewController:detailView animated:YES navigationLock:locked];
//                return;
//            }
//        }
//        return;
//    }
//    
//    if (btnTag.tag == 20002) {
//        id locked = [self.navigationController navigationlock];
//        [self.navigationController popToRootViewControllerAnimated:YES navigationLock:locked];
//    }
//    if (btnTag.tag == 20003) {
//        id locked = [self.navigationController navigationlock];
//        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES navigationLock:locked];
//    }
//    if (btnTag.tag == 20004) {
//        id locked = [self.navigationController navigationlock];
//        [self.navigationController popViewControllerAnimated:YES navigationLock:locked];
//        return;
//    }
//    if (btnTag.tag == 20005) {
//        if ([self isKindOfClass:[TXDaiEditeBankCardViewController class]]) {
//            [[NSUserDefaults standardUserDefaults]setObject:ONLYSHOWONCERECHARGEALERT forKey:ONLYSHOWONCERECHARGEALERT];
//        }
//        id locked = [self.navigationController navigationlock];
//        [self.navigationController popToRootViewControllerAnimated:YES navigationLock:locked];
//        return;
//    }
//    if (btnTag.tag == 20006) {
//        if ([self isKindOfClass:[TXDaiEditeBankCardViewController class]]) {
//            [[NSUserDefaults standardUserDefaults]setObject:ONLYSHOWONCERECHARGEALERT forKey:ONLYSHOWONCERECHARGEALERT];
//        }
//        id locked = [self.navigationController navigationlock];
//        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES navigationLock:locked];
//        return;
//    }
//    
}



- (void)leftItemWithImage:(NSString *)imageName
{
    UIImageView *imageView_ = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 58, 29)];
    imageView_.backgroundColor = [UIColor clearColor];
    imageView_.image = [UIImage imageNamed:imageName];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:imageView_];
}

- (NSString *)getSizeImageWithUrl:(NSString *)url andSize:(NSString *)size{
    if (url != nil) {

        if ([url rangeOfString:@"soufun.com" options:NSCaseInsensitiveSearch].location == NSNotFound && [url rangeOfString:@"soufunimg.com" options:NSCaseInsensitiveSearch].location == NSNotFound) {
            return url;
        }
        if ([url rangeOfString:@"/viewimage" options:NSCaseInsensitiveSearch].location == NSNotFound) {
            if ([url rangeOfString:@"soufun.com" options:NSCaseInsensitiveSearch].location != NSNotFound) {
                url = [url stringByReplacingCharactersInRange:[url rangeOfString:@"soufun.com" options:NSCaseInsensitiveSearch] withString:@"soufun.com/viewimage"];
            } else {
                url = [url stringByReplacingCharactersInRange:[url rangeOfString:@"soufunimg.com" options:NSCaseInsensitiveSearch] withString:@"soufunimg.com/viewimage"];
            }
        }
        NSRange r = [url rangeOfString:@"." options:NSBackwardsSearch];
        url = [url stringByReplacingCharactersInRange:r withString:[NSString stringWithFormat:@"/%@.",size]];
    }
    return url;
}
@end

@implementation UIViewController (HUD)

#pragma mark -
-(void)showTostMessageWithText:(NSString *)text
{
    [UIToastView showToastViewWithContent:text andRect:CGRectMake(IISCREEN_WIDTH/2-100, self.view.center.y - 200, 200, 60) andTime:TOASTSHOWTIME andObject:self];
};

- (void)showHUDWithText:(NSString *)text
             afterDelay:(double)delay
             completion:(MBProgressHUDCompletionBlock)completion
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].windows.firstObject animated:YES];
    
    hud.mode = MBProgressHUDModeCustomView;
    //    hud.labelText = text;
    //    hud.labelFont = [UIFont customFontOfSize:13];
    NSString *string = text;
    if (!string) {
        string = @"暂无更多数据···";
    }
    CGSize constraintSize = CGSizeMake(150, MAXFLOAT);
    CGSize labelSize = [string customsizeWithFont:[UIFont systemFontOfSize:16] constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
    CGFloat height = labelSize.height;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, height)];
    label.adjustsFontSizeToFitWidth = YES;
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:16];
    label.numberOfLines = 0;
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = text;
    hud.customView = label;
    
    double delayInSeconds = delay;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        completion();
        [hud hide:YES];
    });
    
}

#pragma mark -
- (void)showProgressHUDWhileExecutingBlock:(dispatch_block_t)block
                                Completion:(MBProgressHUDCompletionBlock)completion
{
    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        block();
        dispatch_sync(dispatch_get_main_queue(), ^{
            completion();
            [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
        });
    });
}

#pragma mark -
#pragma mark -  显示加载
- (void)showHUD
{
//        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hud.tag = 130697;
//    if (self.navigationController) {
//        if (self != self.navigationController.topViewController||[Utilities applicationDelegate].tabVC.selectedViewController !=self.navigationController) {
//            return;
//        }
//    }
    for (YXSpritesLoadingView *view in self.view.subviews) {
        
        if ([view isKindOfClass:[YXSpritesLoadingView class]]) {
            [view removeFromSuperview];
            
        }
        
    }
    
    if (self.navigationController.navigationBarHidden == NO) {
        [YXSpritesLoadingView showWithView:self.view];
    }else{
        if (IOS7_OR_LATER) {
            [[YXSpritesLoadingView sharedInstance] loadingViewSetupWithLoaderViewFrame: CGRectMake(0, 64, IISCREEN_WIDTH, ((IOS7_OR_LATER?IISCREEN_HEIGHT:IISCREEN_HEIGH)-44)) andView:self.view andImgCenter:loaderViewInitCenter];
        }
        else{
            [[YXSpritesLoadingView sharedInstance] loadingViewSetupWithLoaderViewFrame: CGRectMake(0, 44, IISCREEN_WIDTH, ((IOS7_OR_LATER?IISCREEN_HEIGHT:IISCREEN_HEIGH)-44)) andView:self.view andImgCenter:loaderViewInitCenter];
        }
        
    }
    
    
}
- (void)showLoading{
    MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.tag = 130697;
}

#pragma mark -
#pragma mark -  隐藏加载
- (void)hideHUD
{
//        //    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
//        NSArray *huds = [MBProgressHUD allHUDsForView:self.view];
//        for (MBProgressHUD *hud in huds) {
//            if (hud.tag == 130697) {
//                hud.removeFromSuperViewOnHide = YES;
//                [hud hide:YES];
//            }
//        }
//    if (self.navigationController) {
//        if (self != self.navigationController.topViewController||[Utilities applicationDelegate].tabVC.selectedViewController !=self.navigationController) {
//            return;
//        }
//    }
    [YXSpritesLoadingView dismiss];
    
}
- (void)hideLoading{
    //            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    NSArray *huds = [MBProgressHUD allHUDsForView:self.view];
    for (MBProgressHUD *hud in huds) {
        if (hud.tag == 130697) {
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES];
        }
    }
}

#pragma mark -
- (void)hudWasHidden:(MBProgressHUD *)hud
{
    [hud removeFromSuperview];
    hud = nil;
}

-(BOOL)validateHasTheChineseSpecialCharacter:(NSString *)string{
    NSString *regex = @"^[a-zA-Z0-9\u4e00-\u9fa5_]*$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    
    
    if(![pred evaluateWithObject: string])
    {
        return YES;
        
    }else{
        return NO;
    }
}

- (BOOL)validateMobile:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,183,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[0235-9])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     * 中国联通：China Unicom
     * 130,131,132,152,155,156,185,186
     */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     * 中国电信：China Telecom
     * 133,1349,153,180,189
     */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     * 大陆地区固话及小灵通
     * 区号：010,020,021,022,023,024,025,027,028,029
     * 号码：七位或八位
     */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

- (BOOL)validatePhoneMobile:(NSString *)mobileNum{
    NSString * MOBILE = @"^1(3[0-9]|5[0-9]|8[0-9])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:mobileNum] == YES)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

-(BOOL)validateIDCardNumber:(NSString *)value {
    value = [value stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    int length = 0;
    if (!value) {
        return NO;
    }else {
        length = (int)value.length;
        
        if (length != 15 && length !=18) {
            return NO;
        }
    }
    // 省份代码
    NSArray *areasArray =@[@"11", @"12", @"13", @"14", @"15", @"21", @"22", @"23", @"31", @"32", @"33", @"34", @"35", @"36", @"37", @"41", @"42", @"43", @"44", @"45", @"46", @"50", @"51", @"52", @"53", @"54", @"61", @"62", @"63", @"64", @"65", @"71", @"81", @"82", @"91"];
    
    NSString *valueStart2 = [value substringToIndex:2];
    BOOL areaFlag = NO;
    for (NSString *areaCode in areasArray) {
        if ([areaCode isEqualToString:valueStart2]) {
            areaFlag =YES;
            break;
        }
    }
    
    if (!areaFlag) {
        return NO;
    }
    
    
    NSRegularExpression *regularExpression;
    NSUInteger numberofMatch;
    
    int year = 0;
    switch (length) {
        case 15:
            year = [value substringWithRange:NSMakeRange(6,2)].intValue +1900;
            
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            
            if(numberofMatch > 0) {
                return YES;
            }else {
                return NO;
            }
        case 18:
            
            year = [value substringWithRange:NSMakeRange(6,4)].intValue;
            if (year % 4 ==0 || (year % 100 ==0 && year % 4 ==0)) {
                
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|[1-2][0-9]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];// 测试出生日期的合法性
            }else {
                regularExpression = [[NSRegularExpression alloc] initWithPattern:@"^[1-9][0-9]{5}19[0-9]{2}((01|03|05|07|08|10|12)(0[1-9]|[1-2][0-9]|3[0-1])|(04|06|09|11)(0[1-9]|[1-2][0-9]|30)|02(0[1-9]|1[0-9]|2[0-8]))[0-9]{3}[0-9Xx]$"
                                                                         options:NSRegularExpressionCaseInsensitive
                                                                           error:nil];// 测试出生日期的合法性
            }
            numberofMatch = [regularExpression numberOfMatchesInString:value
                                                               options:NSMatchingReportProgress
                                                                 range:NSMakeRange(0, value.length)];
            
            if(numberofMatch > 0) {
                int S = ([value substringWithRange:NSMakeRange(0,1)].intValue + [value substringWithRange:NSMakeRange(10,1)].intValue) *7 + ([value substringWithRange:NSMakeRange(1,1)].intValue + [value substringWithRange:NSMakeRange(11,1)].intValue) *9 + ([value substringWithRange:NSMakeRange(2,1)].intValue + [value substringWithRange:NSMakeRange(12,1)].intValue) *10 + ([value substringWithRange:NSMakeRange(3,1)].intValue + [value  substringWithRange:NSMakeRange(13,1)].intValue) *5 + ([value substringWithRange:NSMakeRange(4,1)].intValue + [value substringWithRange:NSMakeRange(14,1)].intValue) *8 + ([value substringWithRange:NSMakeRange(5,1)].intValue + [value substringWithRange:NSMakeRange(15,1)].intValue) *4 + ([value substringWithRange:NSMakeRange(6,1)].intValue + [value substringWithRange:NSMakeRange(16,1)].intValue) *2 + [value  substringWithRange:NSMakeRange(7,1)].intValue *1 + [value substringWithRange:NSMakeRange(8,1)].intValue *6 + [value substringWithRange:NSMakeRange(9,1)].intValue *3;
                int Y = S % 11;
                NSString *M = @"F";
                NSString *JYM = @"10X98765432";
                M = [JYM substringWithRange:NSMakeRange(Y,1)]; // 判断校验位
                if ([M isEqualToString:[value substringWithRange:NSMakeRange(17,1)]]) {
                    return YES;// 检测ID的校验位
                }else {
                    return NO;
                }
                
            }else {
                return NO;
            }
        default:
            return NO;
    }
}

//- (void)tongji:(NSString *)messagename{
//    [[[TXDaiHTTPClient alloc]initWithTongJiURL:messagename]requestWithParameterPs001:UTXREQUEST_TYPE_XML_INTERFACE callback:^(id data, NSData *getData, NSString *errorMessage) {
//        
//    } errorBlock:^(id data, NSData *getData, NSError *error) {
//        
//    } nonetWorkBlock:^(BOOL nonetWork) {
//        
//    }];
//}


@end
