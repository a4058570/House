//
//  UINavigationController+ZXTool.h
//  ALiuLian
//
//  Created by 张旭 on 15/5/13.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (ZXTool)

-(void)pushVC:(UIViewController *)controller;

-(void)pushVC:(UIViewController *)controller backTitle:(NSString *)backtitle;
-(void)pushVC:(UIViewController *)controller backTitle:(NSString *)backtitle tintColor:(UIColor *)color;

@end
