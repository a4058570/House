//
//  UIView+ZXTool.m
//  UEnAi
//
//  Created by zhangxu on 15/3/20.
//  Copyright (c) 2015年 zhangxu. All rights reserved.
//

#import "UIView+ZXTool.h"
#import <objc/runtime.h>

@implementation UIView (ZXTool)
static char topLine;
static char bottomLine;
static char enableAdjustKeyboardKey;
static char adjustKeyboardSpaceKey;
static char adjustKeyboardoffSetKey;


+(id)createFromNib
{
    NSString *classStr=NSStringFromClass([self class]);
    UINib *nib2=[UINib nibWithNibName:classStr bundle:nil];
    NSString *nibPath= [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@~iphone",classStr] ofType:@"nib"];
    BOOL have= [[NSFileManager defaultManager] fileExistsAtPath:nibPath];
    if (!have) {
        nibPath= [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",classStr] ofType:@"nib"];
        have= [[NSFileManager defaultManager] fileExistsAtPath:nibPath];
    }
    if (have) {
        return  [[nib2 instantiateWithOwner:self options:nil] firstObject];
    }else
    {
        return nil;
    }
}


- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}



-(void)addlineTo:(ZXViewDir)dir
{
    [self addlineTo:dir color:[UIColor colorWithRed:221/255.0 green:223/255.0 blue:225/255.0 alpha:1.0] height:0.5];
}
-(void)addlineTo:(ZXViewDir)dir color:(UIColor *)color height:(CGFloat)height
{
    CGPoint original;
    char  *key;
    if (dir==ZXView_Top) {
        original=CGPointMake(0, 0);
        key=&topLine;
    }else
    {
        key=&bottomLine;
        original=CGPointMake(0, self.bounds.size.height-height);
    }
    BOOL isAdd= [objc_getAssociatedObject(self, key) boolValue];
    if (!isAdd) {
        UIView *lineView=[[UIView alloc]initWithFrame:CGRectMake(original.x, original.y, self.bounds.size.width, height)];
        [lineView setBackgroundColor:color];
        [self addSubview:lineView];
        
        objc_setAssociatedObject(self, key, [NSNumber numberWithBool:YES], OBJC_ASSOCIATION_RETAIN);
    }
    
    
}





-(void)enableAdjustForKeyboard:(BOOL)enable
{
    BOOL original=[objc_getAssociatedObject(self, &enableAdjustKeyboardKey) boolValue];
    if (original==enable) {
        return;
    }
    objc_setAssociatedObject(self,&enableAdjustKeyboardKey,[NSNumber numberWithBool:enable],OBJC_ASSOCIATION_RETAIN);
    if (enable) {
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
//        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zx_keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(zx_keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
}
-(void)setAdjustKeyboardVerticalSpace:(CGFloat)verticalSpace
{
    objc_setAssociatedObject(self,&adjustKeyboardSpaceKey,[NSNumber numberWithFloat:verticalSpace],OBJC_ASSOCIATION_RETAIN);
}
-(void)zx_keyboardWillShow:(NSNotification *)noty
{
    BOOL enable=[objc_getAssociatedObject(self, &enableAdjustKeyboardKey) boolValue];
    CGFloat space=[objc_getAssociatedObject(self, &adjustKeyboardSpaceKey) floatValue];
    if (enable) {
        NSDictionary *userInfo = [noty userInfo];
        
        NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
        CGRect keyboardRect = [aValue CGRectValue];
        
        //获取textField当前在window 中的坐标
        CGPoint posInWindow= [[UIApplication sharedApplication].keyWindow convertPoint:self.frame.origin fromView:self.superview];
        CGFloat textFieldH=[UIScreen mainScreen].bounds.size.height-posInWindow.y;
        if (textFieldH-keyboardRect.size.height<space) {
            CGFloat offset=keyboardRect.size.height-textFieldH+self.frame.size.height+space;
            //动画上移
            __weak UIView *weakView=self;
            [UIView animateWithDuration:0.3 animations:^{
                CGRect oldFrame=weakView.frame;
                oldFrame.origin.y-=offset;
                weakView.frame=oldFrame;
            }];
            
            CGFloat upOffset=[objc_getAssociatedObject(self, &adjustKeyboardoffSetKey) floatValue];
            upOffset+=offset;
            objc_setAssociatedObject(self,&adjustKeyboardoffSetKey,[NSNumber numberWithFloat:upOffset],OBJC_ASSOCIATION_RETAIN);
        }
    }
}
-(void)zx_keyboardWillHide:(NSNotification *)noty
{
    CGFloat upOffset=[objc_getAssociatedObject(self, &adjustKeyboardoffSetKey) floatValue];
    BOOL enable=[objc_getAssociatedObject(self, &enableAdjustKeyboardKey) boolValue];
    
    if (enable&&upOffset) {
        __weak UIView *weakView=self;
        [UIView animateWithDuration:0.3 animations:^{
            CGRect oldFrame=weakView.frame;
            oldFrame.origin.y+=upOffset;
            weakView.frame=oldFrame;
        }];
        
        upOffset=0;
        objc_setAssociatedObject(self,&adjustKeyboardoffSetKey,[NSNumber numberWithFloat:upOffset],OBJC_ASSOCIATION_RETAIN);
    }
}





- (void)shake:(int)times withDelta:(CGFloat)delta
{
    [self _shake:times direction:1 currentTimes:0 withDelta:delta andSpeed:0.03 shakeDirection:ShakeDirectionHorizontal completionHandler:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval
{
    [self _shake:times direction:1 currentTimes:0 withDelta:delta andSpeed:interval shakeDirection:ShakeDirectionHorizontal completionHandler:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection
{
    [self _shake:times direction:1 currentTimes:0 withDelta:delta andSpeed:interval shakeDirection:shakeDirection completionHandler:nil];
}

- (void)shake:(int)times withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection completionHandler:(void (^)(void))completionHandler
{
    [self _shake:times direction:1 currentTimes:0 withDelta:delta andSpeed:interval shakeDirection:shakeDirection completionHandler:completionHandler];
}

- (void)_shake:(int)times direction:(int)direction currentTimes:(int)current withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection completionHandler:(void (^)(void))completionHandler
{
    [UIView animateWithDuration:interval animations:^{
        self.layer.affineTransform = (shakeDirection == ShakeDirectionHorizontal) ? CGAffineTransformMakeTranslation(delta * direction, 0) : CGAffineTransformMakeTranslation(0, delta * direction);
    } completion:^(BOOL finished) {
        if(current >= times) {
            [UIView animateWithDuration:interval animations:^{
                self.layer.affineTransform = CGAffineTransformIdentity;
            } completion:^(BOOL finished){
                if (completionHandler) {
                    completionHandler();
                }
                
            }];
            return;
        }
        [self _shake:(times - 1)
           direction:direction * -1
        currentTimes:current + 1
           withDelta:delta
            andSpeed:interval
      shakeDirection:shakeDirection
   completionHandler:completionHandler];
    }];
}





@end