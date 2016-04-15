//
//  GesturePassworld.h
//  ImageTest
//
//  Created by 张旭 on 15/5/9.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum
{
    Gesture_Less=0,
    Gesture_Increct,
    Gesture_None,
}GestureErrorType;

@interface GesturePassworld : UIView

@property(nonatomic,strong,readonly)NSString *currentCode;

-(id)initWithSpace:(CGFloat)space;

-(void)setResultBlock:(void(^)(NSString *code ,GestureErrorType error,GesturePassworld *obj))result;


-(void)reset;
-(void)showWrongState;
@end
