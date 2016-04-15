//
//  ALLGrientView.h
//  ALiuLian
//
//  Created by 张旭 on 15/5/25.
//  Copyright (c) 2015年 张旭. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALLGrientView : UIView

@property(nonatomic,strong)NSArray *colors;
@property(nonatomic,strong)NSArray *locations;
@property(nonatomic)CGPoint startPoint;
@property(nonatomic)CGPoint endPoint;

@end
