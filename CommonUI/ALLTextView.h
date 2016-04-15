//
//  ALLTextView.h
//  ALiuLian
//
//  Created by 张旭 on 15/7/21.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALLTextView : UITextView


//placeHolder
@property(copy,nonatomic) NSString *placeholder;
@property(strong,nonatomic) UIColor *placeholderColor;
@property(strong,nonatomic) UIFont * placeholderFont;





//字数限制
@property(nonatomic)int textNumberLimit;
//是否显示字数限制
@property(nonatomic)BOOL showNumberLimitLabel;
//文字竖直方向居中
@property(nonatomic)BOOL vericalCenter;


-(void)setPlaceholderHidden:(BOOL)hidden;
@end
