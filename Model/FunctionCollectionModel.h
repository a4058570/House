//
//  ALLPageModel.h
//  ALiuLian
//
//  Created by 张旭 on 15/5/25.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "ALL_BaseModel.h"

@interface FunctionCollectionModel : ALL_BaseModel

@property(nonatomic)NSString *type;
@property(nonatomic,weak) NSString*iconName;
@property(nonatomic,weak) NSString*funName;

-(id)initWithDic:(NSMutableDictionary *)dic;

@end
