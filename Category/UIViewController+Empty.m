//
//  UIView+Empty.m
//  ALiuLian
//
//  Created by 张旭 on 15/6/2.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "UIViewController+Empty.h"
#import "ALLEmptyView.h"
#import <objc/runtime.h>

@implementation UIViewController (Empty)
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
        [self.view addSubview:em];
        em.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2-64);

        
        objc_setAssociatedObject(self, &empty, em, OBJC_ASSOCIATION_RETAIN);
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
        [self.view addSubview:em];
        em.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, height);
        
        
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
        [self.view addSubview:em];
        em.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2-64);
        
        
        objc_setAssociatedObject(self, &failed, em, OBJC_ASSOCIATION_RETAIN);
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
        [self.view addSubview:em];
        em.center=CGPointMake([UIScreen mainScreen].bounds.size.width/2, height);
        
        //em.backgroundColor=[UIColor redColor];
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
