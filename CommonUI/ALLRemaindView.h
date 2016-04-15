//
//  ALLRemaindView.h
//  ALiuLian
//
//  Created by 张旭 on 15/12/30.
//  Copyright © 2015年 张旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALLRemaindView : UIView


@property(nonatomic,copy)void (^tapBlock)(ALLRemaindView *remaindView);

@property(nonatomic,strong)UIImage *image;
@property(nonatomic,strong)NSString *content;
@property(nonatomic,strong)NSString *tagString;


@property(nonatomic)CGFloat verticalSpace;
@end
