//
//  UIView+Empty.m
//  ALiuLian
//
//  Created by 张旭 on 15/7/6.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "UIView+Empty.h"
#import "ALLEmptyView.h"
#import <objc/runtime.h>

@implementation UIView (Empty)
static char empty;
static char failed;
-(void)showEmpty:(NSString *)content
{
    
    ALLEmptyView * emptyView= objc_getAssociatedObject(self, &empty) ;
    if (!emptyView) {
        NSString *str=@"暂时没有数据哦!";
        if (content) {
            str=content;
        }
        ALLEmptyView *em= [[ALLEmptyView alloc]initWithContent:str img:nil];
        [self addSubview:em];
        em.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2-64);
        
        
        objc_setAssociatedObject(self, &empty, em, OBJC_ASSOCIATION_RETAIN);
    }
}

-(void)showFailed:(NSString *)content
{
    ALLEmptyView * emptyView= objc_getAssociatedObject(self, &failed) ;
    if (!emptyView) {
        NSString *str=@"亲 您的网络不太顺畅哦!";
        if (content) {
            str=content;
        }
        ALLEmptyView *em= [[ALLEmptyView alloc]initWithContent:str img:[UIImage imageNamed:@"logoHolder"]];
        [self addSubview:em];
        
        
        em.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2-64);
        
        
        objc_setAssociatedObject(self, &failed, em, OBJC_ASSOCIATION_RETAIN);
    }
}


-(void)showEmpty:(NSString *)content height:(CGFloat)height
{
    ALLEmptyView * emptyView= objc_getAssociatedObject(self, &empty) ;
    if (!emptyView) {
        NSString *str=@"暂时没有数据哦!";
        if (content) {
            str=content;
        }
        ALLEmptyView *em= [[ALLEmptyView alloc]initWithContent:str img:nil];
        [self addSubview:em];
        em.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, height);
        
        
        objc_setAssociatedObject(self, &empty, em, OBJC_ASSOCIATION_RETAIN);
    }
}

-(void)showFailed:(NSString *)content height:(CGFloat)height
{
    ALLEmptyView * emptyView= objc_getAssociatedObject(self, &failed) ;
    if (!emptyView) {
        NSString *str=@"亲 您的网络不太顺畅哦!";
        if (content) {
            str=content;
        }
        ALLEmptyView *em= [[ALLEmptyView alloc]initWithContent:str img:[UIImage imageNamed:@"logoHolder"]];
        [self addSubview:em];
        em.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, height);
        
        
        objc_setAssociatedObject(self, &failed, em, OBJC_ASSOCIATION_RETAIN);
    }
}

-(void)removeEmpty
{
    ALLEmptyView * emptyView= objc_getAssociatedObject(self, &empty) ;
    if (emptyView) {
        [emptyView removeFromSuperview];
        objc_setAssociatedObject(self, &empty, nil, OBJC_ASSOCIATION_RETAIN);
    }
    
    emptyView= objc_getAssociatedObject(self, &failed) ;
    if (emptyView) {
        [emptyView removeFromSuperview];
        objc_setAssociatedObject(self, &failed, nil, OBJC_ASSOCIATION_RETAIN);
    }
}

@end
