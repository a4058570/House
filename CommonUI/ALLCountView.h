//
//  ALLCountView.h
//  ALiuLian
//
//  Created by 张旭 on 16/3/3.
//  Copyright © 2016年 张旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ALLCountViewDelegate <NSObject>

-(void)didNumberChange:(int)number;

@end


@interface ALLCountView : UIView

@property(nonatomic)int maxNumber; //最大数
@property(nonatomic)int minNumber; //最小数  默认是1
@property(nonatomic)int step;  //倍数 默认是1  比如step=10 只能是 10  20 30 10的倍数这种数字 + - 也是以10的倍数变化
@property(nonatomic,weak)id<ALLCountViewDelegate>delegate;


-(void)setCurrentNumber:(int)number;
-(int)currentNumber;
-(void)enabelEdit:(BOOL)enable adjustKeyboardView:(UIView *)view;
@end
