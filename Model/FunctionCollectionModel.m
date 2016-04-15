//
//  ALLPageModel.m
//  ALiuLian
//
//  Created by 张旭 on 15/5/25.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "FunctionCollectionModel.h"

@implementation FunctionCollectionModel


-(id)initWithDic:(NSMutableDictionary *)dic
{
    self=[super init];
    if (self) {
        self.type = [dic objectForKey:@"type"];
        self.iconName = [dic objectForKey:@"iconName"];
        self.funName = [dic objectForKey:@"funName"];
    }
    return self;
}
@end
