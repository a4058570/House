//
//  UIView+ZXTool.h
//  UEnAi
//
//  Created by zhangxu on 15/3/20.
//  Copyright (c) 2015年 zhangxu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    ZXView_Top=0,
    ZXView_Bottom=1
}ZXViewDir;

typedef NS_ENUM(NSInteger, ShakeDirection) {
    ShakeDirectionHorizontal = 0,
    ShakeDirectionVertical
};


@interface UIView (ZXTool)

@property (nonatomic) CGFloat left;        ///< Shortcut for frame.origin.x.
@property (nonatomic) CGFloat top;         ///< Shortcut for frame.origin.y
@property (nonatomic) CGFloat right;       ///< Shortcut for frame.origin.x + frame.size.width
@property (nonatomic) CGFloat bottom;      ///< Shortcut for frame.origin.y + frame.size.height
@property (nonatomic) CGFloat width;       ///< Shortcut for frame.size.width.
@property (nonatomic) CGFloat height;      ///< Shortcut for frame.size.height.
@property (nonatomic) CGFloat centerX;     ///< Shortcut for center.x
@property (nonatomic) CGFloat centerY;     ///< Shortcut for center.y
@property (nonatomic) CGPoint origin;      ///< Shortcut for frame.origin.
@property (nonatomic) CGSize  size;        ///< Shortcut for frame.size.

+(id)createFromNib;

//view 添加 上下分割线
-(void)addlineTo:(ZXViewDir)dir;
-(void)addlineTo:(ZXViewDir)dir color:(UIColor *)color height:(CGFloat)height;

//view 根据键盘弹出的高度 自动提高
-(void)enableAdjustForKeyboard:(BOOL)enable;
-(void)setAdjustKeyboardVerticalSpace:(CGFloat)verticalSpace;



/*********shake*********/
/**-----------------------------------------------------------------------------
 * @name UIView+Shake
 * -----------------------------------------------------------------------------
 */
- (void)shake:(int)times withDelta:(CGFloat)delta;
- (void)shake:(int)times withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval;
- (void)shake:(int)times withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection;

/** Shake the UIView at a custom speed
 *
 * Shake the text field a given number of times with a given speed, with a completion handler
 *
 * @param times The number of shakes
 * @param delta The width of the shake
 * @param interval The duration of one shake
 * @param direction of the shake
 * @param completionHandler to be called when the view is done shaking
 */
- (void)shake:(int)times withDelta:(CGFloat)delta andSpeed:(NSTimeInterval)interval shakeDirection:(ShakeDirection)shakeDirection completionHandler:(void(^)(void))completionHandler;

@end


