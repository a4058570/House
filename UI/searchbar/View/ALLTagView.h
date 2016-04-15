//
//  ALLTagView.h
//  House
//
//  Created by wang shiwen on 16/3/3.
//  Copyright © 2016年 AiLiuLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ALLTagViewDelegate <NSObject>

- (void)tagPressCallBack:(NSString *) text;

@end


@interface ALLTagView : UIView

@property (nonatomic,assign)id <ALLTagViewDelegate> delegate;

-(id)initWithFrame:(CGRect )rect;

@end
