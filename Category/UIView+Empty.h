//
//  UIView+Empty.h
//  ALiuLian
//
//  Created by 张旭 on 15/7/6.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Empty)
-(void)showEmpty:(NSString *)content;

-(void)showFailed:(NSString *)content;
-(void)removeEmpty;

-(void)showEmpty:(NSString *)content height:(CGFloat)height;

-(void)showFailed:(NSString *)content height:(CGFloat)height;
@end
