//
//  ALLGlobalData.m
//  ALiuLian
//
//  Created by 王诗文 on 15/11/12.
//  Copyright (c) 2015年 王诗文. All rights reserved.
//

#import "ALLGlobalFunction.h"


@interface ALLGlobalFunction()
@end

@implementation ALLGlobalFunction

+(void)pushVC:(UIViewController *)curVC
             :(UIViewController *)targetVC
{
    targetVC.hidesBottomBarWhenPushed=YES;
    [curVC.navigationController pushViewController:targetVC animated:YES];
    
}

+ (BOOL)validateNumber:(NSString*)number
{
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}


+ (UIViewController *)appRootViewController
{
    UIViewController *appRootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *topVC = appRootVC;
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}


+(void)setActionStyleNavigationBar : (UIViewController *) delegate
{
    //    //设置导航条
    //    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:52/255.0 green:49/255.0 blue:63/255.0 alpha:1.0]];
    //    //设置导航条是否透明
    //    [UINavigationBar appearance].translucent=false;
    //    //设置字体为白色
    //    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //    //设置返回键颜色
    //    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    //设置导航条
    [delegate.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:52/255.0 green:49/255.0 blue:63/255.0 alpha:1.0]];
    
    //设置导航条是否透明
    delegate.navigationController.navigationBar.translucent=false;
    
    //设置字体为白色
    [delegate.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    //设置返回键颜色
    [delegate.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
}

+(void) setNormalStyleNavigationBar : (UIViewController *) delegate
{
    //    //设置导航条
    //    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    //    //设置导航条是否透明
    //    [UINavigationBar appearance].translucent=true;
    //    //设置字体为白色
    //    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    //    //设置返回键颜色
    //    [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
    
    //设置导航条
    [delegate.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    //设置导航条是否透明
    delegate.navigationController.navigationBar.translucent=true;
    
    //设置字体为白色
    [delegate.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    //设置返回键颜色
    [delegate.navigationController.navigationBar setTintColor:[UIColor blackColor]];
}

+ (BOOL)compareVersionNumber:(NSString *)currentVersion :(NSString *)latestVersion
{
    
    NSArray *curVersionArray = [currentVersion componentsSeparatedByString:@"."];
    NSArray *lastVersionArray = [latestVersion componentsSeparatedByString:@"."];
    
    for (int i=0; i<lastVersionArray.count; i++) {
        int lastVersionNumber=[[lastVersionArray objectAtIndex:i] intValue];
        
        if (i<=curVersionArray.count-1) {
            int curVersionNumber=[[curVersionArray objectAtIndex:i] intValue];
            
            if (lastVersionNumber>curVersionNumber) {
                return YES;
            }else if(curVersionNumber>lastVersionNumber){
                return NO;
            }
        }else{
            return YES;
        }
    }
    
    
    return NO;
}

//弹出动画
+ (void)exFadeIn:(UIView *)changeOutView dur:(CFTimeInterval)dur
{
    changeOutView.alpha=0;
    [UIView animateWithDuration:dur animations:^(){
        changeOutView.alpha=1.0;
    } completion:^(BOOL finished) {
        
    }];
}

+ (void)exScaleOut:(UIView *)changeOutView  dur:(CFTimeInterval)dur center:(CGPoint)point delegate:(id)object action:(SEL)action
{
    changeOutView.center=point;
    changeOutView.transform=CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:dur delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.8 options:UIViewAnimationOptionCurveLinear animations:^{
        changeOutView.transform=CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
        if (action && object) {
            if ([object respondsToSelector:action]) {
                NSLog(@"回调成功...");
                [object performSelector:action];
            }else{
                NSLog(@"回调失败...");
            }
        }
        
    }];
}

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

+(UIImage *) getImageFromURL:(NSURL *)fileURL {
    //NSLog(@"执行图片下载函数");
    UIImage * result;
    NSData * data = [NSData dataWithContentsOfURL:fileURL];
    result = [UIImage imageWithData:data];
    return result;
}

@end
