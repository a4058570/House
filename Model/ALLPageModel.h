//
//  ALLPageModel.h
//  ALiuLian
//
//  Created by 张旭 on 15/5/25.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "ALL_BaseModel.h"

@interface ALLPageModel : ALL_BaseModel
@property(nonatomic)int currentPage;
@property(nonatomic)int totalPage;

-(id)initWithDic:(NSMutableDictionary *)dic;

@end
