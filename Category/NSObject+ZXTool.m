//
//  NSObject+ZXTool.m
//  ALiuLian
//
//  Created by 张旭 on 15/7/24.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "NSObject+ZXTool.h"
#import <objc/runtime.h>
@implementation NSObject (ZXTool)
static NSString *kHandlerAssociatedKey = @"kZXObjectTagStringKey";


-(void)setTagString:(NSString *)tagString
{
    objc_setAssociatedObject(self, (__bridge const void *)(kHandlerAssociatedKey), tagString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSString *)tagString
{
     NSString *str = objc_getAssociatedObject(self, (__bridge const void *)(kHandlerAssociatedKey));
    return str;
}
@end
