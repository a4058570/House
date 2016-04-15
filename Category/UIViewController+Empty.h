//
//  UIView+Empty.h
//  ALiuLian
//
//  Created by 张旭 on 15/6/2.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Empty)

-(void)showEmpty:(NSString *)content;
-(void)showEmpty:(NSString *)content height:(CGFloat)height;
-(void)showFailed:(NSString *)content;
-(void)showFailed:(NSString *)content height:(CGFloat)height;
-(void)removeEmpty;
@end
