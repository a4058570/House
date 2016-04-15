//
//  qqButton.h
//  QQ空间
//
//  Created by 妖精的尾巴 on 15-9-4.
//  Copyright (c) 2015年 妖精的尾巴. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface qqButton : UIButton

/**
 *设置按钮的圆角半径
 */
- (void)setCornerRadius:(CGFloat)cornerRadius;
/**
 *设置按钮的变宽宽度和颜色
 */
- (void)setBorderWidth:(CGFloat)width andColor:(UIColor *)color;

@end
