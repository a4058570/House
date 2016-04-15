//
//  UINavigationBar+BackgroundColor.h
//  ALiuLian
//
//  Created by 张旭 on 15/5/11.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (ZXTool)
-(void)removeShadowLine;
- (void)lt_setBackgroundColor:(UIColor *)backgroundColor;
- (void)lt_setContentAlpha:(CGFloat)alpha;
- (void)lt_setTranslationY:(CGFloat)translationY;
- (void)lt_reset;
@end
