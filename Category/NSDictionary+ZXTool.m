//
//  NSDictionary+ZXTool.m
//  ALiuLian
//
//  Created by 张旭 on 15/6/10.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import "NSDictionary+ZXTool.h"

@implementation NSDictionary (ZXTool)


-(NSString*)dicTojsonString
{
    NSString *jsonString = nil;
    NSError *error;
    //NSJSONWritingPrettyPrinted
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:0 // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
        NSLog(@"Got an error: %@", error);
    } else {
        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return jsonString;
}
@end
