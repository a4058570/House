//
//  ALL_BaseModel.m
//  AppTest
//
//  Created by 张旭 on 15/4/23.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "ALL_BaseModel.h"
#import <objc/runtime.h>
@implementation ALL_BaseModel



-(NSString *)idStrFromDic:(NSMutableDictionary *)dic
                      key:(NSString *)key
{
    NSObject *obj=  [dic objectForKey:key];
    if (obj==nil||[obj isKindOfClass:[NSNull class]]) {
        return nil;
    }
    if ([obj isKindOfClass:[NSString class]]) {
        return (id)obj;
    }else if ([obj isKindOfClass:[NSNumber class]])
    {
        NSNumber *number=(id)obj;
        return [NSString stringWithFormat:@"%ld",[number integerValue]];
    }
    return (id)obj;
}
-(int )intValueFromDic:(NSDictionary *)dic
                   key:(NSString *)key
{
    NSNumber *obj=[dic objectForKey:key];
    if (obj&&![obj isKindOfClass:[NSNull class]]) {
       return  [obj intValue];
    }
    return 0;
}

-(CGFloat)floatValueFromDic:(NSDictionary *)dic
                        key:(NSString *)key
{
    NSNumber *obj=[dic objectForKey:key];
    if (obj&&![obj isKindOfClass:[NSNull class]]) {
        return  [obj doubleValue];
    }
    return 0;
}
-(NSString *)stringValueFromDic:(NSDictionary *)dic
                            key:(NSString *)key
{
    NSNumber *obj=[dic objectForKey:key];
    if (obj&&![obj isKindOfClass:[NSNull class]]) {
        if ([obj isKindOfClass:[NSString class]]) {
            if (((NSString *)obj).length>0) {
                return (NSString *)obj;
            }else
            {
                return nil;
            }
        }else
        {
            NSString *str=[obj stringValue];
            if (str.length>0) {
                return str;
            }else
            {
                return nil;
            }
        }
    }
    return nil;
}

-(BOOL)boolValueFromDic:(NSDictionary *)dic
                    key:(NSString *)key
{
    NSNumber *obj=[dic objectForKey:key];
    if (obj&&![obj isKindOfClass:[NSNull class]]) {
        
        return [obj boolValue];
    }
    return NO;
}

-(NSURL *)urlValueFromDic:(NSDictionary *)dic
                      key:(NSString *)key
{
    NSString *obj=[dic objectForKey:key];
    
    if (obj&&![obj isKindOfClass:[NSNull class]]) {
        if ([obj isKindOfClass:[NSURL class]]) {
            return (NSURL *)obj;
        }
        if (obj.length<=0) {
            return nil;
        }
        //obj = [obj stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        return [NSURL URLWithString:obj];
    }
    return nil;
}

-(NSDictionary *)dictValueFromDic:(NSDictionary *)dic
                              key:(NSString *)key
{
    NSDictionary *obj=[dic objectForKey:key];
    if (obj&&![obj isKindOfClass:[NSNull class]]) {
        
        return obj;
    }
    return nil;
}
-(NSArray *)arrayValueFromDic:(NSDictionary *)dic
                          key:(NSString *)key
{
    NSArray *obj=[dic objectForKey:key];
    if (obj&&![obj isKindOfClass:[NSNull class]]) {
        
        return obj;
    }
    return nil;
}



-(NSMutableDictionary *)runtimeDic
{
    //获取当前实体类中所有属性名
    NSMutableDictionary *dic=[NSMutableDictionary dictionary];
    
    unsigned int numIvars; //成员变量个数
    Ivar *vars = class_copyIvarList([self class], &numIvars);
    NSString *key=nil;
    for(int i = 0; i < numIvars; i++) {
        Ivar thisIvar = vars[i];
        key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  //获取成员变量的名字
        id value=[self valueForKey:key];
        value=[self baseValueFromModelValue:value];
        [dic setValue:value forKey:key];
        
    }
    free(vars);//记得释放掉
    return dic;
}
-(id)initWithRuntimeDic:(NSDictionary *)dic
{
    self=[super init];
    if (self) {
        
        unsigned int numIvars; //成员变量个数
        Ivar *vars = class_copyIvarList([self class], &numIvars);
        NSString *key=nil;
        for(int i = 0; i < numIvars; i++) {
            Ivar thisIvar = vars[i];
            key = [NSString stringWithUTF8String:ivar_getName(thisIvar)];  //获取成员变量的名字
            id value=[dic objectForKey:key];
            if (value) {
                value=[self modelValueFromBaseValue:value];
                [self setValue:value forKey:key];
            }   
        }
        free(vars);//记得释放掉
        
    }
    return self;
}

-(id )baseValueFromModelValue:(id)value
{
    id baseValue=value;
    if ([value isKindOfClass:[ALL_BaseModel class]]) {
        ALL_BaseModel *model=value;
        NSMutableDictionary *modelDic= [model runtimeDic];
        [modelDic setObject:NSStringFromClass([model class]) forKey:@"cls"];
        baseValue=modelDic;
    }else if([value isKindOfClass:[NSArray class]])
    {
        //遍历数组
        NSMutableArray *valueArr=[NSMutableArray array];
        for(NSObject *obj in value)
        {
            id convertValue= [self baseValueFromModelValue:obj];
            if (convertValue) {
                [valueArr addObject:convertValue];
            }
        }
        baseValue=valueArr;
    }
    return baseValue;
}
-(id)modelValueFromBaseValue:(id)value
{
    id modelValue=value;
    
    
    if ([value isKindOfClass:[NSDictionary class]]) {
        //字典类型 判断是否有 cls 字符串
        NSString *classString= [value objectForKey:@"cls"];
        if (classString) {
             Class cls= NSClassFromString(classString);
             ALL_BaseModel *model=[[cls alloc] initWithRuntimeDic:value];
            modelValue=model;
        }
    }else if ([value isKindOfClass:[NSArray class]])
    {
        NSMutableArray *arr=@[].mutableCopy;
        for(NSObject *obj in value)
        {
            id arrValue =[self modelValueFromBaseValue:obj];
            if (arrValue) {
                [arr addObject:arrValue];
            }
        }
        modelValue=arr;
    }
    
    return modelValue;
}
@end
