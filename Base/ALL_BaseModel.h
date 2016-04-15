//
//  ALL_BaseModel.h
//  AppTest
//
//  Created by 张旭 on 15/4/23.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ALLCellConfig.h"


//配送类型
typedef enum
{
    ALLSend_SelfPick=0,
    ALLSend_Deliver,
    ALLSend_None,  //不支持配送
}ALLSendType;

@class ALLPageModel;
@interface ALL_BaseModel : NSObject



@property(nonatomic,strong)ALLCellConfig *cellConfig;
@property(nonatomic)float cellHeight;


@property(nonatomic,strong)NSString *tag;


-(NSString *)idStrFromDic:(NSDictionary *)dic
                      key:(NSString *)key;
-(int )intValueFromDic:(NSDictionary *)dic
                   key:(NSString *)key;
-(CGFloat)floatValueFromDic:(NSDictionary *)dic
                        key:(NSString *)key;

-(NSString *)stringValueFromDic:(NSDictionary *)dic
                            key:(NSString *)key;

-(BOOL)boolValueFromDic:(NSDictionary *)dic
                    key:(NSString *)key;

-(NSURL *)urlValueFromDic:(NSDictionary *)dic
                      key:(NSString *)key;

-(NSDictionary *)dictValueFromDic:(NSDictionary *)dic
                             key:(NSString *)key;
-(NSArray *)arrayValueFromDic:(NSDictionary *)dic
                          key:(NSString *)key;
//从 字典 创建 数据
//从 字典 创建 数据 数组


-(NSMutableDictionary *)runtimeDic;
-(id)initWithRuntimeDic:(NSDictionary *)dic;
@end
