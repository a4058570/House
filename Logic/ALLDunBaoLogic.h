//
//  ALLMallLogic.h
//  ALiuLian
//
//  Created by 王诗文 on 15/10/19.
//  Copyright (c) 2015年 王诗文. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALLDunBaoLogic : NSObject

+(void)getDunBaoAction:(void (^)(BOOL success))result
                failed:(void (^)(int errorCode,NSString *errDes))failed;

@end
