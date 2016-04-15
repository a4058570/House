//
//  ALLGlobalData.h
//  ALiuLian
//
//  Created by 王诗文 on 15/11/12.
//  Copyright (c) 2015年 王诗文. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ALLGlobalFunction : NSObject

//push到另一个vc
+(void)pushVC:(UIViewController *)curVC
     targetVC:(UIViewController *)vc;

//获取当前最顶层的viewController
+ (UIViewController *)appRootViewController;

//验证是否全是数字 0-9
+ (BOOL)validateNumber:(NSString*)number;

//设置活动导航条样式
+(void) setActionStyleNavigationBar : (UIViewController *) delegate;

//设置正常导航条样式
+(void) setNormalStyleNavigationBar : (UIViewController *) delegate;

//对比版本号
+ (BOOL)compareVersionNumber:(NSString *)currentVersion :(NSString *)latestVersion;

//view 弹出特效
+ (void)exFadeIn:(UIView *)changeOutView dur:(CFTimeInterval)dur;//渐隐渐现 弹出
+ (void)exScaleOut:(UIView *)changeOutView dur:(CFTimeInterval)dur center:(CGPoint)point delegate:(id)object action:(SEL)action;//放大弹出

//纯色图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

//网络图片返回 UIImage
+(UIImage *) getImageFromURL:(NSURL *)fileURL;

@end
