//
//  ALLPageModel.m
//  ALiuLian
//
//  Created by 张旭 on 15/5/25.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "ALLPageModel.h"

@implementation ALLPageModel


-(id)initWithDic:(NSMutableDictionary *)dic
{
    self=[super init];
    if (self) {
        self.totalPage=[[dic objectForKey:@"totalPage"] intValue];
        self.currentPage=[[dic objectForKey:@"toPage"] intValue];
    }
    return self;
}

- (id)copy;
{
    return self;
}
- (id)mutableCopy
{
    return self;
}

@end
