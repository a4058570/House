//
//  NSString+ZXTool.h
//  ALiuLian
//
//  Created by 张旭 on 15/5/22.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZXTool)


- (NSString *) md5;
+(NSString*)encodeString:(NSString*)unencodedString;
+(NSString *)decodeString:(NSString*)encodedString;


+(NSString *)stringFromTimeStrap:(NSInteger )timer
                      dateFormat:(NSString *)formatString;

+ (NSString *)getDateStringWithDate:(NSDate *)date
                         DateFormat:(NSString *)formatString;

+(BOOL) isBlankString:(NSString *)string;
+(NSString *)updateTimeForTime:(NSInteger)timer;


-(NSDictionary *)jsonStringToDic;
+(NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim;

+(NSString *)jsonObjectToString:(NSObject *)obj;
@end
