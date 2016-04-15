//
//  UITableViewCell+ZXTool.m
//  ALiuLian
//
//  Created by 张旭 on 15/5/12.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "UITableViewCell+ZXTool.h"
#import <objc/runtime.h>
#define TAG  10086
#define TAG2 10010
@implementation UITableViewCell (ZXTool)

static char topLine;
static char bottomLine;
-(void)addlineTo:(ZXCellDir)dir
{
    [self addlineTo:dir color:[UIColor colorWithRed:221/255.0 green:223/255.0 blue:225/255.0 alpha:1.0] height:0.5];
}
-(void)addlineTo:(ZXCellDir)dir color:(UIColor *)color height:(CGFloat)height
{
    CGPoint original;
    char  *key;
    int tag;
    if (dir==ZXCell_Top) {
        original=CGPointMake(0, 0);
        key=&topLine;
        tag=TAG;
    }else
    {
        tag=TAG2;
        key=&bottomLine;
        original=CGPointMake(0, self.bounds.size.height-height);
    }
    BOOL isAdd= [objc_getAssociatedObject(self, key) boolValue];
    if (!isAdd) {
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(original.x, original.y, self.bounds.size.width, height)];
        [lineView setBackgroundColor:color];
        [self addSubview:lineView];
        [lineView setTag:tag];
        objc_setAssociatedObject(self, key, [NSNumber numberWithBool:YES], OBJC_ASSOCIATION_RETAIN);
    }else
    {
        UIView *line= [self viewWithTag:tag];
        [line setFrame:CGRectMake(original.x, original.y, self.bounds.size.width, height)];
    }
  
    
}


-(void)addVeticalLineTo:(CGFloat)x
{
    
}
@end
