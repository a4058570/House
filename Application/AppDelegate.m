//
//  AppDelegate.m
//  House
//
//  Created by wang shiwen on 15/8/24.
//  Copyright (c) 2015年 AiLiuLian. All rights reserved.
//

#import "AppDelegate.h"
#import "AppConfig.h"
/*个推*/
#import "GexinSdk.h"
/*引导页面*/
#import "YJIntroduceVC.h"
/*检测网络*/
#import "ALLReachability.h"
/*主场景*/
#import "MainMapVC.h"

#import "BMapKit.h"

/*底部菜单栏*/
#import "ALLTagController.h"

#import <JSPatch/JSPatch.h>

//第三方 支付id

#ifdef EnterPrice

//企业推送
#define kPushAppId           @"nuftZ9AU0jAcZwIy44Y8g5"
#define kPushAppKey          @"nuftZ9AU0jAcZwIy44Y8g5"
#define kPushAppSecret       @"Hl56JQi29U9wQLVsU1b2P7"

#else

//appstore 推送
#define kPushAppId           @"r7vwzCf9XK7u7Sj1EwgesA"
#define kPushAppKey          @"CuHRTf3Suh7MfnJAbE4wp"
#define kPushAppSecret       @"CuHRTf3Suh7MfnJAbE4wp"

#endif

#define UM_ID  @"559607c867e58e580400052f"

@interface AppDelegate ()
@property(nonatomic,strong)GexinSdk *gexinSdk;


-(void)reachabilityChanged:(NSNotification *)notify;



@end

//NAMESPACE_BAIDU_FRAMEWORK_USE

BMKMapManager* _mapManager;

@implementation AppDelegate

- (void)registerRemoteNotification
{
    
    
    
#ifdef __IPHONE_8_0
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        UIUserNotificationSettings *uns = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound) categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:uns];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
#else
    /*
    UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert|UIRemoteNotificationTypeSound|UIRemoteNotificationTypeBadge);
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
     */
#endif
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"N4n7iklOkku3pNDYtizeIwM7" generalDelegate:self];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor blackColor];
    
    
    // ALLAlertView(@"title", kPushAppId);
    
    /*JSPatch Engine*/
//    [JPEngine startEngine];
//    NSString *sourcePath = [[NSBundle mainBundle] pathForResource:@"demo" ofType:@"js"];
//    NSString *script = [NSString stringWithContentsOfFile:sourcePath encoding:NSUTF8StringEncoding error:nil];
//    [JPEngine evaluateScript:script];
    
    [JSPatch startWithAppKey:JS_PATCH_KEY];
    [JSPatch sync];
    
    //导航 宣传页
    //if ([YJIntroduceVC shouldShowIntro]) {
    //    YJIntroduceVC *intro=[[YJIntroduceVC alloc]initWithNibName:@"YJIntroduceVC" bundle:nil];
    //    self.window.rootViewController = intro;
        
    //}else
    //{
        ALLTagController *tab=[[ALLTagController alloc]init];
        //MainMapVC *mainpage=[[MainMapVC alloc]init];
        [self.window setRootViewController:tab];
        /*
        ALLMyPageTableVC *myPage=[ALLMyPageTableVC loadFromNib];
        ALLTagController *tab=[[ALLTagController alloc]init];
        
        REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:tab menuViewController:myPage];
        frostedViewController.direction = REFrostedViewControllerDirectionLeft;
        // frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
        frostedViewController.liveBlur = NO;
        frostedViewController.blurTintColor=[UIColor colorWithRed:26/255.0 green:29/255.0 blue:41/255.0 alpha:1.0];
        frostedViewController.delegate = self;
        self.window.rootViewController = frostedViewController;
         */
    //}
    
    
    
    
    [self.window makeKeyAndVisible];
    
    
    //    ALLLaucnLockVC *lauchVC= [[ALLLaucnLockVC alloc]init];
    //    lauchVC.enableTouchId=YES;
    //    [nav presentViewController:lauchVC animated:YES completion:nil];
    
    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    //监测网络状况
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    ALLReachability * reach = [ALLReachability reachabilityForInternetConnection];
    [reach startNotifier];

    /*推送信息获取*/
    [self registerRemoteNotification];
    
    NSDictionary* message = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (message) {
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
        [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        //        NSString *payloadMsg = [message objectForKey:@"payload"];
        //        NSString *record = [NSString stringWithFormat:@"[APN]%@, %@", [NSDate date], payloadMsg];
        //        ALLAlertView(@"apn lauch", record);
    }
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [BMKMapView willBackGround];
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
    [BMKMapView didForeGround];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.

}

- (void)onGetNetworkState:(int)iError
{
    if (0 == iError) {
        NSLog(@"联网成功");
    }
    else{
        NSLog(@"onGetNetworkState %d",iError);
    }
    
}

- (void)onGetPermissionState:(int)iError
{
    if (0 == iError) {
        NSLog(@"授权成功");
    }
    else {
        NSLog(@"onGetPermissionState %d",iError);
    }
}


@end
