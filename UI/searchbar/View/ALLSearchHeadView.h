//
//  ALLSearchHeadView.h
//  House
//
//  Created by wang shiwen on 16/3/3.
//  Copyright © 2016年 AiLiuLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ALLSearchHeadViewDelegate<NSObject>

- (void)posViewController;
- (void)cancleBtnCallBack;
- (void)shoppingCarBtnCack;
- (void)searchTextCallBack:(NSString *) searchtext;
@end

@interface ALLSearchHeadView : UIView

@property(nonatomic,assign)id<ALLSearchHeadViewDelegate> delegate;

-(id)initWithFrame:(CGRect )rect;

@end
