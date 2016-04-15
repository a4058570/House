//
//  ALLGlobalData.m
//  ALiuLian
//
//  Created by 张旭 on 15/5/20.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "ALLGlobalData.h"


@interface ALLGlobalData()

@end

@implementation ALLGlobalData


+(ALLGlobalData *)shareInstance
{
    static ALLGlobalData *sharedAccountManagerInstance123 = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        sharedAccountManagerInstance123 = [[ALLGlobalData alloc] init];
     
    });
    return sharedAccountManagerInstance123;
}

@end
