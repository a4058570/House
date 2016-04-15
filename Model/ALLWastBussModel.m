//
//  ALLUserModel.m
//  ALiuLian
//
//  Created by 王诗文 on 15/9/07.
//  Copyright (c) 2015年 王诗文. All rights reserved.
//

#import "ALLWastBussModel.h"
#import "AppConfig.h"

@implementation ALLWastBussModel

-(id)initWithDic:(NSMutableDictionary *)dic
{
    self=[super init];
    if (self) {
        self.name=[self stringValueFromDic:dic key:@"name"];
        self.deskId=[self intValueFromDic:dic key:@"deskId"];
        self.type=[self intValueFromDic:dic key:@"deskType"];
        self.minPeople=[self intValueFromDic:dic key:@"minPeople"];
        self.maxPeople=[self intValueFromDic:dic key:@"maxPeople"];
        self.code=[self intValueFromDic:dic key:@"code"];
    }
    return self;
}

@end





