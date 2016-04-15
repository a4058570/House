//
//  TextModel.h
//  House
//
//  Created by wang shiwen on 16/3/16.
//  Copyright © 2016年 AiLiuLian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextModel : NSObject<NSCoding>

@property (nonatomic, copy) NSString *no;
@property (nonatomic, assign) double height;
@property (nonatomic, assign) int age;

@end
